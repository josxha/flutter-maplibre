// JNI side of the maplibre_native Android plugin: initializes the MapLibre
// Native C library for Android and wraps Flutter's surfaces for the backend
// the library was built with. For Vulkan it creates the device that render
// sessions borrow and wraps surfaces as VkSurfaceKHRs. For OpenGL ES it
// initializes EGL, wraps surfaces as EGLSurfaces, and runs the render thread
// that services the caller-graphics-thread sessions of all maps.

#define VK_USE_PLATFORM_ANDROID_KHR
#include <EGL/egl.h>
#include <EGL/eglext.h>
#include <android/log.h>
#include <android/native_window_jni.h>
#include <dlfcn.h>
#include <jni.h>
#include <vulkan/vulkan.h>

#include <algorithm>
#include <condition_variable>
#include <cstring>
#include <map>
#include <mutex>
#include <string>
#include <thread>
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
// mln_render_session_service_driver_work from maplibre_native_c.
using MlnServiceDriverWork = int32_t (*)(uint64_t session,
                                         MlnDiagnostic* out_diagnostic);
// mln_status values from maplibre_native_c/base.h.
constexpr int32_t kMlnStatusOk = 0;
constexpr int32_t kMlnStatusBusy = -7;

struct Vulkan {
  VkInstance instance = VK_NULL_HANDLE;
  VkPhysicalDevice physical_device = VK_NULL_HANDLE;
  VkDevice device = VK_NULL_HANDLE;
  VkQueue queue = VK_NULL_HANDLE;
  uint32_t queue_family_index = 0;
};

struct Egl {
  EGLDisplay display = EGL_NO_DISPLAY;
  EGLConfig config = nullptr;
};

std::mutex g_mutex;
void* g_library = nullptr;
Vulkan g_vulkan;
std::string g_vulkan_error;
std::map<VkSurfaceKHR, ANativeWindow*> g_surfaces;
Egl g_egl;
std::string g_egl_error;
std::map<EGLSurface, ANativeWindow*> g_egl_surfaces;

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
//
// Every map's session submits to and presents on the one queue. The C library
// serializes that across sessions, so they need no queue lock as long as this
// plugin never uses the queue itself. Code that does needs mln_queue_lock,
// which the Dart binding does not expose yet.
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

EGLint ConfigAttribute(EGLConfig config, EGLint attribute) {
  EGLint value = 0;
  eglGetConfigAttrib(g_egl.display, config, attribute, &value);
  return value;
}

// Initializes the default display for the rest of the process and picks an
// RGBA8888 OpenGL ES 3 window config with depth and stencil, which sessions
// create their dedicated contexts from. EGL is never terminated: Flutter
// shares the display, and the C API needs it to outlive every session.
bool CreateEgl(std::string* error) {
  EGLDisplay display = eglGetDisplay(EGL_DEFAULT_DISPLAY);
  if (display == EGL_NO_DISPLAY ||
      eglInitialize(display, nullptr, nullptr) == EGL_FALSE) {
    *error = "eglInitialize failed.";
    return false;
  }
  g_egl.display = display;
  const EGLint attributes[] = {
      EGL_RENDERABLE_TYPE, EGL_OPENGL_ES3_BIT_KHR,
      EGL_SURFACE_TYPE,    EGL_WINDOW_BIT,
      EGL_RED_SIZE,        8,
      EGL_GREEN_SIZE,      8,
      EGL_BLUE_SIZE,       8,
      EGL_ALPHA_SIZE,      8,
      EGL_DEPTH_SIZE,      16,
      EGL_STENCIL_SIZE,    8,
      EGL_NONE,
  };
  EGLint count = 0;
  eglChooseConfig(display, attributes, nullptr, 0, &count);
  std::vector<EGLConfig> configs(count);
  eglChooseConfig(display, attributes, configs.data(), count, &count);
  configs.resize(count);
  // eglChooseConfig ranks deeper color first, so take the first exact
  // RGBA8888 config, preferring one that also offers pbuffers: a session
  // tears down through a pbuffer when it cannot use its window surface.
  EGLConfig fallback = nullptr;
  for (EGLConfig config : configs) {
    if (ConfigAttribute(config, EGL_RED_SIZE) != 8 ||
        ConfigAttribute(config, EGL_GREEN_SIZE) != 8 ||
        ConfigAttribute(config, EGL_BLUE_SIZE) != 8 ||
        ConfigAttribute(config, EGL_ALPHA_SIZE) != 8) {
      continue;
    }
    if (ConfigAttribute(config, EGL_SURFACE_TYPE) & EGL_PBUFFER_BIT) {
      g_egl.config = config;
      return true;
    }
    if (fallback == nullptr) fallback = config;
  }
  if (fallback == nullptr) {
    *error = "No RGBA8888 OpenGL ES 3 EGL config with depth and stencil.";
    return false;
  }
  g_egl.config = fallback;
  return true;
}

