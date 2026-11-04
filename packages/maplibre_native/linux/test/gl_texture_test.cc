// Checks GlTexture of the Linux plugin outside Flutter: the GPU IDs from a
// GDK OpenGL context of a real GTK window, the plugin's Vulkan device on that
// GPU, and a ring of exported Vulkan images that populate imports. As in
// Flutter, populate runs in an EGL context of its own that shares nothing
// with GDK's. Vulkan clears a slot to a color, Present hands it over, and the
// texture that populate returns is read back in that context. Run it with
// run_gl_texture_test.sh.
#include <epoxy/egl.h>
#include <epoxy/gl.h>
#include <gdk/gdkx.h>
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

using maplibre_native::GlDevice;
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

// Flutter's render context as FlOpenGLManager creates it: an EGL context on
// the window's display that requests OpenGL ES 2 and shares nothing.
struct FlutterContext {
  EGLDisplay display = EGL_NO_DISPLAY;
  EGLContext context = EGL_NO_CONTEXT;

  bool Create() {
    display = eglGetPlatformDisplayEXT(
        EGL_PLATFORM_X11_EXT,
        gdk_x11_display_get_xdisplay(gdk_display_get_default()), nullptr);
    if (display == EGL_NO_DISPLAY || !eglInitialize(display, nullptr, nullptr)) {
      return false;
    }
    const EGLint config_attributes[] = {
        EGL_RED_SIZE,   8, EGL_GREEN_SIZE,   8, EGL_BLUE_SIZE, 8,
        EGL_ALPHA_SIZE, 8, EGL_DEPTH_SIZE,   8, EGL_STENCIL_SIZE, 8,
        EGL_NONE};
    EGLConfig config = nullptr;
    EGLint count = 0;
    eglChooseConfig(display, config_attributes, &config, 1, &count);
    const EGLint context_attributes[] = {EGL_CONTEXT_CLIENT_VERSION, 2,
                                         EGL_NONE};
    context = eglCreateContext(display, config, EGL_NO_CONTEXT,
                               context_attributes);
    return context != EGL_NO_CONTEXT;
  }

  bool MakeCurrent() {
    return eglMakeCurrent(display, EGL_NO_SURFACE, EGL_NO_SURFACE, context) ==
           EGL_TRUE;
  }
};

static FlutterContext g_flutter;

// Calls populate of |texture| as Flutter's raster thread does.
static bool Populate(FlTexture* texture, uint32_t* name, uint32_t* width,
                     uint32_t* height) {
  uint32_t target = 0;
  GError* error = nullptr;
  const gboolean ok =
      FL_TEXTURE_GL_GET_CLASS(texture)->populate(FL_TEXTURE_GL(texture),
                                                 &target, name, width, height,
                                                 &error);
  // Flutter's engine reads the error whenever populate fails.
  const bool error_set = error != nullptr;
  g_clear_error(&error);
  if (!ok) {
    CHECK(error_set, "populate failed without an error");
    return false;
  }
  CHECK(target == GL_TEXTURE_2D, "target");
  return true;
}

// What Flutter would sample: populate's texture, read back in Flutter's
// context.
static bool ReadShown(uint32_t* width, uint32_t* height, uint8_t out[4]) {
  if (g_registered == nullptr) return false;
  uint32_t name = 0;
  *width = *height = 0;
  if (!Populate(g_registered, &name, width, height)) return false;
  GLuint framebuffer;
  glGenFramebuffers(1, &framebuffer);
  glBindFramebuffer(GL_FRAMEBUFFER, framebuffer);
  glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D,
                         name, 0);
  glReadPixels(static_cast<GLint>(*width / 2), static_cast<GLint>(*height / 2),
               1, 1, GL_RGBA, GL_UNSIGNED_BYTE, out);
  glBindFramebuffer(GL_FRAMEBUFFER, 0);
  glDeleteFramebuffers(1, &framebuffer);
  return glGetError() == GL_NO_ERROR;
}

static bool IsColor(const uint8_t pixel[4], uint8_t r, uint8_t g, uint8_t b) {
  return pixel[0] == r && pixel[1] == g && pixel[2] == b && pixel[3] == 255;
}

