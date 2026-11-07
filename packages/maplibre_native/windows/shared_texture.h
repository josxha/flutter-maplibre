#ifndef FLUTTER_PLUGIN_MAPLIBRE_NATIVE_SHARED_TEXTURE_H_
#define FLUTTER_PLUGIN_MAPLIBRE_NATIVE_SHARED_TEXTURE_H_

#include <d3d11_1.h>
#include <flutter/texture_registrar.h>
#include <wrl/client.h>

#include <cstdint>
#include <deque>
#include <memory>
#include <mutex>
#include <string>
#include <vector>

namespace maplibre_native {

// A Flutter GPU surface texture that shows the frames of a ring of DXGI
// shared textures, which the C library allocates and renders into through
// Vulkan. Each presented frame is copied on the GPU into one of three
// textures that Flutter opens through a legacy DXGI shared handle, as ANGLE
// takes no NT handle and Flutter reopens a texture whenever its handle
// changes.
//
// Flutter's engine takes no keyed mutex or fence for such a texture, so the
// copy cannot wait for Flutter's reads. Instead it never targets the texture
// Flutter shows or fetched last: the texture it overwrites was last fetched
// at least one Flutter frame earlier.
class SharedTexture {
 public:
  static constexpr DXGI_FORMAT kFormat = DXGI_FORMAT_B8G8R8A8_UNORM;

  // Creates a texture whose copies run on |d3d|, a device on Flutter's
  // adapter, which the library's textures belong to.
  SharedTexture(flutter::TextureRegistrar* registrar, ID3D11Device1* d3d);

  // Unregisters |texture| and destroys it once Flutter stops using it.
  static void Dispose(std::unique_ptr<SharedTexture> texture);

  SharedTexture(const SharedTexture&) = delete;
  SharedTexture& operator=(const SharedTexture&) = delete;

  int64_t id() const { return id_; }

  // Copies the finished frame in the library's texture |handle|, at |slot| of
  // the ring |ring|, into the texture that Flutter shows next, and marks it
  // available.
  bool Present(uint32_t ring, uint32_t slot, HANDLE handle, std::string* error);

 private:
  struct PresentTexture {
    Microsoft::WRL::ComPtr<ID3D11Texture2D> texture;
    HANDLE handle = nullptr;
  };
  static constexpr int kPresentCount = 3;

  // The library's texture at |slot|, opened once per ring.
  ID3D11Texture2D* Open(uint32_t ring, uint32_t slot, HANDLE handle,
                        std::string* error);
  // Creates the present textures of a new size into |created|, which
  // Present installs once a frame was copied into the first of them.
  bool CreatePresentTextures(uint32_t width, uint32_t height,
                             PresentTexture* created, std::string* error);
  const FlutterDesktopGpuSurfaceDescriptor* Descriptor(size_t width,
                                                       size_t height);

  flutter::TextureRegistrar* registrar_;
  Microsoft::WRL::ComPtr<ID3D11Device1> d3d_;
  Microsoft::WRL::ComPtr<ID3D11DeviceContext> context_;
  Microsoft::WRL::ComPtr<ID3D11Query> query_;
  std::unique_ptr<flutter::TextureVariant> texture_;
  int64_t id_ = -1;

  // The library's textures of the current ring, by slot.
  uint32_t ring_ = 0;
  std::vector<Microsoft::WRL::ComPtr<ID3D11Texture2D>> opened_;

  uint32_t width_ = 0;
  uint32_t height_ = 0;
  // Guards what the raster thread reads in Descriptor.
  std::mutex mutex_;
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

#endif  // FLUTTER_PLUGIN_MAPLIBRE_NATIVE_SHARED_TEXTURE_H_
