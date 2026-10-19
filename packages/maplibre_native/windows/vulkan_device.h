#ifndef FLUTTER_PLUGIN_MAPLIBRE_NATIVE_VULKAN_DEVICE_H_
#define FLUTTER_PLUGIN_MAPLIBRE_NATIVE_VULKAN_DEVICE_H_

#define VK_NO_PROTOTYPES
#define VK_USE_PLATFORM_WIN32_KHR
#include <vulkan/vulkan.h>
#include <windows.h>

#include <string>

namespace maplibre_native {

// The process-wide Vulkan instance, device, and graphics queue that MapLibre
// render sessions borrow. Each session submits to the queue from its own core
// worker. The C library serializes the submissions and presents of every
// session on one queue, so maps share it without a queue lock as long as
// nothing else in the plugin uses the queue. Code that does needs
// mln_queue_lock, which the Dart binding does not expose yet.
class VulkanDevice {
 public:
  // Returns the shared device, creating it on first use on the physical
  // device whose LUID matches |adapter_luid| when there is one. Returns null
  // and sets |error| when no Vulkan device is available.
  static VulkanDevice* Get(const LUID* adapter_luid, std::string* error);

  VkInstance instance() const { return instance_; }
  VkPhysicalDevice physical_device() const { return physical_device_; }
  VkDevice device() const { return device_; }
  VkQueue queue() const { return queue_; }
  uint32_t queue_family_index() const { return queue_family_index_; }
  PFN_vkGetInstanceProcAddr get_instance_proc_addr() const {
    return get_instance_proc_addr_;
  }
  PFN_vkGetDeviceProcAddr get_device_proc_addr() const {
    return get_device_proc_addr_;
  }

  // Whether the device imports D3D11 textures through
  // VK_KHR_external_memory_win32, which zero-copy textures need.
  bool imports_d3d11_textures() const { return imports_d3d11_textures_; }

  // Whether the device runs on the adapter that was asked for.
  bool matches_adapter() const { return matches_adapter_; }

  // Device functions for images that import D3D11 memory.
  PFN_vkCreateImage vkCreateImage = nullptr;
  PFN_vkDestroyImage vkDestroyImage = nullptr;
  PFN_vkGetImageMemoryRequirements vkGetImageMemoryRequirements = nullptr;
  PFN_vkAllocateMemory vkAllocateMemory = nullptr;
  PFN_vkFreeMemory vkFreeMemory = nullptr;
  PFN_vkBindImageMemory vkBindImageMemory = nullptr;
  PFN_vkCreateImageView vkCreateImageView = nullptr;
  PFN_vkDestroyImageView vkDestroyImageView = nullptr;
  PFN_vkGetMemoryWin32HandlePropertiesKHR vkGetMemoryWin32HandlePropertiesKHR =
      nullptr;
  PFN_vkGetPhysicalDeviceMemoryProperties vkGetPhysicalDeviceMemoryProperties =
      nullptr;
  PFN_vkGetPhysicalDeviceImageFormatProperties2
      vkGetPhysicalDeviceImageFormatProperties2 = nullptr;

 private:
  VulkanDevice() = default;
  bool Create(const LUID* adapter_luid, std::string* error);

  HMODULE library_ = nullptr;
  PFN_vkGetInstanceProcAddr get_instance_proc_addr_ = nullptr;
  PFN_vkGetDeviceProcAddr get_device_proc_addr_ = nullptr;
  VkInstance instance_ = VK_NULL_HANDLE;
  VkPhysicalDevice physical_device_ = VK_NULL_HANDLE;
  VkDevice device_ = VK_NULL_HANDLE;
  VkQueue queue_ = VK_NULL_HANDLE;
  uint32_t queue_family_index_ = 0;
  bool imports_d3d11_textures_ = false;
  bool matches_adapter_ = false;
};

}  // namespace maplibre_native

#endif  // FLUTTER_PLUGIN_MAPLIBRE_NATIVE_VULKAN_DEVICE_H_