// The one thread that services every caller-graphics-thread session, so all
// OpenGL ES maps render on one thread, each with its dedicated EGL context.
// The C API binds a session to the first thread that services it.
//
// Each map registers a RenderClient, whose session's driver work wake calls
// WakeClient on whatever thread the C library reports work from, without a
// hop through the Dart isolate. The wake registration owns the client: the C
// library releases it with ReleaseClient once the session no longer wakes
// it, which may come after the map removed the client.
class RenderThread;

struct RenderClient {
  RenderThread* thread;
  uint64_t session = 0;  // 0 until the attachment returned the session.
  bool pending = false;
  bool removed = false;
  bool released = false;  // The C library dropped the wake registration.
  int32_t last_status = kMlnStatusOk;
};

class RenderThread {
 public:
  explicit RenderThread(MlnServiceDriverWork service)
      : service_(service), thread_([this] { Run(); }) {}

  // Lives as long as the process, like the EGL display it renders with.
  ~RenderThread() = delete;

  RenderClient* AddClient() {
    std::lock_guard<std::mutex> lock(mutex_);
    auto* client = new RenderClient{this};
    clients_.push_back(client);
    return client;
  }

  // Wakes for work that arrived before the session was known.
  void SetSession(RenderClient* client, uint64_t session) {
    {
      std::lock_guard<std::mutex> lock(mutex_);
      client->session = session;
      client->pending = true;
    }
    wake_.notify_one();
  }

  void Wake(RenderClient* client) {
    {
      std::lock_guard<std::mutex> lock(mutex_);
      if (client->removed) return;
      client->pending = true;
    }
    wake_.notify_one();
  }

  // Stops servicing the client's session once the call in flight returns.
  // The session was detached before, so no work is left behind.
  void RemoveClient(RenderClient* client) {
    std::unique_lock<std::mutex> lock(mutex_);
    client->removed = true;
    clients_.erase(std::remove(clients_.begin(), clients_.end(), client),
                   clients_.end());
    idle_.wait(lock, [this, client] { return servicing_ != client; });
    if (client->released) delete client;
  }

  void Release(RenderClient* client) {
    std::lock_guard<std::mutex> lock(mutex_);
    client->released = true;
    if (client->removed) delete client;
  }

 private:
  void Run() {
    std::unique_lock<std::mutex> lock(mutex_);
    for (;;) {
      RenderClient* client = nullptr;
      wake_.wait(lock, [this, &client] {
        for (auto* candidate : clients_) {
          if (candidate->pending && candidate->session != 0) {
            client = candidate;
            return true;
          }
        }
        return false;
      });
      // Services everything queued for the session. Work queued during the
      // call wakes it again. Other sessions take their turn after it, so
      // they share the thread fairly.
      client->pending = false;
      servicing_ = client;
      std::rotate(clients_.begin(),
                  std::find(clients_.begin(), clients_.end(), client) + 1,
                  clients_.end());
      const uint64_t session = client->session;
      lock.unlock();
      MlnDiagnostic diagnostic{sizeof(MlnDiagnostic), {}};
      const int32_t status = service_(session, &diagnostic);
      lock.lock();
      servicing_ = nullptr;
      if (status != kMlnStatusOk && status != kMlnStatusBusy &&
          status != client->last_status) {
        __android_log_print(ANDROID_LOG_ERROR, kTag,
                            "Servicing a render session failed (%d): %s",
                            status, diagnostic.message);
      }
      client->last_status = status;
      idle_.notify_all();
    }
  }

  const MlnServiceDriverWork service_;
  std::mutex mutex_;
  std::condition_variable wake_;
  std::condition_variable idle_;
  std::vector<RenderClient*> clients_;
  RenderClient* servicing_ = nullptr;
  // Last, so the thread starts once the fields above are initialized.
  std::thread thread_;
};

RenderThread* g_render_thread = nullptr;

// mln_wake_callback and mln_user_data_release of a client's driver work wake.
void WakeClient(void* user_data) {
  auto* client = static_cast<RenderClient*>(user_data);
  client->thread->Wake(client);
}

void ReleaseClient(void* user_data) {
  auto* client = static_cast<RenderClient*>(user_data);
  client->thread->Release(client);
}

