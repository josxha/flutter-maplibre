#ifndef FLUTTER_PLUGIN_MAPLIBRE_NATIVE_PLUGIN_H_
#define FLUTTER_PLUGIN_MAPLIBRE_NATIVE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/texture_registrar.h>

#include <cstdint>
#include <map>
#include <memory>
#include <mutex>
#include <vector>

namespace maplibre_native {

// A CPU pixel buffer that Flutter samples as an external texture. Dart pushes
// each map frame into it as RGBA8 bytes.
class PixelTexture {
 public:
  explicit PixelTexture(flutter::TextureRegistrar* registrar);
  ~PixelTexture();

  PixelTexture(const PixelTexture&) = delete;
  PixelTexture& operator=(const PixelTexture&) = delete;

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

  explicit MaplibreNativePlugin(flutter::TextureRegistrar* textures);

  virtual ~MaplibreNativePlugin();

  // Disallow copy and assign.
  MaplibreNativePlugin(const MaplibreNativePlugin&) = delete;
  MaplibreNativePlugin& operator=(const MaplibreNativePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue>& method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);

 private:
  flutter::TextureRegistrar* textures_;
  std::map<int64_t, std::unique_ptr<PixelTexture>> pixel_textures_;
};

}  // namespace maplibre_native

#endif  // FLUTTER_PLUGIN_MAPLIBRE_NATIVE_PLUGIN_H_
