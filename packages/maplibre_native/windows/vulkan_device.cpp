#include "vulkan_device.h"

#include <cstring>
#include <mutex>
#include <vector>

namespace maplibre_native {

namespace {

bool HasExtension(const std::vector<VkExtensionProperties>& extensions,
                  const char* name) {
  for (const auto& extension : extensions) {
    if (std::strcmp(extension.extensionName, name) == 0) return true;
  }
  return false;
}

}  // namespace

// static
VulkanDevice* VulkanDevice::Get(const LUID* adapter_luid, std::string* error) {
  static std::mutex mutex;
  static VulkanDevice* shared = nullptr;
  static std::string creation_error;
  std::lock_guard<std::mutex> lock(mutex);
  if (shared == nullptr && creation_error.empty()) {
    // The device lives as long as the process: sessions on core workers may
    // outlive any one plugin instance.
    auto* device = new VulkanDevice();
    if (device->Create(adapter_luid, &creation_error)) {
      shared = device;
    } else {
      delete device;
      if (creation_error.empty()) creation_error = "Vulkan is unavailable.";
    }
  }
  if (shared == nullptr && error != nullptr) *error = creation_error;
  return shared;
}

bool VulkanDevice::Create(const LUID* adapter_luid, std::string* error) {
  library_ = LoadLibraryW(L"vulkan-1.dll");
  if (library_ == nullptr) {
    *error = "vulkan-1.dll was not found. Install a GPU driver with Vulkan.";
    return false;
  }
  get_instance_proc_addr_ = reinterpret_cast<PFN_vkGetInstanceProcAddr>(
      GetProcAddress(library_, "vkGetInstanceProcAddr"));
  if (get_instance_proc_addr_ == nullptr) {
    *error = "The Vulkan loader lacks vkGetInstanceProcAddr.";
    return false;
  }

  auto create_instance = reinterpret_cast<PFN_vkCreateInstance>(
      get_instance_proc_addr_(VK_NULL_HANDLE, "vkCreateInstance"));
  VkApplicationInfo application{VK_STRUCTURE_TYPE_APPLICATION_INFO};
  application.pApplicationName = "maplibre_native";
  application.apiVersion = VK_API_VERSION_1_1;
  VkInstanceCreateInfo instance_info{VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO};
  instance_info.pApplicationInfo = &application;
  if (create_instance == nullptr ||
      create_instance(&instance_info, nullptr, &instance_) != VK_SUCCESS) {
    *error = "vkCreateInstance failed.";
    return false;
  }

#define MLN_LOAD_INSTANCE(name) \
  auto name = reinterpret_cast<PFN_##name>(  \
      get_instance_proc_addr_(instance_, #name))
  MLN_LOAD_INSTANCE(vkEnumeratePhysicalDevices);
  MLN_LOAD_INSTANCE(vkGetPhysicalDeviceProperties2);
  MLN_LOAD_INSTANCE(vkGetPhysicalDeviceQueueFamilyProperties);
  MLN_LOAD_INSTANCE(vkGetPhysicalDeviceFeatures);
  MLN_LOAD_INSTANCE(vkEnumerateDeviceExtensionProperties);
  MLN_LOAD_INSTANCE(vkCreateDevice);
  MLN_LOAD_INSTANCE(vkGetDeviceQueue);
#undef MLN_LOAD_INSTANCE
  get_device_proc_addr_ = reinterpret_cast<PFN_vkGetDeviceProcAddr>(
      get_instance_proc_addr_(instance_, "vkGetDeviceProcAddr"));
  vkGetPhysicalDeviceMemoryProperties =
      reinterpret_cast<PFN_vkGetPhysicalDeviceMemoryProperties>(
          get_instance_proc_addr_(instance_,
                                  "vkGetPhysicalDeviceMemoryProperties"));
  vkGetPhysicalDeviceImageFormatProperties2 =
      reinterpret_cast<PFN_vkGetPhysicalDeviceImageFormatProperties2>(
          get_instance_proc_addr_(instance_,
                                  "vkGetPhysicalDeviceImageFormatProperties2"));

  uint32_t device_count = 0;
  vkEnumeratePhysicalDevices(instance_, &device_count, nullptr);
  std::vector<VkPhysicalDevice> devices(device_count);
  vkEnumeratePhysicalDevices(instance_, &device_count, devices.data());
  if (devices.empty()) {
    *error = "No Vulkan physical device is available.";
    return false;
  }

  // Prefer the GPU that Flutter composites on, because D3D11 textures only
  // share between devices of one adapter.
  std::vector<VkPhysicalDevice> ordered;
  for (auto device : devices) {
    VkPhysicalDeviceIDProperties id{
        VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_ID_PROPERTIES};
    VkPhysicalDeviceProperties2 properties{
        VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PROPERTIES_2};
    properties.pNext = &id;
    vkGetPhysicalDeviceProperties2(device, &properties);
    const bool matches = adapter_luid != nullptr && id.deviceLUIDValid &&
                         std::memcmp(id.deviceLUID, adapter_luid,
                                     sizeof(LUID)) == 0;
    if (matches) {
      ordered.insert(ordered.begin(), device);
    } else {
      ordered.push_back(device);
    }
  }

  for (auto physical_device : ordered) {
    uint32_t family_count = 0;
    vkGetPhysicalDeviceQueueFamilyProperties(physical_device, &family_count,
                                             nullptr);
    std::vector<VkQueueFamilyProperties> families(family_count);
    vkGetPhysicalDeviceQueueFamilyProperties(physical_device, &family_count,
                                             families.data());
    uint32_t extension_count = 0;
    vkEnumerateDeviceExtensionProperties(physical_device, nullptr,
                                         &extension_count, nullptr);
    std::vector<VkExtensionProperties> extensions(extension_count);
    vkEnumerateDeviceExtensionProperties(physical_device, nullptr,
                                         &extension_count, extensions.data());
    std::vector<const char*> enabled;
    const bool external_memory = HasExtension(
        extensions, VK_KHR_EXTERNAL_MEMORY_WIN32_EXTENSION_NAME);
    if (external_memory) {
      enabled.push_back(VK_KHR_EXTERNAL_MEMORY_WIN32_EXTENSION_NAME);
    }

    // The features that the C API's own test fixture enables.
    VkPhysicalDeviceFeatures supported{};
    vkGetPhysicalDeviceFeatures(physical_device, &supported);
    VkPhysicalDeviceFeatures features{};
    features.samplerAnisotropy = supported.samplerAnisotropy;
    features.wideLines = supported.wideLines;

    for (uint32_t family = 0; family < family_count; ++family) {
      if ((families[family].queueFlags & VK_QUEUE_GRAPHICS_BIT) == 0 ||
          families[family].queueCount == 0) {
        continue;
      }
      const float priority = 1.0f;
      VkDeviceQueueCreateInfo queue_info{
          VK_STRUCTURE_TYPE_DEVICE_QUEUE_CREATE_INFO};
      queue_info.queueFamilyIndex = family;
      queue_info.queueCount = 1;
      queue_info.pQueuePriorities = &priority;
      VkDeviceCreateInfo device_info{VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO};
      device_info.queueCreateInfoCount = 1;
      device_info.pQueueCreateInfos = &queue_info;
      device_info.enabledExtensionCount = static_cast<uint32_t>(enabled.size());
      device_info.ppEnabledExtensionNames = enabled.data();
      device_info.pEnabledFeatures = &features;
      if (vkCreateDevice(physical_device, &device_info, nullptr, &device_) !=
          VK_SUCCESS) {
        continue;
      }
      vkGetDeviceQueue(device_, family, 0, &queue_);
      physical_device_ = physical_device;
      queue_family_index_ = family;
      imports_d3d11_textures_ = external_memory;
      VkPhysicalDeviceIDProperties id{
          VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_ID_PROPERTIES};
      VkPhysicalDeviceProperties2 properties{
          VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PROPERTIES_2};
      properties.pNext = &id;
      vkGetPhysicalDeviceProperties2(physical_device, &properties);
      matches_adapter_ = adapter_luid != nullptr && id.deviceLUIDValid &&
                         std::memcmp(id.deviceLUID, adapter_luid,
                                     sizeof(LUID)) == 0;
      break;
    }
    if (device_ != VK_NULL_HANDLE) break;
  }
  if (device_ == VK_NULL_HANDLE) {
    *error = "No Vulkan physical device accepted a graphics device.";
    return false;
  }

#define MLN_LOAD_DEVICE(name) \
  name = reinterpret_cast<PFN_##name>(get_device_proc_addr_(device_, #name))
  MLN_LOAD_DEVICE(vkCreateImage);
  MLN_LOAD_DEVICE(vkDestroyImage);
  MLN_LOAD_DEVICE(vkGetImageMemoryRequirements);
  MLN_LOAD_DEVICE(vkAllocateMemory);
  MLN_LOAD_DEVICE(vkFreeMemory);
  MLN_LOAD_DEVICE(vkBindImageMemory);
  MLN_LOAD_DEVICE(vkCreateImageView);
  MLN_LOAD_DEVICE(vkDestroyImageView);
  if (imports_d3d11_textures_) {
    MLN_LOAD_DEVICE(vkGetMemoryWin32HandlePropertiesKHR);
    imports_d3d11_textures_ = vkGetMemoryWin32HandlePropertiesKHR != nullptr;
  }
#undef MLN_LOAD_DEVICE
  return true;
}

}  // namespace maplibre_native
