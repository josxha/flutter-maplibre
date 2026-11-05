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

// The GPU and driver that OpenGL renders Flutter's window on, read once from an
// EGL context that the plugin creates like Flutter's own: OpenGL ES on the
// window's display. The Vulkan device is created on that GPU, so that OpenGL
// can import its memory. A context that cannot import it fails here, so the
// map falls back to CPU readback before it is shown.
class GlDevice {
 public:
  // Reads the IDs for |view|. Returns null and sets |error| when the window
  // has no OpenGL ES 3 or it lacks the extensions that import Vulkan memory.
  static std::unique_ptr<GlDevice> Create(FlView* view, std::string* error);

  // The device and driver UUIDs that OpenGL reports, which a Vulkan device
  // needs to match to share memory.
  const GpuId& device_uuid() const { return device_uuid_; }
  const uint8_t* driver_uuid() const { return driver_uuid_; }

 private:
  GlDevice() = default;

  GpuId device_uuid_;
  uint8_t driver_uuid_[VK_UUID_SIZE] = {};
};

// OpenGL objects that can only be deleted with a context of Flutter's share
// group current, which only populate has.
struct GlGarbage {
  std::vector<GLuint> textures;
  std::vector<GLuint> memory_objects;
  std::vector<GLsync> fences;

  void Append(GlGarbage&& other);
  // Deletes everything, with a context of Flutter's share group current.
  void Delete();
};

// One ring image as Flutter's OpenGL context sees it.
struct GlSlot {
  // The exported Vulkan memory, until populate imports it.
  int fd = -1;
  uint64_t size = 0;
  // The imported memory and the texture on it, in Flutter's share group.
  GLuint memory_object = 0;
  GLuint texture = 0;
  // Signals once Flutter's draws that sampled the slot are done. Set when
  // populate moves Flutter on to another slot.
  GLsync fence = nullptr;
};

// What Flutter's raster thread reads of a GlTexture. It is shared with the
// GObject that Flutter calls, which can outlive the GlTexture.
struct GlFrames {
  std::mutex mutex;
  std::vector<GlSlot> slots;
  uint32_t width = 0;
  uint32_t height = 0;
  // The latest presented slot.
  int front = -1;
  // The slot that populate handed to Flutter last, which Flutter samples
  // until it populates again.
  int shown = -1;
  // The UUIDs of the GPU and driver that the Vulkan device runs on, checked
  // against Flutter's context once.
  GpuId device_uuid;
  uint8_t driver_uuid[VK_UUID_SIZE] = {};
  bool checked = false;
  // Why Flutter's context cannot sample the ring, once that is known.
  std::string failure;
  // A 1x1 transparent texture that Flutter samples until the first frame is
  // presented, since Flutter logs every failed populate.
  GLuint placeholder = 0;
  // The OpenGL objects of replaced rings.
  GlGarbage garbage;
};

// The Linux GpuTexture, a Flutter OpenGL texture. MapLibre renders through
// Vulkan into a ring of images with exportable memory. Flutter renders in EGL
// contexts of its own, which share nothing with any context the plugin could
// create, so populate, which runs with one of them current, imports each
// slot's memory there once and hands Flutter the texture of the latest
// presented slot to sample directly, without a copy.
//
// Flutter takes no fence for an external texture, so a slot stays in use
// while Flutter may sample it: while it is the front or the shown slot, and
// until a fence that populate inserts after Flutter moved on has signalled.
// Dart keeps a frame acquired until SlotInUse reports its slot free.
class GlTexture : public GpuTexture {
 public:
  // RGBA8, which OpenGL imports as GL_RGBA8.
  static constexpr VkFormat kVulkanFormat = VK_FORMAT_R8G8B8A8_UNORM;

  // Creates a texture of |width| x |height| device pixels with |slot_count|
  // ring images. Returns null and sets |error| when Vulkan cannot share
  // memory with |gl|.
  static std::unique_ptr<GlTexture> Create(FlTextureRegistrar* registrar,
                                           VulkanDevice* vulkan,
                                           const GlDevice* gl, uint32_t width,
                                           uint32_t height, uint32_t slot_count,
                                           std::string* error);

  // Unregisters the texture and destroys its images. The session that
  // rendered into them released them before. Their OpenGL objects are
  // deleted by a later populate of any texture.
  ~GlTexture() override;

  GlTexture(const GlTexture&) = delete;
  GlTexture& operator=(const GlTexture&) = delete;

  int64_t id() const override { return id_; }
  VkFormat format() const override { return kVulkanFormat; }
  std::vector<VulkanSlot> slots() const override;
  bool Resize(uint32_t width, uint32_t height, std::string* error) override;
  void ReleaseRetiredSlots() override;
  bool Present(uint32_t slot, std::string* error) override;
  bool SlotInUse(uint32_t slot) const override;

 private:
  // One image of the ring, which Vulkan owns.
  struct VulkanImage {
    VkImage image = VK_NULL_HANDLE;
    VkDeviceMemory memory = VK_NULL_HANDLE;
    VkImageView view = VK_NULL_HANDLE;
  };

  GlTexture(FlTextureRegistrar* registrar, VulkanDevice* vulkan);

  // Creates |count| images and their exported memory in |gl_slots|.
  bool CreateImages(uint32_t width, uint32_t height, uint32_t count,
                    std::vector<VulkanImage>* images,
                    std::vector<GlSlot>* gl_slots, std::string* error);
  bool CreateImage(uint32_t width, uint32_t height, VulkanImage* image,
                   GlSlot* gl_slot, std::string* error);
  void DestroyImage(VulkanImage* image);

  FlTextureRegistrar* registrar_;
  VulkanDevice* vulkan_;
  FlTexture* texture_ = nullptr;
  int64_t id_ = -1;

  std::vector<VulkanImage> images_;
  std::vector<std::vector<VulkanImage>> retired_images_;

  std::shared_ptr<GlFrames> frames_;
};

}  // namespace maplibre_native

#endif  // FLUTTER_PLUGIN_MAPLIBRE_NATIVE_GL_TEXTURE_H_
