#include "gl_texture.h"

#include <unistd.h>

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

namespace {

// Runs on the raster thread, with Flutter's context current.
gboolean mln_gl_texture_populate(FlTextureGL* texture, uint32_t* target,
                                 uint32_t* name, uint32_t* width,
                                 uint32_t* height, GError** error) {
  maplibre_native::GlFrames& frames = **MLN_GL_TEXTURE(texture)->frames;
  std::lock_guard<std::mutex> lock(frames.mutex);
  if (frames.front < 0) return FALSE;
  frames.fetched = frames.front;
  *target = GL_TEXTURE_2D;
  *name = frames.textures[frames.front];
  *width = frames.width;
  *height = frames.height;
  return TRUE;
}

void mln_gl_texture_finalize(GObject* object) {
  delete MLN_GL_TEXTURE(object)->frames;
  G_OBJECT_CLASS(mln_gl_texture_parent_class)->finalize(object);
}

}  // namespace

static void mln_gl_texture_class_init(MlnGlTextureClass* klass) {
  FL_TEXTURE_GL_CLASS(klass)->populate = mln_gl_texture_populate;
  G_OBJECT_CLASS(klass)->finalize = mln_gl_texture_finalize;
}

static void mln_gl_texture_init(MlnGlTexture* self) {
  self->frames = new std::shared_ptr<maplibre_native::GlFrames>();
}

