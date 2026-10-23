#ifndef FLUTTER_PLUGIN_MAPLIBRE_NATIVE_GL_TEXTURE_H_
#define FLUTTER_PLUGIN_MAPLIBRE_NATIVE_GL_TEXTURE_H_

#include <epoxy/gl.h>
#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>

#include <cstdint>
#include <memory>
#include <mutex>
#include <string>
#include <vector>

#include "desktop_plugin.h"
#include "vulkan_device.h"

namespace maplibre_native {

// The OpenGL context the plugin copies frames in, created from Flutter's
// window so that it shares textures with the contexts Flutter renders in.
// GDK contexts are only used on the GTK main thread.
class GlContext {
 public:
  // Creates the context for |view|. Returns null and sets |error| when the
  // window has no OpenGL or the context lacks the extensions that import
  // Vulkan memory.
  static std::unique_ptr<GlContext> Create(FlView* view, std::string* error);

  ~GlContext();

  GlContext(const GlContext&) = delete;
  GlContext& operator=(const GlContext&) = delete;

  // The device and driver UUIDs that OpenGL reports, which a Vulkan device
  // needs to match to share memory.
  const GpuId& device_uuid() const { return device_uuid_; }
  const uint8_t* driver_uuid() const { return driver_uuid_; }

  // Makes the context current until the scope ends, then restores the context
  // that was current before.
  class Scope {
   public:
    explicit Scope(GlContext* context);
    ~Scope();
    Scope(const Scope&) = delete;
    Scope& operator=(const Scope&) = delete;

   private:
    GdkGLContext* previous_;
  };

 private:
  explicit GlContext(GdkGLContext* context) : context_(context) {}

  GdkGLContext* context_;
  GpuId device_uuid_;
  uint8_t driver_uuid_[VK_UUID_SIZE] = {};
};

// What Flutter's raster thread reads of a GlTexture. It is shared with the
// GObject that Flutter calls, which can outlive the GlTexture.
struct GlFrames {
  std::mutex mutex;
  static constexpr int kPresentCount = 3;
  GLuint textures[kPresentCount] = {};
  uint32_t width = 0;
  uint32_t height = 0;
  // The texture of the latest presented frame.
  int front = -1;
  // The texture Flutter fetched last, which it may still be reading.
  int fetched = -1;
};

// The Linux GpuTexture, a Flutter OpenGL texture. MapLibre renders through
// Vulkan into a ring of images whose memory OpenGL imports as an opaque file
// descriptor; each presented frame is copied on the GPU into one of three
// textures that Flutter samples.
//
// Flutter's OpenGL contexts take no semaphore for an external texture, so the
// copy cannot wait for Flutter's reads. Instead it never targets the texture
// Flutter shows or fetched last, as on Windows.
class GlTexture : public GpuTexture {
 public:
  // RGBA8, which OpenGL imports as GL_RGBA8.
  static constexpr VkFormat kVulkanFormat = VK_FORMAT_R8G8B8A8_UNORM;

  // Creates a texture of |width| x |height| device pixels with |slot_count|
  // ring images. Returns null and sets |error| when Vulkan cannot share
  // memory with |gl|.
  static std::unique_ptr<GlTexture> Create(FlTextureRegistrar* registrar,
                                           VulkanDevice* vulkan, GlContext* gl,
                                           uint32_t width, uint32_t height,
                                           uint32_t slot_count,
                                           std::string* error);

  // Unregisters the texture and destroys its images. The session that
  // rendered into them released them before.
  ~GlTexture() override;

  GlTexture(const GlTexture&) = delete;
  GlTexture& operator=(const GlTexture&) = delete;

  int64_t id() const override { return id_; }
  VkFormat format() const override { return kVulkanFormat; }
  std::vector<VulkanSlot> slots() const override;
  bool Resize(uint32_t width, uint32_t height, std::string* error) override;
  void ReleaseRetiredSlots() override;
  bool Present(uint32_t slot, std::string* error) override;

 private:
  // One image of the ring: Vulkan memory that OpenGL imported.
  struct SharedSlot {
    VkImage image = VK_NULL_HANDLE;
    VkDeviceMemory memory = VK_NULL_HANDLE;
    VkImageView view = VK_NULL_HANDLE;
    GLuint memory_object = 0;
    GLuint texture = 0;
  };

  GlTexture(FlTextureRegistrar* registrar, VulkanDevice* vulkan, GlContext* gl);

  bool CreateSlots(uint32_t width, uint32_t height, uint32_t count,
                   std::vector<SharedSlot>* slots, std::string* error);
  bool CreateSlot(uint32_t width, uint32_t height, SharedSlot* slot,
                  std::string* error);
  // Called with the OpenGL context current.
  void DestroySlot(SharedSlot* slot);
  bool CreatePresentTextures(uint32_t width, uint32_t height,
                             std::string* error);

  FlTextureRegistrar* registrar_;
  VulkanDevice* vulkan_;
  GlContext* gl_;
  FlTexture* texture_ = nullptr;
  int64_t id_ = -1;

  std::vector<SharedSlot> slots_;
  std::vector<std::vector<SharedSlot>> retired_slots_;
  GLuint read_framebuffer_ = 0;
  GLuint draw_framebuffer_ = 0;

  std::shared_ptr<GlFrames> frames_;
  // Present textures of earlier sizes, kept until Flutter has had a frame to
  // move on to the current ones.
  std::vector<std::pair<int, GLuint>> retired_present_;
};

}  // namespace maplibre_native

#endif  // FLUTTER_PLUGIN_MAPLIBRE_NATIVE_GL_TEXTURE_H_