int main(int argc, char** argv) {
  gtk_init(&argc, &argv);
  GtkWidget* window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  gtk_window_set_default_size(GTK_WINDOW(window), 200, 100);
  gtk_widget_show(window);
  while (gtk_events_pending()) gtk_main_iteration();

  std::string error;
  auto gl = GlDevice::Create(reinterpret_cast<FlView*>(window), &error);
  if (!gl) {
    std::printf("FAIL: GlDevice::Create: %s\n", error.c_str());
    return 1;
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
  if (!g_flutter.Create() || !g_flutter.MakeCurrent()) {
    std::printf("FAIL: creating the stand-in for Flutter's EGL context\n");
    return 1;
  }
  std::printf("Flutter's context: %s | %s\n", glGetString(GL_RENDERER),
              glGetString(GL_VERSION));

  auto texture = GlTexture::Create(nullptr, vulkan, gl.get(), 64, 32, 3,
                                   &error);
  if (!texture) {
    std::printf("FAIL: GlTexture::Create: %s\n", error.c_str());
    return 1;
  }
  CHECK(texture->id() == 1, "texture id");
  CHECK(texture->slots().size() == 3, "slot count");
  CHECK(texture->format() == VK_FORMAT_R8G8B8A8_UNORM, "format");
  for (uint32_t slot = 0; slot < 3; ++slot) {
    CHECK(!texture->SlotInUse(slot), "slot %u in use before a frame", slot);
  }

  uint32_t width, height;
  uint8_t pixel[4];
  CHECK(!ReadShown(&width, &height, pixel), "populate before the first frame");

  const float red[4] = {1, 0, 0, 1};
  const float green[4] = {0, 1, 0, 1};
  const float blue[4] = {0, 0, 1, 1};
  CHECK(ClearImage(vulkan, texture->slots()[1].image, red), "clear red");
  CHECK(texture->Present(1, &error), "present: %s", error.c_str());
  CHECK(texture->SlotInUse(1), "the front slot is in use");
  CHECK(ReadShown(&width, &height, pixel), "read after present");
  std::printf("shown %ux%u: %d %d %d %d\n", width, height, pixel[0], pixel[1],
              pixel[2], pixel[3]);
  CHECK(width == 64 && height == 32, "size");
  CHECK(IsColor(pixel, 255, 0, 0), "red frame");

  // The shown slot stays in use after the next present, until Flutter has
  // moved on and its draws are done.
  CHECK(ClearImage(vulkan, texture->slots()[2].image, green), "clear green");
  CHECK(texture->Present(2, &error), "present green: %s", error.c_str());
  CHECK(texture->SlotInUse(1), "the shown slot is in use");
  CHECK(!texture->SlotInUse(0), "the free slot is not in use");
  CHECK(ReadShown(&width, &height, pixel), "read green");
  CHECK(IsColor(pixel, 0, 255, 0), "green frame: %d %d %d", pixel[0],
        pixel[1], pixel[2]);
  CHECK(ClearImage(vulkan, texture->slots()[0].image, blue), "clear blue");
  CHECK(texture->Present(0, &error), "present blue: %s", error.c_str());
  CHECK(ReadShown(&width, &height, pixel), "read blue");
  CHECK(IsColor(pixel, 0, 0, 255), "blue frame: %d %d %d", pixel[0], pixel[1],
        pixel[2]);
  // Populate waited for the fence of the slot before last.
  CHECK(!texture->SlotInUse(1), "a slot two frames back is free");
  CHECK(texture->SlotInUse(0), "the shown slot is in use");

  // A slot that Flutter populated before is free once it is neither the
  // front nor the shown slot.
  CHECK(ClearImage(vulkan, texture->slots()[1].image, red), "clear red again");
  CHECK(texture->Present(1, &error), "present red again: %s", error.c_str());
  CHECK(texture->Present(2, &error), "present green again: %s", error.c_str());
  CHECK(!texture->SlotInUse(1), "a slot no longer front or shown is free");
  CHECK(ReadShown(&width, &height, pixel), "read green again");
  CHECK(IsColor(pixel, 0, 255, 0), "green again: %d %d %d", pixel[0], pixel[1],
        pixel[2]);

  // Resizing replaces the ring; Flutter's next populate deletes the old one.
  CHECK(texture->Resize(128, 48, &error), "resize: %s", error.c_str());
  texture->ReleaseRetiredSlots();
  CHECK(!texture->SlotInUse(2), "a new slot is free");
  CHECK(ClearImage(vulkan, texture->slots()[2].image, blue), "clear blue");
  CHECK(texture->Present(2, &error), "present after resize: %s",
        error.c_str());
  CHECK(ReadShown(&width, &height, pixel), "read after resize");
  std::printf("shown %ux%u: %d %d %d %d\n", width, height, pixel[0], pixel[1],
              pixel[2], pixel[3]);
  CHECK(width == 128 && height == 48, "resized size");
  CHECK(IsColor(pixel, 0, 0, 255), "blue frame after resize");
  CHECK(g_frames_available == 6, "frames marked available: %d",
        g_frames_available);
  CHECK(!texture->Present(3, &error), "present of a missing slot");
  CHECK(!texture->SlotInUse(3), "a missing slot is not in use");

  // A disposed texture's objects go with the populate of another texture.
  texture.reset();
  CHECK(g_registered == nullptr, "unregistered");
  auto other = GlTexture::Create(nullptr, vulkan, gl.get(), 16, 16, 3, &error);
  CHECK(other != nullptr, "second texture: %s", error.c_str());
  if (other) {
    CHECK(ClearImage(vulkan, other->slots()[0].image, red), "clear other");
    CHECK(other->Present(0, &error), "present other: %s", error.c_str());
    CHECK(ReadShown(&width, &height, pixel), "read other");
    CHECK(IsColor(pixel, 255, 0, 0), "other texture red");
    other.reset();
  }
  CHECK(glGetError() == GL_NO_ERROR, "OpenGL errors in Flutter's context");

  std::printf(g_failures == 0 ? "PASS\n" : "%d FAILURES\n", g_failures);
  return g_failures == 0 ? 0 : 1;
}
