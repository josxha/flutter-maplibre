#include "gl_texture.h"

#include <unistd.h>

#include <cstdio>
#include <cstring>
#include <utility>

// The GObject that Flutter calls. It holds the frames as long as Flutter holds
// it, which can be past GlTexture.
struct _MlnGlTexture {
  FlTextureGL parent_instance;
  std::shared_ptr<maplibre_native::GlFrames>* frames;
};

G_DECLARE_FINAL_TYPE(MlnGlTexture, mln_gl_texture, MLN, GL_TEXTURE,
                     FlTextureGL)

G_DEFINE_TYPE(MlnGlTexture, mln_gl_texture, fl_texture_gl_get_type())

namespace maplibre_native {

namespace {

// How long populate waits for a fence that Flutter's previous frame
// signals, so that at most one slot waits for its fence at a time and
// MapLibre always has a slot to render into. Such a fence is a frame old and
// has practically always signalled.
constexpr GLuint64 kFenceWaitNs = 50'000'000;

std::string GlError(const char* what, GLenum error) {
  char buffer[64];
  snprintf(buffer, sizeof(buffer), " failed with OpenGL error 0x%04x.",
           static_cast<unsigned>(error));
  return std::string(what) + buffer;
}

// Clears the OpenGL errors of earlier calls.
void ClearGlErrors() {
  for (int i = 0; i < 16 && glGetError() != GL_NO_ERROR; ++i) {
  }
}

// The OpenGL objects of disposed textures, which no populate of their own
// deletes anymore. Any later populate does, as every texture's objects live
// in Flutter's one share group. What the last map leaves here stays until
// the process ends.
std::mutex& OrphanMutex() {
  static std::mutex mutex;
  return mutex;
}

GlGarbage& Orphans() {
  static GlGarbage* garbage = new GlGarbage();
  return *garbage;
}

// Why the current context, which is Flutter's, cannot sample the ring, or
// an empty string when it can.
std::string CheckFlutterContext(const GlFrames& frames) {
  if (epoxy_gl_version() < 30) {
    return "Flutter's OpenGL context is older than OpenGL ES 3.0.";
  }
  if (!epoxy_has_gl_extension("GL_EXT_memory_object") ||
      !epoxy_has_gl_extension("GL_EXT_memory_object_fd")) {
    return "Flutter's OpenGL context lacks GL_EXT_memory_object_fd.";
  }
  GLint device_count = 0;
  glGetIntegerv(GL_NUM_DEVICE_UUIDS_EXT, &device_count);
  bool device_found = false;
  for (GLint i = 0; i < device_count && !device_found; ++i) {
    GLubyte uuid[GL_UUID_SIZE_EXT] = {};
    glGetUnsignedBytei_vEXT(GL_DEVICE_UUID_EXT, static_cast<GLuint>(i), uuid);
    device_found = std::memcmp(uuid, frames.device_uuid.bytes,
                               VK_UUID_SIZE) == 0;
  }
  GLubyte driver[GL_UUID_SIZE_EXT] = {};
  glGetUnsignedBytevEXT(GL_DRIVER_UUID_EXT, driver);
  if (!device_found ||
      std::memcmp(driver, frames.driver_uuid, VK_UUID_SIZE) != 0) {
    return "Flutter's OpenGL context runs on another GPU or driver than "
           "Vulkan.";
  }
  return {};
}

// Imports |slot|'s memory into the current context, which is Flutter's, as a
// texture of |width| x |height|. Restores the texture binding, which Flutter
// may track.
bool ImportSlot(GlSlot* slot, uint32_t width, uint32_t height,
                std::string* error) {
  GLint previous_texture = 0;
  glGetIntegerv(GL_TEXTURE_BINDING_2D, &previous_texture);
  ClearGlErrors();
  glCreateMemoryObjectsEXT(1, &slot->memory_object);
  const GLint dedicated = GL_TRUE;
  glMemoryObjectParameterivEXT(slot->memory_object,
                               GL_DEDICATED_MEMORY_OBJECT_EXT, &dedicated);
  // OpenGL owns the file descriptor once the import succeeds.
  glImportMemoryFdEXT(slot->memory_object, slot->size,
                      GL_HANDLE_TYPE_OPAQUE_FD_EXT, slot->fd);
  if (const GLenum gl_error = glGetError(); gl_error != GL_NO_ERROR) {
    close(slot->fd);
    slot->fd = -1;
    glDeleteMemoryObjectsEXT(1, &slot->memory_object);
    slot->memory_object = 0;
    *error = GlError("glImportMemoryFdEXT", gl_error);
    return false;
  }
  slot->fd = -1;
  glGenTextures(1, &slot->texture);
  glBindTexture(GL_TEXTURE_2D, slot->texture);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_TILING_EXT, GL_OPTIMAL_TILING_EXT);
  glTexStorageMem2DEXT(GL_TEXTURE_2D, 1, GL_RGBA8, static_cast<GLsizei>(width),
                       static_cast<GLsizei>(height), slot->memory_object, 0);
  // One level, so the texture is only complete without mipmap filtering.
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
  glBindTexture(GL_TEXTURE_2D, static_cast<GLuint>(previous_texture));
  if (const GLenum gl_error = glGetError(); gl_error != GL_NO_ERROR) {
    *error = GlError("glTexStorageMem2DEXT", gl_error);
    return false;
  }
  return true;
}

// Moves Flutter from the shown slot to the front slot. The shown slot gets
// a fence after the draws that sampled it, and older fences are polled.
void ShowFront(GlFrames* frames) {
  const int previous = frames->shown;
  if (previous != frames->front && previous >= 0) {
    GlSlot& slot = frames->slots[previous];
    if (slot.fence != nullptr) glDeleteSync(slot.fence);
    slot.fence = glFenceSync(GL_SYNC_GPU_COMMANDS_COMPLETE, 0);
  }
  frames->shown = frames->front;
  for (int i = 0; i < static_cast<int>(frames->slots.size()); ++i) {
    GlSlot& slot = frames->slots[i];
    if (slot.fence == nullptr) continue;
    // The new fence is only polled, and flushed so that it signals.
    const GLuint64 timeout = i == previous ? 0 : kFenceWaitNs;
    const GLenum result =
        glClientWaitSync(slot.fence, GL_SYNC_FLUSH_COMMANDS_BIT, timeout);
    if (result != GL_TIMEOUT_EXPIRED) {
      // Signalled, or failed, which no later wait would change.
      glDeleteSync(slot.fence);
      slot.fence = nullptr;
    }
  }
}

}  // namespace

