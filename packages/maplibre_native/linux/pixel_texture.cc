#include "pixel_texture.h"

#include <cstring>
#include <new>

// The GObject that Flutter calls. It holds the frames as long as Flutter holds
// it, which can be past PixelTexture.
struct _MlnPixelTexture {
  FlPixelBufferTexture parent_instance;
  std::shared_ptr<maplibre_native::PixelFrames>* frames;
};

G_DECLARE_FINAL_TYPE(MlnPixelTexture, mln_pixel_texture, MLN, PIXEL_TEXTURE,
                     FlPixelBufferTexture)

G_DEFINE_TYPE(MlnPixelTexture, mln_pixel_texture,
              fl_pixel_buffer_texture_get_type())

namespace {

// Runs on the raster thread.
gboolean mln_pixel_texture_copy_pixels(FlPixelBufferTexture* texture,
                                       const uint8_t** buffer, uint32_t* width,
                                       uint32_t* height, GError** error) {
  maplibre_native::PixelFrames& frames =
      **MLN_PIXEL_TEXTURE(texture)->frames;
  std::lock_guard<std::mutex> lock(frames.mutex);
  if (frames.front < 0) return FALSE;
  frames.fetched = frames.front;
  *buffer = frames.buffers[frames.front].data();
  *width = frames.widths[frames.front];
  *height = frames.heights[frames.front];
  return TRUE;
}

void mln_pixel_texture_finalize(GObject* object) {
  delete MLN_PIXEL_TEXTURE(object)->frames;
  G_OBJECT_CLASS(mln_pixel_texture_parent_class)->finalize(object);
}

}  // namespace

static void mln_pixel_texture_class_init(MlnPixelTextureClass* klass) {
  FL_PIXEL_BUFFER_TEXTURE_CLASS(klass)->copy_pixels =
      mln_pixel_texture_copy_pixels;
  G_OBJECT_CLASS(klass)->finalize = mln_pixel_texture_finalize;
}

static void mln_pixel_texture_init(MlnPixelTexture* self) {
  self->frames = new std::shared_ptr<maplibre_native::PixelFrames>();
}

namespace maplibre_native {

PixelTexture::PixelTexture(FlTextureRegistrar* registrar)
    : registrar_(registrar), frames_(std::make_shared<PixelFrames>()) {
  auto* texture = MLN_PIXEL_TEXTURE(
      g_object_new(mln_pixel_texture_get_type(), nullptr));
  *texture->frames = frames_;
  texture_ = FL_TEXTURE(texture);
  if (fl_texture_registrar_register_texture(registrar_, texture_)) {
    id_ = fl_texture_get_id(texture_);
  }
}

PixelTexture::~PixelTexture() {
  if (id_ >= 0) fl_texture_registrar_unregister_texture(registrar_, texture_);
  g_object_unref(texture_);
}

void PixelTexture::Update(size_t width, size_t height, const uint8_t* pixels,
                          size_t stride) {
  {
    std::lock_guard<std::mutex> lock(frames_->mutex);
    int back = 0;
    while (back == frames_->front || back == frames_->fetched) ++back;
    std::vector<uint8_t>& buffer = frames_->buffers[back];
    const size_t row_bytes = width * 4;
    buffer.resize(row_bytes * height);
    if (stride == row_bytes) {
      std::memcpy(buffer.data(), pixels, buffer.size());
    } else {
      for (size_t row = 0; row < height; ++row) {
        std::memcpy(buffer.data() + row * row_bytes, pixels + row * stride,
                    row_bytes);
      }
    }
    frames_->widths[back] = static_cast<uint32_t>(width);
    frames_->heights[back] = static_cast<uint32_t>(height);
    frames_->front = back;
  }
  fl_texture_registrar_mark_texture_frame_available(registrar_, texture_);
}

}  // namespace maplibre_native