namespace maplibre_native {

namespace {

constexpr VkExternalMemoryHandleTypeFlagBits kHandleType =
    VK_EXTERNAL_MEMORY_HANDLE_TYPE_OPAQUE_FD_BIT;

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

}  // namespace

// static
std::unique_ptr<GlContext> GlContext::Create(FlView* view,
                                             std::string* error) {
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

  std::unique_ptr<GlContext> gl(new GlContext(context));
  Scope scope(gl.get());
  if (epoxy_gl_version() < 30) {
    *error = "OpenGL 3.0 or OpenGL ES 3.0 is needed to copy frames.";
    return nullptr;
  }
  if (!epoxy_has_gl_extension("GL_EXT_memory_object") ||
      !epoxy_has_gl_extension("GL_EXT_memory_object_fd")) {
    *error = "OpenGL lacks GL_EXT_memory_object_fd.";
    return nullptr;
  }
  GLint device_count = 0;
  glGetIntegerv(GL_NUM_DEVICE_UUIDS_EXT, &device_count);
  if (device_count < 1) {
    *error = "OpenGL reports no device UUID.";
    return nullptr;
  }
  glGetUnsignedBytei_vEXT(GL_DEVICE_UUID_EXT, 0, gl->device_uuid_.bytes);
  gl->device_uuid_.size = VK_UUID_SIZE;
  glGetUnsignedBytevEXT(GL_DRIVER_UUID_EXT, gl->driver_uuid_);
  return gl;
}

GlContext::~GlContext() { g_object_unref(context_); }

GlContext::Scope::Scope(GlContext* context)
    : previous_(gdk_gl_context_get_current()) {
  if (previous_ != nullptr) g_object_ref(previous_);
  gdk_gl_context_make_current(context->context_);
}

GlContext::Scope::~Scope() {
  if (previous_ != nullptr) {
    gdk_gl_context_make_current(previous_);
    g_object_unref(previous_);
  } else {
    gdk_gl_context_clear_current();
  }
}

// static
std::unique_ptr<GlTexture> GlTexture::Create(FlTextureRegistrar* registrar,
                                             VulkanDevice* vulkan,
                                             GlContext* gl, uint32_t width,
                                             uint32_t height,
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
  std::unique_ptr<GlTexture> texture(new GlTexture(registrar, vulkan, gl));
  {
    GlContext::Scope scope(gl);
    glGenFramebuffers(1, &texture->read_framebuffer_);
    glGenFramebuffers(1, &texture->draw_framebuffer_);
    if (!texture->CreateSlots(width, height, slot_count, &texture->slots_,
                              error) ||
        !texture->CreatePresentTextures(width, height, error)) {
      return nullptr;
    }
  }

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

GlTexture::GlTexture(FlTextureRegistrar* registrar, VulkanDevice* vulkan,
                     GlContext* gl)
    : registrar_(registrar),
      vulkan_(vulkan),
      gl_(gl),
      frames_(std::make_shared<GlFrames>()) {}

GlTexture::~GlTexture() {
  if (texture_ != nullptr) {
    if (id_ >= 0) fl_texture_registrar_unregister_texture(registrar_, texture_);
    g_object_unref(texture_);
  }
  GLuint present[GlFrames::kPresentCount];
  {
    std::lock_guard<std::mutex> lock(frames_->mutex);
    std::memcpy(present, frames_->textures, sizeof(present));
    frames_->front = -1;
  }
  // OpenGL keeps a texture that Flutter still samples until it lets go.
  GlContext::Scope scope(gl_);
  for (auto& slot : slots_) DestroySlot(&slot);
  ReleaseRetiredSlots();
  for (GLuint name : present) {
    if (name != 0) glDeleteTextures(1, &name);
  }
  for (auto& [age, name] : retired_present_) glDeleteTextures(1, &name);
  if (read_framebuffer_ != 0) glDeleteFramebuffers(1, &read_framebuffer_);
  if (draw_framebuffer_ != 0) glDeleteFramebuffers(1, &draw_framebuffer_);
}

std::vector<VulkanSlot> GlTexture::slots() const {
  std::vector<VulkanSlot> slots;
  for (const auto& slot : slots_) slots.push_back({slot.image, slot.view});
  return slots;
}

bool GlTexture::CreateSlots(uint32_t width, uint32_t height, uint32_t count,
                            std::vector<SharedSlot>* slots,
                            std::string* error) {
  slots->resize(count);
  for (auto& slot : *slots) {
    if (!CreateSlot(width, height, &slot, error)) {
      for (auto& created : *slots) DestroySlot(&created);
      slots->clear();
      return false;
    }
  }
  return true;
}

bool GlTexture::CreateSlot(uint32_t width, uint32_t height, SharedSlot* slot,
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
  if (vulkan_->vkCreateImage(device, &image_info, nullptr, &slot->image) !=
      VK_SUCCESS) {
    *error = "vkCreateImage for an exportable image failed.";
    return false;
  }

  VkMemoryRequirements requirements{};
  vulkan_->vkGetImageMemoryRequirements(device, slot->image, &requirements);
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
  dedicated.image = slot->image;
  VkExportMemoryAllocateInfo export_info{
      VK_STRUCTURE_TYPE_EXPORT_MEMORY_ALLOCATE_INFO};
  export_info.pNext = &dedicated;
  export_info.handleTypes = kHandleType;
  VkMemoryAllocateInfo allocate{VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO};
  allocate.pNext = &export_info;
  allocate.allocationSize = requirements.size;
  allocate.memoryTypeIndex = memory_type;
  if (vulkan_->vkAllocateMemory(device, &allocate, nullptr, &slot->memory) !=
          VK_SUCCESS ||
      vulkan_->vkBindImageMemory(device, slot->image, slot->memory, 0) !=
          VK_SUCCESS) {
    *error = "Allocating exportable Vulkan memory failed.";
    return false;
  }
  VkMemoryGetFdInfoKHR fd_info{VK_STRUCTURE_TYPE_MEMORY_GET_FD_INFO_KHR};
  fd_info.memory = slot->memory;
  fd_info.handleType = kHandleType;
  int fd = -1;
  if (vulkan_->vkGetMemoryFdKHR(device, &fd_info, &fd) != VK_SUCCESS) {
    *error = "vkGetMemoryFdKHR failed.";
    return false;
  }

  // OpenGL owns the file descriptor once the import succeeds.
  ClearGlErrors();
  glCreateMemoryObjectsEXT(1, &slot->memory_object);
  const GLint dedicated_memory = GL_TRUE;
  glMemoryObjectParameterivEXT(slot->memory_object,
                               GL_DEDICATED_MEMORY_OBJECT_EXT,
                               &dedicated_memory);
  glImportMemoryFdEXT(slot->memory_object, requirements.size,
                      GL_HANDLE_TYPE_OPAQUE_FD_EXT, fd);
  if (const GLenum gl_error = glGetError(); gl_error != GL_NO_ERROR) {
    close(fd);
    *error = GlError("glImportMemoryFdEXT", gl_error);
    return false;
  }
  glGenTextures(1, &slot->texture);
  glBindTexture(GL_TEXTURE_2D, slot->texture);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_TILING_EXT, GL_OPTIMAL_TILING_EXT);
  glTexStorageMem2DEXT(GL_TEXTURE_2D, 1, GL_RGBA8, static_cast<GLsizei>(width),
                       static_cast<GLsizei>(height), slot->memory_object, 0);
  glBindTexture(GL_TEXTURE_2D, 0);
  if (const GLenum gl_error = glGetError(); gl_error != GL_NO_ERROR) {
    *error = GlError("glTexStorageMem2DEXT", gl_error);
    return false;
  }

  VkImageViewCreateInfo view_info{VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO};
  view_info.image = slot->image;
  view_info.viewType = VK_IMAGE_VIEW_TYPE_2D;
  view_info.format = kVulkanFormat;
  view_info.subresourceRange = {VK_IMAGE_ASPECT_COLOR_BIT, 0, 1, 0, 1};
  if (vulkan_->vkCreateImageView(device, &view_info, nullptr, &slot->view) !=
      VK_SUCCESS) {
    *error = "vkCreateImageView for an exportable image failed.";
    return false;
  }
  return true;
}

void GlTexture::DestroySlot(SharedSlot* slot) {
  if (slot->texture != 0) glDeleteTextures(1, &slot->texture);
  if (slot->memory_object != 0) {
    glDeleteMemoryObjectsEXT(1, &slot->memory_object);
  }
  VkDevice device = vulkan_->device();
  if (slot->view != VK_NULL_HANDLE) {
    vulkan_->vkDestroyImageView(device, slot->view, nullptr);
  }
  if (slot->image != VK_NULL_HANDLE) {
    vulkan_->vkDestroyImage(device, slot->image, nullptr);
  }
  if (slot->memory != VK_NULL_HANDLE) {
    vulkan_->vkFreeMemory(device, slot->memory, nullptr);
  }
  *slot = SharedSlot{};
}

bool GlTexture::CreatePresentTextures(uint32_t width, uint32_t height,
                                      std::string* error) {
  GLuint created[GlFrames::kPresentCount] = {};
  ClearGlErrors();
  glGenTextures(GlFrames::kPresentCount, created);
  for (GLuint name : created) {
    glBindTexture(GL_TEXTURE_2D, name);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8, static_cast<GLsizei>(width),
                 static_cast<GLsizei>(height), 0, GL_RGBA, GL_UNSIGNED_BYTE,
                 nullptr);
  }
  glBindTexture(GL_TEXTURE_2D, 0);
  if (const GLenum gl_error = glGetError(); gl_error != GL_NO_ERROR) {
    glDeleteTextures(GlFrames::kPresentCount, created);
    *error = GlError("Creating the Flutter textures", gl_error);
    return false;
  }
  std::lock_guard<std::mutex> lock(frames_->mutex);
  for (int i = 0; i < GlFrames::kPresentCount; ++i) {
    if (frames_->textures[i] != 0) {
      retired_present_.emplace_back(0, frames_->textures[i]);
    }
    frames_->textures[i] = created[i];
  }
  frames_->width = width;
  frames_->height = height;
  frames_->front = -1;
  frames_->fetched = -1;
  return true;
}

