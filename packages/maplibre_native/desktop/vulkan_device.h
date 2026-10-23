#ifndef FLUTTER_PLUGIN_MAPLIBRE_NATIVE_VULKAN_DEVICE_H_
#define FLUTTER_PLUGIN_MAPLIBRE_NATIVE_VULKAN_DEVICE_H_

#define VK_NO_PROTOTYPES
#if defined(_WIN32)
#define VK_USE_PLATFORM_WIN32_KHR
#include <windows.h>
#endif
#include <vulkan/vulkan.h>

#include <cstddef>
#include <cstdint>
#include <string>

namespace maplibre_native {

// Identifies the GPU that Flutter composites on: the adapter LUID on Windows,
// the device UUID that OpenGL reports on Linux.
struct GpuId {
  uint8_t bytes[VK_UUID_SIZE] = {};
  size_t size = 0;
};

// The process-wide Vulkan instance, device, and graphics queue that MapLibre
// render sessions borrow. Each session submits to the queue from its own core
// worker. The C library serializes the submissions and presents of every
// session on one queue, so maps share it without a queue lock as long as
// nothing else in the plugin uses the queue. Code that does needs
// mln_queue_lock, which the Dart binding does not expose yet.
class VulkanDevice {
 public:
  // Returns the shared device, creating it on first use on the physical
  // device that |gpu| identifies when there is one. Returns null and sets
  // |error| when no Vulkan device is available.
  static VulkanDevice* Get(const GpuId* gpu, std::string* error);

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

  // Whether the device shares image memory with Flutter's graphics API, which
  // zero-copy textures need: it imports D3D11 textures through
  // VK_KHR_external_memory_win32 on Windows, and exports memory to OpenGL
  // through VK_KHR_external_memory_fd on Linux.
  bool shares_memory() const { return shares_memory_; }

  // Whether the device runs on the GPU that was asked for.
  bool matches_gpu() const { return matches_gpu_; }

  // The VkPhysicalDeviceIDProperties::driverUUID of the device. Memory
  // exported to OpenGL needs the same driver on both sides.
  const uint8_t* driver_uuid() const { return driver_uuid_; }

  // Device functions for images whose memory is shared.
  PFN_vkCreateImage vkCreateImage = nullptr;
  PFN_vkDestroyImage vkDestroyImage = nullptr;
  PFN_vkGetImageMemoryRequirements vkGetImageMemoryRequirements = nullptr;
  PFN_vkAllocateMemory vkAllocateMemory = nullptr;
  PFN_vkFreeMemory vkFreeMemory = nullptr;
  PFN_vkBindImageMemory vkBindImageMemory = nullptr;
  PFN_vkCreateImageView vkCreateImageView = nullptr;
  PFN_vkDestroyImageView vkDestroyImageView = nullptr;
#if defined(_WIN32)
  PFN_vkGetMemoryWin32HandlePropertiesKHR vkGetMemoryWin32HandlePropertiesKHR =
      nullptr;
#else
  PFN_vkGetMemoryFdKHR vkGetMemoryFdKHR = nullptr;
#endif
  PFN_vkGetPhysicalDeviceMemoryProperties vkGetPhysicalDeviceMemoryProperties =
      nullptr;
  PFN_vkGetPhysicalDeviceImageFormatProperties2
      vkGetPhysicalDeviceImageFormatProperties2 = nullptr;

 private:
  VulkanDevice() = default;
  bool Create(const GpuId* gpu, std::string* error);

  void* library_ = nullptr;
  PFN_vkGetInstanceProcAddr get_instance_proc_addr_ = nullptr;
  PFN_vkGetDeviceProcAddr get_device_proc_addr_ = nullptr;
  VkInstance instance_ = VK_NULL_HANDLE;
  VkPhysicalDevice physical_device_ = VK_NULL_HANDLE;
  VkDevice device_ = VK_NULL_HANDLE;
  VkQueue queue_ = VK_NULL_HANDLE;
  uint32_t queue_family_index_ = 0;
  bool shares_memory_ = false;
  bool matches_gpu_ = false;
  uint8_t driver_uuid_[VK_UUID_SIZE] = {};
};

}  // namespace maplibre_native

#endif  // FLUTTER_PLUGIN_MAPLIBRE_NATIVE_VULKAN_DEVICE_H_
