// JNI side of the maplibre_native Android plugin: initializes the MapLibre
// Native C library for Android, creates the Vulkan device that render
// sessions borrow, and wraps Flutter's surfaces as Vulkan surfaces.

#define VK_USE_PLATFORM_ANDROID_KHR
#include <android/log.h>
#include <android/native_window_jni.h>
#include <dlfcn.h>
#include <jni.h>
#include <vulkan/vulkan.h>

#include <cstring>
#include <map>
#include <mutex>
#include <string>
#include <vector>

namespace {

constexpr const char* kTag = "maplibre_native";

// mln_diagnostic from maplibre_native_c/base.h.
struct MlnDiagnostic {
  uint32_t size;
  char message[4096];
};
using MlnAndroidInit = int32_t (*)(void* jni_env, void* context,
                                   MlnDiagnostic* out_diagnostic);

struct Vulkan {
  VkInstance instance = VK_NULL_HANDLE;
  VkPhysicalDevice physical_device = VK_NULL_HANDLE;
  VkDevice device = VK_NULL_HANDLE;
  VkQueue queue = VK_NULL_HANDLE;
  uint32_t queue_family_index = 0;
};

std::mutex g_mutex;
Vulkan g_vulkan;
std::string g_vulkan_error;
std::map<VkSurfaceKHR, ANativeWindow*> g_surfaces;

bool HasExtension(const std::vector<VkExtensionProperties>& extensions,
                  const char* name) {
  for (const auto& extension : extensions) {
    if (std::strcmp(extension.extensionName, name) == 0) return true;
  }
  return false;
}

void ThrowIllegalState(JNIEnv* env, const std::string& message) {
  jclass type = env->FindClass("java/lang/IllegalStateException");
  env->ThrowNew(type, message.c_str());
}

// Creates the process-wide device: Vulkan 1.1 with the surface extensions,
// the features the C API's test fixture enables, and VK_KHR_swapchain, which
// surface sessions need.
bool CreateVulkan(std::string* error) {
  const char* instance_extensions[] = {VK_KHR_SURFACE_EXTENSION_NAME,
                                       VK_KHR_ANDROID_SURFACE_EXTENSION_NAME};
  VkApplicationInfo application{VK_STRUCTURE_TYPE_APPLICATION_INFO};
  application.pApplicationName = "maplibre_native";
  application.apiVersion = VK_API_VERSION_1_1;
  VkInstanceCreateInfo instance_info{VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO};
  instance_info.pApplicationInfo = &application;
  instance_info.enabledExtensionCount = 2;
  instance_info.ppEnabledExtensionNames = instance_extensions;
  if (vkCreateInstance(&instance_info, nullptr, &g_vulkan.instance) !=
      VK_SUCCESS) {
    *error = "vkCreateInstance failed. The device may lack Vulkan 1.1.";
    return false;
  }

  uint32_t device_count = 0;
  vkEnumeratePhysicalDevices(g_vulkan.instance, &device_count, nullptr);
  std::vector<VkPhysicalDevice> devices(device_count);
  vkEnumeratePhysicalDevices(g_vulkan.instance, &device_count, devices.data());
  for (VkPhysicalDevice physical_device : devices) {
    uint32_t extension_count = 0;
    vkEnumerateDeviceExtensionProperties(physical_device, nullptr,
                                         &extension_count, nullptr);
    std::vector<VkExtensionProperties> extensions(extension_count);
    vkEnumerateDeviceExtensionProperties(physical_device, nullptr,
                                         &extension_count, extensions.data());
    if (!HasExtension(extensions, VK_KHR_SWAPCHAIN_EXTENSION_NAME)) continue;

    uint32_t family_count = 0;
    vkGetPhysicalDeviceQueueFamilyProperties(physical_device, &family_count,
                                             nullptr);
    std::vector<VkQueueFamilyProperties> families(family_count);
    vkGetPhysicalDeviceQueueFamilyProperties(physical_device, &family_count,
                                             families.data());
    VkPhysicalDeviceFeatures supported{};
    vkGetPhysicalDeviceFeatures(physical_device, &supported);
    VkPhysicalDeviceFeatures features{};
    features.samplerAnisotropy = supported.samplerAnisotropy;
    features.wideLines = supported.wideLines;

    for (uint32_t family = 0; family < family_count; ++family) {
      if ((families[family].queueFlags & VK_QUEUE_GRAPHICS_BIT) == 0) continue;
      const float priority = 1.0f;
      VkDeviceQueueCreateInfo queue_info{
          VK_STRUCTURE_TYPE_DEVICE_QUEUE_CREATE_INFO};
      queue_info.queueFamilyIndex = family;
      queue_info.queueCount = 1;
      queue_info.pQueuePriorities = &priority;
      const char* device_extensions[] = {VK_KHR_SWAPCHAIN_EXTENSION_NAME};
      VkDeviceCreateInfo device_info{VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO};
      device_info.queueCreateInfoCount = 1;
      device_info.pQueueCreateInfos = &queue_info;
      device_info.enabledExtensionCount = 1;
      device_info.ppEnabledExtensionNames = device_extensions;
      device_info.pEnabledFeatures = &features;
      if (vkCreateDevice(physical_device, &device_info, nullptr,
                         &g_vulkan.device) != VK_SUCCESS) {
        continue;
      }
      vkGetDeviceQueue(g_vulkan.device, family, 0, &g_vulkan.queue);
      g_vulkan.physical_device = physical_device;
      g_vulkan.queue_family_index = family;
      return true;
    }
  }
  *error = "No Vulkan device offers a graphics queue with VK_KHR_swapchain.";
  return false;
}

jlong Handle(const void* handle) {
  return static_cast<jlong>(reinterpret_cast<intptr_t>(handle));
}

}  // namespace

