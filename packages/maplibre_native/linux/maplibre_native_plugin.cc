#include "include/maplibre_native/maplibre_native_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>

#include <map>
#include <memory>
#include <string>

#include "desktop_plugin.h"
#include "gl_texture.h"
#include "pixel_texture.h"
#include "vulkan_device.h"

namespace maplibre_native {

namespace {

// Whether the caller runs the GTK main loop, the only thread that may use GDK
// OpenGL contexts. Dart calls the plugin on its UI thread, which is this one
// when Flutter merges the UI and platform threads.
bool OnMainThread() {
  return g_main_context_is_owner(g_main_context_default());
}

}  // namespace

// The Linux DesktopPlugin: owns the textures, and the OpenGL context that
// shares them with Flutter's.
class LinuxPlugin : public DesktopPlugin {
 public:
  explicit LinuxPlugin(FlPluginRegistrar* registrar)
      : textures_(FL_TEXTURE_REGISTRAR(g_object_ref(
            fl_plugin_registrar_get_texture_registrar(registrar)))),
        view_(fl_plugin_registrar_get_view(registrar)) {
    if (view_ != nullptr) {
      g_object_add_weak_pointer(G_OBJECT(view_),
                                reinterpret_cast<gpointer*>(&view_));
    }
  }

  ~LinuxPlugin() override {
    auto lock = Lock();
    Unregister();
    pixel_textures_.clear();
    gpu_textures_.clear();
    gl_.reset();
    if (view_ != nullptr) {
      g_object_remove_weak_pointer(G_OBJECT(view_),
                                   reinterpret_cast<gpointer*>(&view_));
    }
    g_object_unref(textures_);
  }

  VulkanDevice* GetVulkan(std::string* error) override {
    // OpenGL names the GPU that Flutter renders on, which the device is
    // created on.
    EnsureGl();
    return VulkanDevice::Get(gl_ ? &gl_->device_uuid() : nullptr, error);
  }

  int64_t CreatePixelTexture() override {
    auto texture = std::make_unique<PixelTexture>(textures_);
    const int64_t id = texture->id();
    if (id >= 0) pixel_textures_.emplace(id, std::move(texture));
    return id;
  }

  bool UpdatePixelTexture(int64_t id, size_t width, size_t height,
                          size_t stride, const uint8_t* pixels) override {
    const auto texture = pixel_textures_.find(id);
    if (texture == pixel_textures_.end()) return false;
    texture->second->Update(width, height, pixels, stride);
    return true;
  }

  GpuTexture* CreateGpuTexture(uint32_t width, uint32_t height,
                               uint32_t slot_count,
                               std::string* error) override {
    if (ZeroCopyDisabled()) {
      *error = "MAPLIBRE_NATIVE_DISABLE_ZERO_COPY is set.";
      return nullptr;
    }
    if (!OnMainThread()) {
      *error = "Dart does not run on the GTK main thread, which OpenGL "
               "copies need.";
      return nullptr;
    }
    VulkanDevice* vulkan = GetVulkan(error);
    if (vulkan == nullptr) return nullptr;
    if (!gl_) {
      *error = gl_error_;
      return nullptr;
    }
    auto texture = GlTexture::Create(textures_, vulkan, gl_.get(), width,
                                     height, slot_count, error);
    if (!texture) return nullptr;
    GlTexture* raw = texture.get();
    gpu_textures_.emplace(raw->id(), std::move(texture));
    return raw;
  }

  GpuTexture* FindGpuTexture(int64_t id) override {
    const auto texture = gpu_textures_.find(id);
    return texture == gpu_textures_.end() ? nullptr : texture->second.get();
  }

  void DisposeTexture(int64_t id) override {
    if (gpu_textures_.erase(id) == 0) pixel_textures_.erase(id);
  }

 private:
  // Creates the OpenGL context once, on the main thread.
  void EnsureGl() {
    if (gl_tried_ || !OnMainThread()) return;
    gl_tried_ = true;
    gl_ = GlContext::Create(view_, &gl_error_);
  }

  FlTextureRegistrar* textures_;
  // Cleared when Flutter destroys the view.
  FlView* view_;
  std::unique_ptr<GlContext> gl_;
  bool gl_tried_ = false;
  std::string gl_error_ = "OpenGL is only used on the GTK main thread.";
  std::map<int64_t, std::unique_ptr<PixelTexture>> pixel_textures_;
  // Declared after gl_, so its textures go first.
  std::map<int64_t, std::unique_ptr<GlTexture>> gpu_textures_;
};

}  // namespace maplibre_native

void maplibre_native_plugin_register_with_registrar(
    FlPluginRegistrar* registrar) {
  // The plugin lives as long as the process: render sessions on core workers
  // may outlive the engine, and Linux plugins get no shutdown call.
  new maplibre_native::LinuxPlugin(registrar);
}