void GlGarbage::Append(GlGarbage&& other) {
  textures.insert(textures.end(), other.textures.begin(),
                  other.textures.end());
  memory_objects.insert(memory_objects.end(), other.memory_objects.begin(),
                        other.memory_objects.end());
  fences.insert(fences.end(), other.fences.begin(), other.fences.end());
  other = GlGarbage{};
}

void GlGarbage::Delete() {
  if (!textures.empty()) {
    glDeleteTextures(static_cast<GLsizei>(textures.size()), textures.data());
  }
  if (!memory_objects.empty()) {
    glDeleteMemoryObjectsEXT(static_cast<GLsizei>(memory_objects.size()),
                             memory_objects.data());
  }
  for (GLsync fence : fences) glDeleteSync(fence);
  *this = GlGarbage{};
}

namespace {

// Moves the OpenGL objects of |slots| into |garbage| and closes the file
// descriptors that were never imported.
void Discard(std::vector<GlSlot>* slots, GlGarbage* garbage) {
  for (GlSlot& slot : *slots) {
    if (slot.fd >= 0) close(slot.fd);
    if (slot.texture != 0) garbage->textures.push_back(slot.texture);
    if (slot.memory_object != 0) {
      garbage->memory_objects.push_back(slot.memory_object);
    }
    if (slot.fence != nullptr) garbage->fences.push_back(slot.fence);
  }
  slots->clear();
}

// Runs on the raster thread, with Flutter's context current.
gboolean mln_gl_texture_populate(FlTextureGL* texture, uint32_t* target,
                                 uint32_t* name, uint32_t* width,
                                 uint32_t* height, GError** error) {
  {
    std::lock_guard<std::mutex> lock(OrphanMutex());
    Orphans().Delete();
  }
  GlFrames& frames = **MLN_GL_TEXTURE(texture)->frames;
  std::lock_guard<std::mutex> lock(frames.mutex);
  frames.garbage.Delete();
  // Flutter reads the error whenever this returns FALSE.
  auto fail = [error](const std::string& message) {
    g_set_error_literal(error, g_quark_from_static_string("maplibre-native"),
                        0, message.c_str());
    return FALSE;
  };
  if (frames.front < 0) return fail("No map frame rendered yet.");
  if (!frames.checked) {
    frames.checked = true;
    frames.failure = CheckFlutterContext(frames);
    if (!frames.failure.empty()) {
      g_warning("maplibre_native: zero-copy textures show nothing: %s",
                frames.failure.c_str());
    }
  }
  GlSlot& slot = frames.slots[frames.front];
  if (frames.failure.empty() && slot.texture == 0 &&
      !ImportSlot(&slot, frames.width, frames.height, &frames.failure)) {
    g_warning("maplibre_native: zero-copy textures show nothing: %s",
              frames.failure.c_str());
  }
  if (!frames.failure.empty()) return fail(frames.failure);
  ShowFront(&frames);
  *target = GL_TEXTURE_2D;
  *name = slot.texture;
  *width = frames.width;
  *height = frames.height;
  return TRUE;
}

void mln_gl_texture_finalize(GObject* object) {
  delete MLN_GL_TEXTURE(object)->frames;
  G_OBJECT_CLASS(mln_gl_texture_parent_class)->finalize(object);
}

}  // namespace

}  // namespace maplibre_native

