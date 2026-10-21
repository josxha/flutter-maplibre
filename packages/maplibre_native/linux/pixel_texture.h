#ifndef FLUTTER_PLUGIN_MAPLIBRE_NATIVE_PIXEL_TEXTURE_H_
#define FLUTTER_PLUGIN_MAPLIBRE_NATIVE_PIXEL_TEXTURE_H_

#include <flutter_linux/flutter_linux.h>

#include <cstddef>
#include <cstdint>
#include <memory>
#include <mutex>
#include <vector>

namespace maplibre_native {

// The frames of a PixelTexture, which Dart writes and Flutter's raster thread
// reads. Flutter uploads the buffer that copy_pixels returns after the call,
// so a write never targets the buffer Flutter fetched last: three buffers
// rotate, and the one written is neither the front nor the fetched one.
struct PixelFrames {
  std::mutex mutex;
  std::vector<uint8_t> buffers[3];
  uint32_t widths[3] = {};
  uint32_t heights[3] = {};
  int front = -1;
  int fetched = -1;
};

// A CPU pixel buffer that Flutter samples as an external texture. Dart pushes
// each map frame into it as RGBA8 bytes when zero-copy textures are
// unavailable.
class PixelTexture {
 public:
  // Registers a texture with |registrar|.
  explicit PixelTexture(FlTextureRegistrar* registrar);
  // Unregisters it. Flutter keeps the frames until it lets go of the texture.
  ~PixelTexture();

  PixelTexture(const PixelTexture&) = delete;
  PixelTexture& operator=(const PixelTexture&) = delete;

  int64_t id() const { return id_; }

  // Replaces the pixels and tells Flutter that a new frame is available.
  void Update(size_t width, size_t height, const uint8_t* pixels,
              size_t stride);

 private:
  FlTextureRegistrar* registrar_;
  FlTexture* texture_ = nullptr;
  int64_t id_ = -1;
  std::shared_ptr<PixelFrames> frames_;
};

}  // namespace maplibre_native

#endif  // FLUTTER_PLUGIN_MAPLIBRE_NATIVE_PIXEL_TEXTURE_H_
