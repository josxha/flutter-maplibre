#ifndef FLUTTER_PLUGIN_MAPLIBRE_NATIVE_VULKAN_DEVICE_H_
#define FLUTTER_PLUGIN_MAPLIBRE_NATIVE_VULKAN_DEVICE_H_

#define VK_NO_PROTOTYPES
#include <maplibre_native/maplibre_native_api.h>
#include <vulkan/vulkan.h>

#include <memory>
#include <string>

namespace maplibre_native {

// The Vulkan device that the C library created on Flutter's GPU and that
// render sessions use, with the functions that the plugin needs to allocate
// ring images whose memory OpenGL imports. The plugin never submits to the
// device's queue.
class VulkanDevice {
 public:
  // Loads the functions of the device |context|. Returns null and sets
  // |error| when the device can't export memory to OpenGL.
  static std::unique_ptr<VulkanDevice> Adopt(
      const MaplibreNativeVulkanContext& context, std::string* error);

  VkPhysicalDevice physical_device() const { return physical_device_; }
  VkDevice device() const { return device_; }

  // The VkPhysicalDeviceIDProperties of the device. Memory exported to
  // OpenGL needs the same GPU and driver on both sides.
  const uint8_t* device_uuid() const { return device_uuid_; }
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
  PFN_vkGetMemoryFdKHR vkGetMemoryFdKHR = nullptr;
  PFN_vkGetPhysicalDeviceMemoryProperties vkGetPhysicalDeviceMemoryProperties =
      nullptr;

 private:
  VulkanDevice() = default;

  VkPhysicalDevice physical_device_ = VK_NULL_HANDLE;
  VkDevice device_ = VK_NULL_HANDLE;
  uint8_t device_uuid_[VK_UUID_SIZE] = {};
  uint8_t driver_uuid_[VK_UUID_SIZE] = {};
};

}  // namespace maplibre_native

#endif  // FLUTTER_PLUGIN_MAPLIBRE_NATIVE_VULKAN_DEVICE_H_
