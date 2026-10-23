// Checks GlTexture of the Linux plugin outside Flutter: a GDK OpenGL context
// from a real GTK window, the plugin's Vulkan device on the OpenGL device, a
// ring of exported Vulkan images imported into OpenGL, and the present copy.
// Vulkan clears a slot to a color, Present copies it, and the texture that
// populate hands to Flutter is read back. Run it with run_gl_texture_test.sh.
#include <epoxy/gl.h>
#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>

#include <cstdio>
#include <cstring>
#include <string>

#include "gl_texture.h"

// Stand-ins for the Flutter functions the plugin calls.
G_DEFINE_INTERFACE(FlTexture, fl_texture, G_TYPE_OBJECT)
static void fl_texture_default_init(FlTextureInterface*) {}

static void fl_texture_gl_texture_iface_init(FlTextureInterface*) {}
G_DEFINE_TYPE_WITH_CODE(FlTextureGL, fl_texture_gl, G_TYPE_OBJECT,
                        G_IMPLEMENT_INTERFACE(fl_texture_get_type(),
                                              fl_texture_gl_texture_iface_init))
static void fl_texture_gl_class_init(FlTextureGLClass*) {}
static void fl_texture_gl_init(FlTextureGL*) {}

static FlTexture* g_registered = nullptr;
static int g_frames_available = 0;

gboolean fl_texture_registrar_register_texture(FlTextureRegistrar*,
                                               FlTexture* texture) {
  g_registered = texture;
  return TRUE;
}
gboolean fl_texture_registrar_mark_texture_frame_available(FlTextureRegistrar*,
                                                           FlTexture*) {
  ++g_frames_available;
  return TRUE;
}
gboolean fl_texture_registrar_unregister_texture(FlTextureRegistrar*,
                                                 FlTexture*) {
  g_registered = nullptr;
  return TRUE;
}
int64_t fl_texture_get_id(FlTexture*) { return 1; }

using maplibre_native::GlContext;
using maplibre_native::GlTexture;
using maplibre_native::VulkanDevice;

static int g_failures = 0;
#define CHECK(condition, ...)                \
  do {                                       \
    if (!(condition)) {                      \
      std::printf("FAIL: " __VA_ARGS__);     \
      std::printf("\n");                     \
      ++g_failures;                          \
    }                                        \
  } while (0)

// Clears |image| to |rgba| and leaves it in the general layout, as a session
// would leave a frame.
static bool ClearImage(VulkanDevice* vulkan, VkImage image,
                       const float rgba[4]) {
  VkDevice device = vulkan->device();
#define LOAD(name) \
  auto name = reinterpret_cast<PFN_##name>(vulkan->get_device_proc_addr()(device, #name))
  LOAD(vkCreateCommandPool);
  LOAD(vkDestroyCommandPool);
  LOAD(vkAllocateCommandBuffers);
  LOAD(vkBeginCommandBuffer);
  LOAD(vkEndCommandBuffer);
  LOAD(vkCmdPipelineBarrier);
  LOAD(vkCmdClearColorImage);
  LOAD(vkQueueSubmit);
  LOAD(vkQueueWaitIdle);
#undef LOAD
  VkCommandPoolCreateInfo pool_info{VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO};
  pool_info.queueFamilyIndex = vulkan->queue_family_index();
  VkCommandPool pool;
  if (vkCreateCommandPool(device, &pool_info, nullptr, &pool) != VK_SUCCESS) {
    return false;
  }
  VkCommandBufferAllocateInfo allocate{
      VK_STRUCTURE_TYPE_COMMAND_BUFFER_ALLOCATE_INFO};
  allocate.commandPool = pool;
  allocate.level = VK_COMMAND_BUFFER_LEVEL_PRIMARY;
  allocate.commandBufferCount = 1;
  VkCommandBuffer commands;
  vkAllocateCommandBuffers(device, &allocate, &commands);
  VkCommandBufferBeginInfo begin{VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO};
  vkBeginCommandBuffer(commands, &begin);
  VkImageMemoryBarrier barrier{VK_STRUCTURE_TYPE_IMAGE_MEMORY_BARRIER};
  barrier.srcQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
  barrier.dstQueueFamilyIndex = VK_QUEUE_FAMILY_IGNORED;
  barrier.image = image;
  barrier.subresourceRange = {VK_IMAGE_ASPECT_COLOR_BIT, 0, 1, 0, 1};
  barrier.oldLayout = VK_IMAGE_LAYOUT_UNDEFINED;
  barrier.newLayout = VK_IMAGE_LAYOUT_GENERAL;
  barrier.dstAccessMask = VK_ACCESS_TRANSFER_WRITE_BIT;
  vkCmdPipelineBarrier(commands, VK_PIPELINE_STAGE_TOP_OF_PIPE_BIT,
                       VK_PIPELINE_STAGE_TRANSFER_BIT, 0, 0, nullptr, 0,
                       nullptr, 1, &barrier);
  VkClearColorValue color{};
  std::memcpy(color.float32, rgba, sizeof(color.float32));
  vkCmdClearColorImage(commands, image, VK_IMAGE_LAYOUT_GENERAL, &color, 1,
                       &barrier.subresourceRange);
  barrier.oldLayout = VK_IMAGE_LAYOUT_GENERAL;
  barrier.srcAccessMask = VK_ACCESS_TRANSFER_WRITE_BIT;
  barrier.dstAccessMask = VK_ACCESS_MEMORY_READ_BIT;
  vkCmdPipelineBarrier(commands, VK_PIPELINE_STAGE_TRANSFER_BIT,
                       VK_PIPELINE_STAGE_ALL_COMMANDS_BIT, 0, 0, nullptr, 0,
                       nullptr, 1, &barrier);
  vkEndCommandBuffer(commands);
  VkSubmitInfo submit{VK_STRUCTURE_TYPE_SUBMIT_INFO};
  submit.commandBufferCount = 1;
  submit.pCommandBuffers = &commands;
  const bool ok =
      vkQueueSubmit(vulkan->queue(), 1, &submit, VK_NULL_HANDLE) ==
          VK_SUCCESS &&
      vkQueueWaitIdle(vulkan->queue()) == VK_SUCCESS;
  vkDestroyCommandPool(device, pool, nullptr);
  return ok;
}