ANativeWindow* WindowOf(JNIEnv* env, jobject surface) {
  ANativeWindow* window = ANativeWindow_fromSurface(env, surface);
  if (window == nullptr) {
    ThrowIllegalState(env, "The Surface has no native window.");
  }
  return window;
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
  {
    std::lock_guard<std::mutex> lock(g_mutex);
    g_library = library;
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
  ANativeWindow* window = WindowOf(env, surface);
  if (window == nullptr) return 0;
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

extern "C" JNIEXPORT jlongArray JNICALL
Java_com_github_josxha_maplibre_1native_NativeBridge_nativeEglContext(
    JNIEnv* env, jclass) {
  std::lock_guard<std::mutex> lock(g_mutex);
  if (g_egl.config == nullptr && g_egl_error.empty() &&
      !CreateEgl(&g_egl_error) && g_egl_error.empty()) {
    g_egl_error = "EGL is unavailable.";
  }
  if (g_egl.config == nullptr) {
    ThrowIllegalState(env, g_egl_error);
    return nullptr;
  }
  const jlong values[] = {Handle(g_egl.display), Handle(g_egl.config)};
  jlongArray array = env->NewLongArray(2);
  env->SetLongArrayRegion(array, 0, 2, values);
  return array;
}

extern "C" JNIEXPORT jlong JNICALL
Java_com_github_josxha_maplibre_1native_NativeBridge_nativeCreateEglSurface(
    JNIEnv* env, jclass, jobject surface) {
  std::lock_guard<std::mutex> lock(g_mutex);
  if (g_egl.config == nullptr) {
    ThrowIllegalState(env, "EGL has not been initialized.");
    return 0;
  }
  ANativeWindow* window = WindowOf(env, surface);
  if (window == nullptr) return 0;
  EGLSurface egl_surface =
      eglCreateWindowSurface(g_egl.display, g_egl.config, window, nullptr);
  if (egl_surface == EGL_NO_SURFACE) {
    const EGLint error = eglGetError();
    ANativeWindow_release(window);
    ThrowIllegalState(
        env, "eglCreateWindowSurface failed with error " +
                 std::to_string(error) + ".");
    return 0;
  }
  g_egl_surfaces[egl_surface] = window;
  return Handle(egl_surface);
}

// A surface that is still current on a render thread goes once that thread
// releases it: EGL defers destroying current surfaces.
extern "C" JNIEXPORT void JNICALL
Java_com_github_josxha_maplibre_1native_NativeBridge_nativeDestroyEglSurface(
    JNIEnv*, jclass, jlong handle) {
  std::lock_guard<std::mutex> lock(g_mutex);
  auto egl_surface =
      reinterpret_cast<EGLSurface>(static_cast<intptr_t>(handle));
  const auto it = g_egl_surfaces.find(egl_surface);
  if (it == g_egl_surfaces.end()) return;
  eglDestroySurface(g_egl.display, egl_surface);
  ANativeWindow_release(it->second);
  g_egl_surfaces.erase(it);
}

extern "C" JNIEXPORT jlong JNICALL
Java_com_github_josxha_maplibre_1native_NativeBridge_nativeAddRenderClient(
    JNIEnv* env, jclass) {
  RenderThread* thread = nullptr;
  {
    std::lock_guard<std::mutex> lock(g_mutex);
    if (g_render_thread == nullptr && g_library != nullptr) {
      auto service = reinterpret_cast<MlnServiceDriverWork>(
          dlsym(g_library, "mln_render_session_service_driver_work"));
      if (service != nullptr) g_render_thread = new RenderThread(service);
    }
    thread = g_render_thread;
  }
  if (thread == nullptr) {
    ThrowIllegalState(env,
                      "libmaplibre-native-c.so lacks "
                      "mln_render_session_service_driver_work.");
    return 0;
  }
  return Handle(thread->AddClient());
}

extern "C" JNIEXPORT jlongArray JNICALL
Java_com_github_josxha_maplibre_1native_NativeBridge_nativeRenderClientWake(
    JNIEnv* env, jclass) {
  const jlong values[] = {Handle(reinterpret_cast<void*>(&WakeClient)),
                          Handle(reinterpret_cast<void*>(&ReleaseClient))};
  jlongArray array = env->NewLongArray(2);
  env->SetLongArrayRegion(array, 0, 2, values);
  return array;
}

extern "C" JNIEXPORT void JNICALL
Java_com_github_josxha_maplibre_1native_NativeBridge_nativeSetRenderClientSession(
    JNIEnv*, jclass, jlong client, jlong session) {
  auto* render_client =
      reinterpret_cast<RenderClient*>(static_cast<intptr_t>(client));
  render_client->thread->SetSession(render_client,
                                    static_cast<uint64_t>(session));
}

extern "C" JNIEXPORT void JNICALL
Java_com_github_josxha_maplibre_1native_NativeBridge_nativeRemoveRenderClient(
    JNIEnv*, jclass, jlong client) {
  auto* render_client =
      reinterpret_cast<RenderClient*>(static_cast<intptr_t>(client));
  render_client->thread->RemoveClient(render_client);
}