extern "C" JNIEXPORT jstring JNICALL
Java_com_github_josxha_maplibre_1native_NativeBridge_nativeInit(
    JNIEnv* env, jclass, jobject context) {
  // The Dart code asset, packaged under the app's native library directory.
  void* library = dlopen("libmaplibre-native-c.so", RTLD_NOW);
  if (library == nullptr) {
    return env->NewStringUTF(dlerror());
  }
  auto init =
      reinterpret_cast<MlnAndroidInit>(dlsym(library, "mln_android_init"));
  if (init == nullptr) {
    return env->NewStringUTF("libmaplibre-native-c.so lacks mln_android_init.");
  }
  MlnDiagnostic diagnostic{sizeof(MlnDiagnostic), {}};
  if (init(env, context, &diagnostic) != 0) {
    return env->NewStringUTF(diagnostic.message);
  }
  return nullptr;
}

extern "C" JNIEXPORT jlongArray JNICALL
Java_com_github_josxha_maplibre_1native_NativeBridge_nativeVulkanContext(
    JNIEnv* env, jclass) {
  std::lock_guard<std::mutex> lock(g_mutex);
  if (g_vulkan.device == VK_NULL_HANDLE && g_vulkan_error.empty() &&
      !CreateVulkan(&g_vulkan_error) && g_vulkan_error.empty()) {
    g_vulkan_error = "Vulkan is unavailable.";
  }
  if (g_vulkan.device == VK_NULL_HANDLE) {
    ThrowIllegalState(env, g_vulkan_error);
    return nullptr;
  }
  const jlong values[] = {
      Handle(g_vulkan.instance),
      Handle(g_vulkan.physical_device),
      Handle(g_vulkan.device),
      Handle(g_vulkan.queue),
      static_cast<jlong>(g_vulkan.queue_family_index),
      Handle(reinterpret_cast<void*>(&vkGetInstanceProcAddr)),
      Handle(reinterpret_cast<void*>(&vkGetDeviceProcAddr)),
  };
  jlongArray array = env->NewLongArray(7);
  env->SetLongArrayRegion(array, 0, 7, values);
  return array;
}

extern "C" JNIEXPORT jlong JNICALL
Java_com_github_josxha_maplibre_1native_NativeBridge_nativeCreateSurface(
    JNIEnv* env, jclass, jobject surface) {
  std::lock_guard<std::mutex> lock(g_mutex);
  if (g_vulkan.instance == VK_NULL_HANDLE) {
    ThrowIllegalState(env, "The Vulkan device has not been created.");
    return 0;
  }
  ANativeWindow* window = ANativeWindow_fromSurface(env, surface);
  if (window == nullptr) {
    ThrowIllegalState(env, "The Surface has no native window.");
    return 0;
  }
  VkAndroidSurfaceCreateInfoKHR info{
      VK_STRUCTURE_TYPE_ANDROID_SURFACE_CREATE_INFO_KHR};
  info.window = window;
  VkSurfaceKHR vk_surface = VK_NULL_HANDLE;
  if (vkCreateAndroidSurfaceKHR(g_vulkan.instance, &info, nullptr,
                                &vk_surface) != VK_SUCCESS) {
    ANativeWindow_release(window);
    ThrowIllegalState(env, "vkCreateAndroidSurfaceKHR failed.");
    return 0;
  }
  VkBool32 presentable = VK_FALSE;
  vkGetPhysicalDeviceSurfaceSupportKHR(g_vulkan.physical_device,
                                       g_vulkan.queue_family_index, vk_surface,
                                       &presentable);
  if (!presentable) {
    __android_log_print(ANDROID_LOG_WARN, kTag,
                        "The graphics queue cannot present to the surface.");
  }
  g_surfaces[vk_surface] = window;
  return static_cast<jlong>(reinterpret_cast<uint64_t>(vk_surface));
}

extern "C" JNIEXPORT void JNICALL
Java_com_github_josxha_maplibre_1native_NativeBridge_nativeDestroySurface(
    JNIEnv*, jclass, jlong handle) {
  std::lock_guard<std::mutex> lock(g_mutex);
  auto vk_surface =
      reinterpret_cast<VkSurfaceKHR>(static_cast<uint64_t>(handle));
  const auto it = g_surfaces.find(vk_surface);
  if (it == g_surfaces.end()) return;
  vkDestroySurfaceKHR(g_vulkan.instance, vk_surface, nullptr);
  ANativeWindow_release(it->second);
  g_surfaces.erase(it);
}