// What Flutter would sample: populate's texture, read back in |gl|.
static bool ReadShown(GlContext* gl, uint32_t* width, uint32_t* height,
                      uint8_t out[4]) {
  if (g_registered == nullptr) return false;
  uint32_t target = 0, name = 0;
  *width = *height = 0;
  if (!FL_TEXTURE_GL_GET_CLASS(g_registered)
           ->populate(FL_TEXTURE_GL(g_registered), &target, &name, width,
                      height, nullptr)) {
    return false;
  }
  GlContext::Scope scope(gl);
  GLuint framebuffer;
  glGenFramebuffers(1, &framebuffer);
  glBindFramebuffer(GL_FRAMEBUFFER, framebuffer);
  glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, target, name,
                         0);
  glReadPixels(static_cast<GLint>(*width / 2), static_cast<GLint>(*height / 2),
               1, 1, GL_RGBA, GL_UNSIGNED_BYTE, out);
  glBindFramebuffer(GL_FRAMEBUFFER, 0);
  glDeleteFramebuffers(1, &framebuffer);
  return glGetError() == GL_NO_ERROR;
}

int main(int argc, char** argv) {
  gtk_init(&argc, &argv);
  GtkWidget* window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  gtk_window_set_default_size(GTK_WINDOW(window), 200, 100);
  gtk_widget_show(window);
  while (gtk_events_pending()) gtk_main_iteration();

  std::string error;
  auto gl = GlContext::Create(reinterpret_cast<FlView*>(window), &error);
  if (!gl) {
    std::printf("FAIL: GlContext::Create: %s\n", error.c_str());
    return 1;
  }
  {
    GlContext::Scope scope(gl.get());
    std::printf("GL: %s | %s\n", glGetString(GL_RENDERER),
                glGetString(GL_VERSION));
  }
  VulkanDevice* vulkan = VulkanDevice::Get(&gl->device_uuid(), &error);
  if (vulkan == nullptr) {
    std::printf("FAIL: VulkanDevice::Get: %s\n", error.c_str());
    return 1;
  }
  std::printf("Vulkan: shares_memory=%d matches_gpu=%d driver_match=%d\n",
              vulkan->shares_memory(), vulkan->matches_gpu(),
              std::memcmp(vulkan->driver_uuid(), gl->driver_uuid(),
                          VK_UUID_SIZE) == 0);

  auto texture = GlTexture::Create(nullptr, vulkan, gl.get(), 64, 32, 3,
                                   &error);
  if (!texture) {
    std::printf("FAIL: GlTexture::Create: %s\n", error.c_str());
    return 1;
  }
  CHECK(texture->id() == 1, "texture id");
  CHECK(texture->slots().size() == 3, "slot count");
  CHECK(texture->format() == VK_FORMAT_R8G8B8A8_UNORM, "format");

  uint32_t width, height;
  uint8_t pixel[4];
  CHECK(!ReadShown(gl.get(), &width, &height, pixel),
        "populate before the first frame");

  const float red[4] = {1, 0, 0, 1};
  CHECK(ClearImage(vulkan, texture->slots()[1].image, red), "clear red");
  CHECK(texture->Present(1, &error), "present: %s", error.c_str());
  CHECK(ReadShown(gl.get(), &width, &height, pixel), "read after present");
  std::printf("shown %ux%u: %d %d %d %d\n", width, height, pixel[0], pixel[1],
              pixel[2], pixel[3]);
  CHECK(width == 64 && height == 32, "size");
  CHECK(pixel[0] == 255 && pixel[1] == 0 && pixel[2] == 0 && pixel[3] == 255,
        "red frame");

  // Resizing replaces the ring; the old one stays until it is released.
  CHECK(texture->Resize(128, 48, &error), "resize: %s", error.c_str());
  texture->ReleaseRetiredSlots();
  const float blue[4] = {0, 0, 1, 1};
  CHECK(ClearImage(vulkan, texture->slots()[2].image, blue), "clear blue");
  for (int i = 0; i < 4; ++i) {
    CHECK(texture->Present(2, &error), "present %d: %s", i, error.c_str());
  }
  CHECK(ReadShown(gl.get(), &width, &height, pixel), "read after resize");
  std::printf("shown %ux%u: %d %d %d %d\n", width, height, pixel[0], pixel[1],
              pixel[2], pixel[3]);
  CHECK(width == 128 && height == 48, "resized size");
  CHECK(pixel[0] == 0 && pixel[1] == 0 && pixel[2] == 255 && pixel[3] == 255,
        "blue frame");
  CHECK(g_frames_available == 5, "frames marked available: %d",
        g_frames_available);
  CHECK(!texture->Present(3, &error), "present of a missing slot");

  texture.reset();
  CHECK(g_registered == nullptr, "unregistered");
  std::printf(g_failures == 0 ? "PASS\n" : "%d FAILURES\n", g_failures);
  return g_failures == 0 ? 0 : 1;
}