static void mln_gl_texture_class_init(MlnGlTextureClass* klass) {
  FL_TEXTURE_GL_CLASS(klass)->populate = maplibre_native::mln_gl_texture_populate;
  G_OBJECT_CLASS(klass)->finalize = maplibre_native::mln_gl_texture_finalize;
}

static void mln_gl_texture_init(MlnGlTexture* self) {
  self->frames = new std::shared_ptr<maplibre_native::GlFrames>();
}

namespace maplibre_native {

namespace {

constexpr VkExternalMemoryHandleTypeFlagBits kHandleType =
    VK_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_FD_BIT;

}  // namespace

// static
std::unique_ptr<GlDevice> GlDevice::Create(FlView* view, std::string* error) {
  if (view == nullptr) {
    *error = "Flutter runs without a view.";
    return nullptr;
  }
  GdkWindow* window = gtk_widget_get_window(GTK_WIDGET(view));
  if (window == nullptr) {
    *error = "The Flutter view has no window yet.";
    return nullptr;
  }
  GError* gl_error = nullptr;
  GdkGLContext* context = gdk_window_create_gl_context(window, &gl_error);
  if (context != nullptr && !gdk_gl_context_realize(context, &gl_error)) {
    g_clear_object(&context);
  }
  if (context == nullptr) {
    *error = std::string("Creating an OpenGL context failed: ") +
             (gl_error != nullptr ? gl_error->message : "unknown error");
    g_clear_error(&gl_error);
    return nullptr;
  }

  GdkGLContext* previous = gdk_gl_context_get_current();
  if (previous != nullptr) g_object_ref(previous);
  gdk_gl_context_make_current(context);
  std::unique_ptr<GlDevice> device(new GlDevice());
  GLint device_count = 0;
  if (!epoxy_has_gl_extension("GL_EXT_memory_object") ||
      !epoxy_has_gl_extension("GL_EXT_memory_object_fd")) {
    *error = "OpenGL lacks GL_EXT_memory_object_fd.";
    device.reset();
  } else if (glGetIntegerv(GL_NUM_DEVICE_UUIDS_EXT, &device_count),
             device_count < 1) {
    *error = "OpenGL reports no device UUID.";
    device.reset();
  } else {
    glGetUnsignedBytei_vEXT(GL_DEVICE_UUID_EXT, 0, device->device_uuid_.bytes);
    device->device_uuid_.size = VK_UUID_SIZE;
    glGetUnsignedBytevEXT(GL_DRIVER_UUID_EXT, device->driver_uuid_);
  }
  if (previous != nullptr) {
    gdk_gl_context_make_current(previous);
    g_object_unref(previous);
  } else {
    gdk_gl_context_clear_current();
  }
  g_object_unref(context);
  return device;
}

// static
std::unique_ptr<GlTexture> GlTexture::Create(FlTextureRegistrar* registrar,
                                             VulkanDevice* vulkan,
                                             const GlDevice* gl,
                                             uint32_t width, uint32_t height,
                                             uint32_t slot_count,
                                             std::string* error) {
  if (!vulkan->shares_memory()) {
    *error = "The Vulkan device cannot export memory to OpenGL.";
    return nullptr;
  }
  if (!vulkan->matches_gpu() ||
      std::memcmp(vulkan->driver_uuid(), gl->driver_uuid(), VK_UUID_SIZE) !=
          0) {
    *error = "Vulkan and OpenGL run on different GPUs or drivers.";
    return nullptr;
  }
  std::unique_ptr<GlTexture> texture(new GlTexture(registrar, vulkan));
  GlFrames& frames = *texture->frames_;
  frames.device_uuid = gl->device_uuid();
  std::memcpy(frames.driver_uuid, gl->driver_uuid(), VK_UUID_SIZE);
  if (!texture->CreateImages(width, height, slot_count, &texture->images_,
                             &frames.slots, error)) {
    return nullptr;
  }
  frames.width = width;
  frames.height = height;

  auto* object =
      MLN_GL_TEXTURE(g_object_new(mln_gl_texture_get_type(), nullptr));
  *object->frames = texture->frames_;
  texture->texture_ = FL_TEXTURE(object);
  if (!fl_texture_registrar_register_texture(registrar, texture->texture_)) {
    *error = "Flutter did not register the texture.";
    return nullptr;
  }
  texture->id_ = fl_texture_get_id(texture->texture_);
  return texture;
}

GlTexture::GlTexture(FlTextureRegistrar* registrar, VulkanDevice* vulkan)
    : registrar_(registrar),
      vulkan_(vulkan),
      frames_(std::make_shared<GlFrames>()) {}

GlTexture::~GlTexture() {
  if (texture_ != nullptr) {
    if (id_ >= 0) fl_texture_registrar_unregister_texture(registrar_, texture_);
    g_object_unref(texture_);
  }
  GlGarbage garbage;
  {
    std::lock_guard<std::mutex> lock(frames_->mutex);
    Discard(&frames_->slots, &garbage);
    garbage.Append(std::move(frames_->garbage));
    frames_->front = -1;
    frames_->shown = -1;
  }
  {
    std::lock_guard<std::mutex> lock(OrphanMutex());
    Orphans().Append(std::move(garbage));
  }
  // OpenGL keeps the memory it imported until its objects are deleted.
  for (auto& image : images_) DestroyImage(&image);
  ReleaseRetiredSlots();
}

std::vector<VulkanSlot> GlTexture::slots() const {
  std::vector<VulkanSlot> slots;
  for (const auto& image : images_) slots.push_back({image.image, image.view});
  return slots;
}

bool GlTexture::CreateImages(uint32_t width, uint32_t height, uint32_t count,
                             std::vector<VulkanImage>* images,
                             std::vector<GlSlot>* gl_slots,
                             std::string* error) {
  images->resize(count);
  gl_slots->resize(count);
  for (uint32_t i = 0; i < count; ++i) {
    if (!CreateImage(width, height, &(*images)[i], &(*gl_slots)[i], error)) {
      for (auto& image : *images) DestroyImage(&image);
      for (auto& slot : *gl_slots) {
        if (slot.fd >= 0) close(slot.fd);
      }
      images->clear();
      gl_slots->clear();
      return false;
    }
  }
  return true;
}

bool GlTexture::CreateImage(uint32_t width, uint32_t height,
                            VulkanImage* image, GlSlot* gl_slot,
                            std::string* error) {
  VkDevice device = vulkan_->device();
  VkExternalMemoryImageCreateInfo external{
      VK_STRUCTURE_TYPE_EXTERNAL_MEMORY_IMAGE_CREATE_INFO};
  external.handleTypes = kHandleType;
  VkImageCreateInfo image_info{VK_STRUCTURE_TYPE_IMAGE_CREATE_INFO};
  image_info.pNext = &external;
  image_info.imageType = VK_IMAGE_TYPE_2D;
  image_info.format = kVulkanFormat;
  image_info.extent = {width, height, 1};
  image_info.mipLevels = 1;
  image_info.arrayLayers = 1;
  image_info.samples = VK_SAMPLE_COUNT_1_BIT;
  image_info.tiling = VK_IMAGE_TILING_OPTIMAL;
  image_info.usage = VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT |
                     VK_IMAGE_USAGE_SAMPLED_BIT |
                     VK_IMAGE_USAGE_TRANSFER_SRC_BIT |
                     VK_IMAGE_USAGE_TRANSFER_DST_BIT;
  image_info.sharingMode = VK_SHARING_MODE_EXCLUSIVE;
  image_info.initialLayout = VK_IMAGE_LAYOUT_UNDEFINED;
  if (vulkan_->vkCreateImage(device, &image_info, nullptr, &image->image) !=
      VK_SUCCESS) {
    *error = "vkCreateImage for an exportable image failed.";
    return false;
  }

  VkMemoryRequirements requirements{};
  vulkan_->vkGetImageMemoryRequirements(device, image->image, &requirements);
  VkPhysicalDeviceMemoryProperties memory_properties{};
  vulkan_->vkGetPhysicalDeviceMemoryProperties(vulkan_->physical_device(),
                                               &memory_properties);
  uint32_t memory_type = UINT32_MAX;
  for (uint32_t i = 0; i < memory_properties.memoryTypeCount; ++i) {
    if ((requirements.memoryTypeBits & (1u << i)) == 0) continue;
    const bool device_local = (memory_properties.memoryTypes[i].propertyFlags &
                               VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT) != 0;
    if (memory_type == UINT32_MAX || device_local) memory_type = i;
    if (device_local) break;
  }
  if (memory_type == UINT32_MAX) {
    *error = "No Vulkan memory type fits the exportable image.";
    return false;
  }

  VkMemoryDedicatedAllocateInfo dedicated{
      VK_STRUCTURE_TYPE_MEMORY_DEDICATED_ALLOCATE_INFO};
  dedicated.image = image->image;
  VkExportMemoryAllocateInfo export_info{
      VK_STRUCTURE_TYPE_EXPORT_MEMORY_ALLOCATE_INFO};
  export_info.pNext = &dedicated;
  export_info.handleTypes = kHandleType;
  VkMemoryAllocateInfo allocate{VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO};
  allocate.pNext = &export_info;
  allocate.allocationSize = requirements.size;
  allocate.memoryTypeIndex = memory_type;
  if (vulkan_->vkAllocateMemory(device, &allocate, nullptr, &image->memory) !=
          VK_SUCCESS ||
      vulkan_->vkBindImageMemory(device, image->image, image->memory, 0) !=
          VK_SUCCESS) {
    *error = "Allocating exportable Vulkan memory failed.";
    return false;
  }
  // Flutter's context imports the memory in populate.
  VkMemoryGetFdInfoKHR fd_info{VK_STRUCTURE_TYPE_MEMORY_GET_FD_INFO_KHR};
  fd_info.memory = image->memory;
  fd_info.handleType = kHandleType;
  if (vulkan_->vkGetMemoryFdKHR(device, &fd_info, &gl_slot->fd) !=
      VK_SUCCESS) {
    gl_slot->fd = -1;
    *error = "vkGetMemoryFdKHR failed.";
    return false;
  }
  gl_slot->size = requirements.size;

  VkImageViewCreateInfo view_info{VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO};
  view_info.image = image->image;
  view_info.viewType = VK_IMAGE_VIEW_TYPE_2D;
  view_info.format = kVulkanFormat;
  view_info.subresourceRange = {VK_IMAGE_ASPECT_COLOR_BIT, 0, 1, 0, 1};
  if (vulkan_->vkCreateImageView(device, &view_info, nullptr, &image->view) !=
      VK_SUCCESS) {
    *error = "vkCreateImageView for an exportable image failed.";
    return false;
  }
  return true;
}

void GlTexture::DestroyImage(VulkanImage* image) {
  VkDevice device = vulkan_->device();
  if (image->view != VK_NULL_HANDLE) {
    vulkan_->vkDestroyImageView(device, image->view, nullptr);
  }
  if (image->image != VK_NULL_HANDLE) {
    vulkan_->vkDestroyImage(device, image->image, nullptr);
  }
  if (image->memory != VK_NULL_HANDLE) {
    vulkan_->vkFreeMemory(device, image->memory, nullptr);
  }
  *image = VulkanImage{};
}

bool GlTexture::Resize(uint32_t width, uint32_t height, std::string* error) {
  std::vector<VulkanImage> images;
  std::vector<GlSlot> gl_slots;
  if (!CreateImages(width, height, static_cast<uint32_t>(images_.size()),
                    &images, &gl_slots, error)) {
    return false;
  }
  {
    // Flutter samples the old shown slot until it populates the new ring,
    // and that populate deletes the old ring's objects first.
    std::lock_guard<std::mutex> lock(frames_->mutex);
    Discard(&frames_->slots, &frames_->garbage);
    frames_->slots = std::move(gl_slots);
    frames_->width = width;
    frames_->height = height;
    frames_->front = -1;
    frames_->shown = -1;
  }
  retired_images_.push_back(std::move(images_));
  images_ = std::move(images);
  return true;
}

void GlTexture::ReleaseRetiredSlots() {
  // OpenGL keeps the memory it imported until populate deletes its objects.
  for (auto& images : retired_images_) {
    for (auto& image : images) DestroyImage(&image);
  }
  retired_images_.clear();
}

bool GlTexture::Present(uint32_t slot, std::string* error) {
  {
    std::lock_guard<std::mutex> lock(frames_->mutex);
    if (slot >= frames_->slots.size()) {
      *error = "The slot does not exist.";
      return false;
    }
    frames_->front = static_cast<int>(slot);
  }
  fl_texture_registrar_mark_texture_frame_available(registrar_, texture_);
  return true;
}

bool GlTexture::SlotInUse(uint32_t slot) const {
  std::lock_guard<std::mutex> lock(frames_->mutex);
  if (slot >= frames_->slots.size()) return false;
  const int index = static_cast<int>(slot);
  return index == frames_->front || index == frames_->shown ||
         frames_->slots[slot].fence != nullptr;
}

}  // namespace maplibre_native
