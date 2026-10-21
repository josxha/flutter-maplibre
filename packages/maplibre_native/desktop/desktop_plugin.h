#ifndef FLUTTER_PLUGIN_MAPLIBRE_NATIVE_DESKTOP_PLUGIN_H_
#define FLUTTER_PLUGIN_MAPLIBRE_NATIVE_DESKTOP_PLUGIN_H_

#include <cstddef>
#include <cstdint>
#include <mutex>
#include <string>
#include <vector>

#include "vulkan_device.h"

namespace maplibre_native {

// One Vulkan image of a GPU texture's ring, and its view.
struct VulkanSlot {
  VkImage image = VK_NULL_HANDLE;
  VkImageView view = VK_NULL_HANDLE;
};

// A Flutter texture that shows MapLibre frames without a CPU copy. MapLibre
// renders into a ring of Vulkan images whose memory Flutter's graphics API
// shares, and each presented frame is copied on the GPU into a texture that
// Flutter samples.
class GpuTexture {
 public:
  virtual ~GpuTexture() = default;

  virtual int64_t id() const = 0;

  // The VkFormat of every ring image.
  virtual VkFormat format() const = 0;

  virtual std::vector<VulkanSlot> slots() const = 0;

  // Replaces the ring with one of the new size. The previous ring stays
  // valid until ReleaseRetiredSlots, because the session renders into it
  // until its target replacement completes.
  virtual bool Resize(uint32_t width, uint32_t height, std::string* error) = 0;

  // Releases the rings that Resize replaced.
  virtual void ReleaseRetiredSlots() = 0;

  // Copies the frame in |slot| into the texture Flutter shows and marks it
  // available. The frame's GPU writes must be complete.
  virtual bool Present(uint32_t slot, std::string* error) = 0;
};

// The Windows or Linux plugin behind the C API in
// include/maplibre_native/maplibre_native_api.h, which this directory
// implements once for both. Dart reaches the one registered instance through
// that API, never through a channel.
class DesktopPlugin {
 public:
  // The registered plugin, or null before registration and after shutdown.
  // Callers hold the lock from Lock() while they use it.
  static DesktopPlugin* Instance();
  static std::unique_lock<std::mutex> Lock();

  DesktopPlugin(const DesktopPlugin&) = delete;
  DesktopPlugin& operator=(const DesktopPlugin&) = delete;

  // The Vulkan device on Flutter's GPU, or null with |error| set.
  virtual VulkanDevice* GetVulkan(std::string* error) = 0;

  virtual int64_t CreatePixelTexture() = 0;

  // Copies |height| rows of |width| RGBA8 pixels, |stride| bytes apart, which
  // the C API checked against their length. Returns false when no pixel
  // texture has |id|.
  virtual bool UpdatePixelTexture(int64_t id, size_t width, size_t height,
                                  size_t stride, const uint8_t* pixels) = 0;

  // Returns null with |error| set when Vulkan cannot share textures with
  // Flutter, and Dart falls back to a pixel buffer texture.
  virtual GpuTexture* CreateGpuTexture(uint32_t width, uint32_t height,
                                       uint32_t slot_count,
                                       std::string* error) = 0;
  virtual GpuTexture* FindGpuTexture(int64_t id) = 0;

  // Unregisters a texture of either kind.
  virtual void DisposeTexture(int64_t id) = 0;

 protected:
  // Registers this plugin as the instance.
  DesktopPlugin();
  virtual ~DesktopPlugin();

  // Unregisters this plugin; the caller holds the lock. Subclass destructors
  // call it first, so the C API never reaches a plugin in destruction.
  void Unregister();

  // Whether MAPLIBRE_NATIVE_DISABLE_ZERO_COPY is set, which lets the CPU
  // readback path be tested on hardware that shares textures.
  static bool ZeroCopyDisabled();
};

}  // namespace maplibre_native

#endif  // FLUTTER_PLUGIN_MAPLIBRE_NATIVE_DESKTOP_PLUGIN_H_
