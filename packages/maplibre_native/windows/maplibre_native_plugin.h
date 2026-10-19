#ifndef FLUTTER_PLUGIN_MAPLIBRE_NATIVE_PLUGIN_H_
#define FLUTTER_PLUGIN_MAPLIBRE_NATIVE_PLUGIN_H_

#include <d3d11.h>
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/texture_registrar.h>
#include <wrl/client.h>

#include <cstdint>
#include <map>
#include <memory>
#include <mutex>
#include <string>
#include <vector>

#include "gpu_texture.h"
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

class MaplibreNativePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows* registrar);

  explicit MaplibreNativePlugin(flutter::PluginRegistrarWindows* registrar);

  virtual ~MaplibreNativePlugin();

  // Disallow copy and assign.
  MaplibreNativePlugin(const MaplibreNativePlugin&) = delete;
  MaplibreNativePlugin& operator=(const MaplibreNativePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue>& method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

 private:
  // The Vulkan device on Flutter's GPU, or null with |error| set.
  VulkanDevice* GetVulkan(std::string* error);
  // A D3D11 device on Flutter's GPU, or null with |error| set.
  ID3D11Device* GetD3D11(std::string* error);

  flutter::PluginRegistrarWindows* registrar_;
  flutter::TextureRegistrar* textures_;
  Microsoft::WRL::ComPtr<ID3D11Device> d3d_;
  LUID adapter_luid_{};
  bool has_adapter_luid_ = false;
  std::map<int64_t, std::unique_ptr<PixelTexture>> pixel_textures_;
  std::map<int64_t, std::unique_ptr<GpuTexture>> gpu_textures_;
};

}  // namespace maplibre_native

#endif  // FLUTTER_PLUGIN_MAPLIBRE_NATIVE_PLUGIN_H_