bool GlTexture::Resize(uint32_t width, uint32_t height, std::string* error) {
  GlContext::Scope scope(gl_);
  std::vector<SharedSlot> slots;
  if (!CreateSlots(width, height, static_cast<uint32_t>(slots_.size()), &slots,
                   error) ||
      !CreatePresentTextures(width, height, error)) {
    for (auto& slot : slots) DestroySlot(&slot);
    return false;
  }
  retired_slots_.push_back(std::move(slots_));
  slots_ = std::move(slots);
  return true;
}

void GlTexture::ReleaseRetiredSlots() {
  if (retired_slots_.empty()) return;
  GlContext::Scope scope(gl_);
  for (auto& slots : retired_slots_) {
    for (auto& slot : slots) DestroySlot(&slot);
  }
  retired_slots_.clear();
}

bool GlTexture::Present(uint32_t slot, std::string* error) {
  if (slot >= slots_.size()) {
    *error = "The slot does not exist.";
    return false;
  }
  int back = 0;
  GLuint target;
  GLint width;
  GLint height;
  {
    std::lock_guard<std::mutex> lock(frames_->mutex);
    while (back == frames_->front || back == frames_->fetched) ++back;
    target = frames_->textures[back];
    width = static_cast<GLint>(frames_->width);
    height = static_cast<GLint>(frames_->height);
  }

  GlContext::Scope scope(gl_);
  ClearGlErrors();
  glBindFramebuffer(GL_READ_FRAMEBUFFER, read_framebuffer_);
  glFramebufferTexture2D(GL_READ_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
                         GL_TEXTURE_2D, slots_[slot].texture, 0);
  glBindFramebuffer(GL_DRAW_FRAMEBUFFER, draw_framebuffer_);
  glFramebufferTexture2D(GL_DRAW_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
                         GL_TEXTURE_2D, target, 0);
  // Both are top row first, as Vulkan wrote the frame and Flutter samples it.
  glBlitFramebuffer(0, 0, width, height, 0, 0, width, height,
                    GL_COLOR_BUFFER_BIT, GL_NEAREST);
  glBindFramebuffer(GL_READ_FRAMEBUFFER, 0);
  glBindFramebuffer(GL_DRAW_FRAMEBUFFER, 0);
  // Flutter's context reads the texture without a fence, so the copy
  // completes before the frame is offered.
  glFinish();
  if (const GLenum gl_error = glGetError(); gl_error != GL_NO_ERROR) {
    *error = GlError("Copying the frame", gl_error);
    return false;
  }
  {
    std::lock_guard<std::mutex> lock(frames_->mutex);
    frames_->front = back;
  }
  // Two presents after a resize, Flutter shows the new textures.
  for (auto& retired : retired_present_) retired.first++;
  while (!retired_present_.empty() && retired_present_.front().first > 2) {
    glDeleteTextures(1, &retired_present_.front().second);
    retired_present_.erase(retired_present_.begin());
  }
  fl_texture_registrar_mark_texture_frame_available(registrar_, texture_);
  return true;
}

}  // namespace maplibre_native
