#include "vulkan_device.h"

#include <cstring>

namespace maplibre_native {

// static
std::unique_ptr<VulkanDevice> VulkanDevice::Adopt(
    const MaplibreNativeVulkanContext& context, std::string* error) {
  auto get_instance_proc_addr = reinterpret_cast<PFN_vkGetInstanceProcAddr>(
      static_cast<uintptr_t>(context.get_instance_proc_addr));
  auto get_device_proc_addr = reinterpret_cast<PFN_vkGetDeviceProcAddr>(
      static_cast<uintptr_t>(context.get_device_proc_addr));
  auto instance = reinterpret_cast<VkInstance>(
      static_cast<uintptr_t>(context.instance));
  std::unique_ptr<VulkanDevice> vulkan(new VulkanDevice());
  vulkan->physical_device_ = reinterpret_cast<VkPhysicalDevice>(
      static_cast<uintptr_t>(context.physical_device));
  vulkan->device_ =
      reinterpret_cast<VkDevice>(static_cast<uintptr_t>(context.device));
  if (get_instance_proc_addr == nullptr || get_device_proc_addr == nullptr ||
      instance == VK_NULL_HANDLE || vulkan->device_ == VK_NULL_HANDLE) {
    *error = "The Vulkan device is incomplete.";
    return nullptr;
  }

  auto get_properties = reinterpret_cast<PFN_vkGetPhysicalDeviceProperties2>(
      get_instance_proc_addr(instance, "vkGetPhysicalDeviceProperties2"));
  vulkan->vkGetPhysicalDeviceMemoryProperties =
      reinterpret_cast<PFN_vkGetPhysicalDeviceMemoryProperties>(
          get_instance_proc_addr(instance,
                                 "vkGetPhysicalDeviceMemoryProperties"));
  if (get_properties == nullptr ||
      vulkan->vkGetPhysicalDeviceMemoryProperties == nullptr) {
    *error = "The Vulkan instance lacks Vulkan 1.1.";
    return nullptr;
  }
  VkPhysicalDeviceIDProperties id{
      VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_ID_PROPERTIES};
  VkPhysicalDeviceProperties2 properties{
      VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PROPERTIES_2};
  properties.pNext = &id;
  get_properties(vulkan->physical_device_, &properties);
  std::memcpy(vulkan->device_uuid_, id.deviceUUID, VK_UUID_SIZE);
  std::memcpy(vulkan->driver_uuid_, id.driverUUID, VK_UUID_SIZE);

#define MLN_LOAD_DEVICE(name)              \
  vulkan->name = reinterpret_cast<PFN_##name>( \
      get_device_proc_addr(vulkan->device_, #name))
  MLN_LOAD_DEVICE(vkCreateImage);
  MLN_LOAD_DEVICE(vkDestroyImage);
  MLN_LOAD_DEVICE(vkGetImageMemoryRequirements);
  MLN_LOAD_DEVICE(vkAllocateMemory);
  MLN_LOAD_DEVICE(vkFreeMemory);
  MLN_LOAD_DEVICE(vkBindImageMemory);
  MLN_LOAD_DEVICE(vkCreateImageView);
  MLN_LOAD_DEVICE(vkDestroyImageView);
  // Null unless the library enabled VK_KHR_external_memory_fd, which it does
  // where the GPU has it.
  MLN_LOAD_DEVICE(vkGetMemoryFdKHR);
#undef MLN_LOAD_DEVICE
  if (vulkan->vkGetMemoryFdKHR == nullptr) {
    *error = "The Vulkan device cannot export memory to OpenGL.";
    return nullptr;
  }
  return vulkan;
}

}  // namespace maplibre_native
