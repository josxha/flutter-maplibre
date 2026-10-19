#ifndef FLUTTER_PLUGIN_MAPLIBRE_NATIVE_GPU_TEXTURE_H_
#define FLUTTER_PLUGIN_MAPLIBRE_NATIVE_GPU_TEXTURE_H_

#include <d3d11.h>
#include <flutter/texture_registrar.h>
#include <wrl/client.h>

#include <cstdint>
#include <deque>
#include <memory>
#include <mutex>
#include <string>
#include <vector>

#include "vulkan_device.h"

namespace maplibre_native {

// One image of the ring that a MapLibre session renders into: a D3D11
// texture whose memory Vulkan imports through an NT handle.
struct SharedSlot {
  Microsoft::WRL::ComPtr<ID3D11Texture2D> texture;
  HANDLE handle = nullptr;
  VkImage image = VK_NULL_HANDLE;
  VkDeviceMemory memory = VK_NULL_HANDLE;
  VkImageView view = VK_NULL_HANDLE;
};

// A Flutter GPU surface texture that shows MapLibre frames without a CPU
// copy. MapLibre renders into a ring of shared D3D11 textures through Vulkan;
// each presented frame is copied on the GPU into one of three textures that
// Flutter opens through a DXGI shared handle.
//
// Flutter's engine takes no keyed mutex or fence for such a texture, so the
// copy cannot wait for Flutter's reads. Instead it never targets the texture
// Flutter shows or fetched last: the texture it overwrites was last fetched
// at least one Flutter frame earlier.
class GpuTexture {
 public:
  // The VkFormat and DXGI format of every image.
  static constexpr VkFormat kVulkanFormat = VK_FORMAT_B8G8R8A8_UNORM;
  static constexpr DXGI_FORMAT kDxgiFormat = DXGI_FORMAT_B8G8R8A8_UNORM;

  // Creates a texture of |width| x |height| device pixels with |slot_count|
  // ring images. Returns null and sets |error| when D3D11 and Vulkan cannot
  // share textures on this device.
  static std::unique_ptr<GpuTexture> Create(flutter::TextureRegistrar* registrar,
                                            VulkanDevice* vulkan,
                                            ID3D11Device* d3d,
                                            uint32_t width, uint32_t height,
                                            uint32_t slot_count,
                                            std::string* error);

  // Unregisters |texture| and destroys it once Flutter stops using it.
  static void Dispose(std::unique_ptr<GpuTexture> texture);

  ~GpuTexture();

  GpuTexture(const GpuTexture&) = delete;
  GpuTexture& operator=(const GpuTexture&) = delete;

  int64_t id() const { return id_; }
  const std::vector<SharedSlot>& slots() const { return slots_; }

  // Replaces the ring with one of the new size. The previous ring stays
  // valid until ReleaseRetiredSlots, because the session renders into it
  // until its target replacement completes.
  bool Resize(uint32_t width, uint32_t height, std::string* error);

  // Releases the rings that Resize replaced.
  void ReleaseRetiredSlots();

  // Copies the frame in |slot| into the texture Flutter shows and marks it
  // available. The frame's GPU writes must be complete.
  bool Present(uint32_t slot, std::string* error);

 private:
  GpuTexture(flutter::TextureRegistrar* registrar, VulkanDevice* vulkan,
             ID3D11Device* d3d);

  bool CreateSlots(uint32_t width, uint32_t height, uint32_t count,
                   std::vector<SharedSlot>* slots, std::string* error);
  bool CreateSlot(uint32_t width, uint32_t height, SharedSlot* slot,
                  std::string* error);
  void DestroySlot(SharedSlot* slot);
  bool CreatePresentTextures(uint32_t width, uint32_t height,
                             std::string* error);
  const FlutterDesktopGpuSurfaceDescriptor* Descriptor(size_t width,
                                                       size_t height);

  struct PresentTexture {
    Microsoft::WRL::ComPtr<ID3D11Texture2D> texture;
    HANDLE handle = nullptr;
  };

  flutter::TextureRegistrar* registrar_;
  VulkanDevice* vulkan_;
  Microsoft::WRL::ComPtr<ID3D11Device> d3d_;
  Microsoft::WRL::ComPtr<ID3D11DeviceContext> context_;
  Microsoft::WRL::ComPtr<ID3D11Query> query_;
  std::unique_ptr<flutter::TextureVariant> texture_;
  int64_t id_ = -1;

  uint32_t width_ = 0;
  uint32_t height_ = 0;
  std::vector<SharedSlot> slots_;
  std::vector<std::vector<SharedSlot>> retired_slots_;

  // Guards what the raster thread reads in Descriptor.
  std::mutex mutex_;
  static constexpr int kPresentCount = 3;
  PresentTexture present_[kPresentCount];
  // The texture of the latest presented frame.
  int front_ = -1;
  // The texture Flutter fetched last, which it may still be reading.
  int fetched_ = -1;
  FlutterDesktopGpuSurfaceDescriptor descriptor_{};
  // Present textures of earlier sizes, kept until Flutter has had a frame to
  // move on to the current ones.
  std::deque<std::pair<int, PresentTexture>> retired_present_;
};

}  // namespace maplibre_native

#endif  // FLUTTER_PLUGIN_MAPLIBRE_NATIVE_GPU_TEXTURE_H_
