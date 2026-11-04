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
  // The texture Flutter fetched before that.
  int previous_fetched = -1;
  // File descriptors for Vulkan memory of each slot, to import in populate().
  int fds[kPresentCount] = {};
  // Memory sizes for each slot, needed for glImportMemoryFdEXT.
  VkDeviceSize memory_sizes[kPresentCount] = {};
  // OpenGL memory objects for each slot, created in Flutter's context.
  GLuint memory_objects[kPresentCount] = {};
  // Vulkan device UUID for compatibility checking with Flutter's EGL context.
  // Set in Create() so populate() can verify compatibility.
  GpuId vulkan_device_uuid;
  // Whether Vulkan and Flutter's OpenGL are on the same GPU.
  // Checked in populate() by comparing device UUIDs.
  bool vulkan_matches_flutter_gl = true;
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
  
  // Returns the file descriptor for the Vulkan memory of |slot|, to import
  // in Flutter's context. Returns -1 when the slot is not ready.
  int GetSlotFd(uint32_t slot);
  
  // Returns whether |slot| is currently being used by Flutter (either
  // fetched or previous_fetched).
  bool SlotInUse(uint32_t slot);

 private:
  // One image of the ring: Vulkan memory that OpenGL imports.
  struct SharedSlot {
    VkImage image = VK_NULL_HANDLE;
    VkDeviceMemory memory = VK_NULL_HANDLE;
    VkImageView view = VK_NULL_HANDLE;
    // Memory size, needed for glImportMemoryFdEXT.
    VkDeviceSize memory_size = 0;
    // File descriptor for the Vulkan memory, to import in Flutter's context.
    int fd = -1;
    // OpenGL memory object created in Flutter's context.
    // Note: This is created in populate() and must be deleted there.
    GLuint memory_object = 0;
    // OpenGL texture created in Flutter's context.
    // Note: This is created in populate() and must be deleted there.
    GLuint texture = 0;
  };

  GlTexture(FlTextureRegistrar* registrar, VulkanDevice* vulkan, GlContext* gl);

  bool CreateSlots(uint32_t width, uint32_t height, uint32_t count,
                   std::vector<SharedSlot>* slots, std::string* error);
  bool CreateSlot(uint32_t width, uint32_t height, SharedSlot* slot,
                  std::string* error);
  // Called with the OpenGL context current.
  void DestroySlot(SharedSlot* slot);

  FlTextureRegistrar* registrar_;
  VulkanDevice* vulkan_;
  GlContext* gl_;
  FlTexture* texture_ = nullptr;
  int64_t id_ = -1;

  std::vector<SharedSlot> slots_;
  std::vector<std::vector<SharedSlot>> retired_slots_;
  
  std::shared_ptr<GlFrames> frames_;
  
  // Mutex to protect slot tracking.
  std::mutex slot_mutex_;
  // The slot that was last presented.
  int presented_slot_ = -1;
};

}  // namespace maplibre_native

#endif  // FLUTTER_PLUGIN_MAPLIBRE_NATIVE_GL_TEXTURE_H_
