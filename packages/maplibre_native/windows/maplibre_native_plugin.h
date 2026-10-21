#ifndef FLUTTER_PLUGIN_MAPLIBRE_NATIVE_PLUGIN_H_
#define FLUTTER_PLUGIN_MAPLIBRE_NATIVE_PLUGIN_H_

#include <d3d11.h>
#include <dxgi.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/texture_registrar.h>
#include <wrl/client.h>

#include <cstdint>
#include <map>
#include <memory>
#include <mutex>
#include <string>
#include <vector>

#include "d3d11_texture.h"
#include "desktop_plugin.h"
#include "vulkan_device.h"

namespace maplibre_native {

// A CPU pixel buffer that Flutter samples as an external texture. Dart pushes
// each map frame into it as RGBA8 bytes when zero-copy textures are
// unavailable.
class PixelTexture {
 public:
  explicit PixelTexture(flutter::TextureRegistrar* registrar);

  PixelTexture(const PixelTexture&) = delete;
  PixelTexture& operator=(const PixelTexture&) = delete;

  // Unregisters |texture| and destroys it once Flutter stops using it.
  static void Dispose(std::unique_ptr<PixelTexture> texture);

  int64_t id() const { return id_; }

  // Replaces the pixels and tells Flutter that a new frame is available.
  void Update(size_t width, size_t height, const uint8_t* pixels,
              size_t stride);

 private:
  const FlutterDesktopPixelBuffer* CopyPixelBuffer(size_t width,
                                                   size_t height);

  flutter::TextureRegistrar* registrar_;
  std::unique_ptr<flutter::TextureVariant> texture_;
  int64_t id_ = -1;

  std::mutex mutex_;
  std::vector<uint8_t> pixels_;
  FlutterDesktopPixelBuffer buffer_{};
};

// The Windows DesktopPlugin: owns the textures, and the D3D11 device that
// shares them with Flutter's adapter.
class MaplibreNativePlugin : public flutter::Plugin, public DesktopPlugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows* registrar);

  explicit MaplibreNativePlugin(flutter::PluginRegistrarWindows* registrar);

  ~MaplibreNativePlugin() override;

  VulkanDevice* GetVulkan(std::string* error) override;
  int64_t CreatePixelTexture() override;
  bool UpdatePixelTexture(int64_t id, size_t width, size_t height,
                          size_t stride, const uint8_t* pixels) override;
  GpuTexture* CreateGpuTexture(uint32_t width, uint32_t height,
                               uint32_t slot_count,
                               std::string* error) override;
  GpuTexture* FindGpuTexture(int64_t id) override;
  void DisposeTexture(int64_t id) override;

 private:
  // A D3D11 device on Flutter's GPU, or null with |error| set.
  ID3D11Device* GetD3D11(std::string* error);

  flutter::TextureRegistrar* textures_;
  // Flutter's adapter, taken on the platform thread at registration.
  Microsoft::WRL::ComPtr<IDXGIAdapter> adapter_;
  Microsoft::WRL::ComPtr<ID3D11Device> d3d_;
  GpuId adapter_luid_;
  std::map<int64_t, std::unique_ptr<PixelTexture>> pixel_textures_;
  std::map<int64_t, std::unique_ptr<D3D11Texture>> gpu_textures_;
};

}  // namespace maplibre_native

#endif  // FLUTTER_PLUGIN_MAPLIBRE_NATIVE_PLUGIN_H_
