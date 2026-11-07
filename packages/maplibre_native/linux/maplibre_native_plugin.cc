#include "include/maplibre_native/maplibre_native_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>

#include <maplibre_native/maplibre_native_api.h>

#include <algorithm>
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

// The Linux DesktopPlugin: owns the textures, the IDs of the GPU that OpenGL
// renders Flutter's window on, and the functions of the C library's Vulkan
// device.
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

  bool GetGpuId(GpuId* id, std::string* error) override {
    // OpenGL names the GPU that Flutter renders on, which the C library
    // creates its Vulkan device on.
    EnsureGl();
    if (!gl_) {
      *error = gl_error_;
      return false;
    }
    *id = gl_->device_uuid();
    return true;
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

  // Returns null with |error| set when Vulkan cannot share images with
  // Flutter, and Dart falls back to a pixel buffer texture.
  GlTexture* CreateGpuTexture(const MaplibreNativeVulkanContext& context,
                              uint32_t width, uint32_t height,
                              uint32_t slot_count, std::string* error) {
    // The GPU IDs are read on the main thread once; the textures need no
    // OpenGL context of their own, as populate imports their memory into
    // Flutter's.
    GpuId id;
    if (!GetGpuId(&id, error)) return nullptr;
    VulkanDevice* vulkan = Adopt(context, error);
    if (vulkan == nullptr) return nullptr;
    auto texture = GlTexture::Create(textures_, vulkan, gl_.get(), width,
                                     height, slot_count, error);
    if (!texture) return nullptr;
    GlTexture* raw = texture.get();
    gpu_textures_.emplace(raw->id(), std::move(texture));
    return raw;
  }

  GlTexture* FindGpuTexture(int64_t id) {
    const auto texture = gpu_textures_.find(id);
    return texture == gpu_textures_.end() ? nullptr : texture->second.get();
  }

  void DisposeTexture(int64_t id) override {
    if (gpu_textures_.erase(id) == 0) pixel_textures_.erase(id);
  }

 private:
  // Reads the GPU IDs once, on the main thread.
  void EnsureGl() {
    if (gl_tried_ || !OnMainThread()) return;
    gl_tried_ = true;
    gl_ = GlDevice::Create(view_, &gl_error_);
  }

  // The functions of the device |context|, loaded once per device. Devices
  // live as long as the process, as their textures may.
  VulkanDevice* Adopt(const MaplibreNativeVulkanContext& context,
                      std::string* error) {
    auto& vulkan = vulkan_devices_[context.device];
    if (!vulkan) vulkan = VulkanDevice::Adopt(context, error);
    return vulkan.get();
  }

  FlTextureRegistrar* textures_;
  // Cleared when Flutter destroys the view.
  FlView* view_;
  std::unique_ptr<GlDevice> gl_;
  bool gl_tried_ = false;
  std::string gl_error_ =
      "The GPU is only queried on the GTK main thread, and Dart did not call "
      "the plugin there first.";
  std::map<int64_t, std::unique_ptr<PixelTexture>> pixel_textures_;
  std::map<int64_t, std::unique_ptr<GlTexture>> gpu_textures_;
  std::map<uint64_t, std::unique_ptr<VulkanDevice>> vulkan_devices_;
};

constexpr const char* kNoTexture = "No GPU texture with this id.";

// The registered plugin, or null with |error| written; the caller holds the
// lock.
LinuxPlugin* Plugin(char* error, size_t error_size) {
  auto* plugin = static_cast<LinuxPlugin*>(DesktopPlugin::Instance());
  if (plugin == nullptr) {
    WriteError("The maplibre_native plugin is not registered.", error,
               error_size);
  }
  return plugin;
}

// Finds a GPU texture of the registered plugin; the caller holds the lock.
GlTexture* FindGpuTexture(int64_t texture_id, char* error, size_t error_size) {
  LinuxPlugin* plugin = Plugin(error, error_size);
  GlTexture* texture =
      plugin == nullptr ? nullptr : plugin->FindGpuTexture(texture_id);
  if (plugin != nullptr && texture == nullptr) {
    WriteError(kNoTexture, error, error_size);
  }
  return texture;
}

// Vulkan's non-dispatchable handles are pointers on 64-bit targets and 64-bit
// integers elsewhere.
template <typename Handle>
uint64_t HandleBits(Handle handle) {
  return (uint64_t)(handle);
}

void WriteSlots(const std::vector<VulkanSlot>& slots,
                MaplibreNativeGpuSlot* out_slots, uint32_t slot_capacity) {
  const size_t count = std::min<size_t>(slots.size(), slot_capacity);
  for (size_t i = 0; i < count; ++i) {
    out_slots[i].image = HandleBits(slots[i].image);
    out_slots[i].view = HandleBits(slots[i].view);
  }
}

}  // namespace maplibre_native

// The functions of the C API that only Linux has.

using maplibre_native::DesktopPlugin;
using maplibre_native::GlTexture;
using maplibre_native::WriteError;

int64_t maplibre_native_create_gpu_texture(
    const MaplibreNativeVulkanContext* context, uint32_t width,
    uint32_t height, uint32_t slot_count, uint32_t* out_format,
    MaplibreNativeGpuSlot* out_slots, uint32_t slot_capacity, char* error,
    size_t error_size) {
  auto lock = DesktopPlugin::Lock();
  auto* plugin = maplibre_native::Plugin(error, error_size);
  if (plugin == nullptr) return -1;
  std::string message;
  GlTexture* texture = plugin->CreateGpuTexture(*context, width, height,
                                                slot_count, &message);
  if (texture == nullptr) {
    WriteError(message, error, error_size);
    return -1;
  }
  *out_format = static_cast<uint32_t>(texture->format());
  maplibre_native::WriteSlots(texture->slots(), out_slots, slot_capacity);
  return texture->id();
}

bool maplibre_native_resize_gpu_texture(int64_t texture_id, uint32_t width,
                                        uint32_t height,
                                        MaplibreNativeGpuSlot* out_slots,
                                        uint32_t slot_capacity, char* error,
                                        size_t error_size) {
  auto lock = DesktopPlugin::Lock();
  GlTexture* texture =
      maplibre_native::FindGpuTexture(texture_id, error, error_size);
  if (texture == nullptr) return false;
  std::string message;
  if (!texture->Resize(width, height, &message)) {
    WriteError(message, error, error_size);
    return false;
  }
  maplibre_native::WriteSlots(texture->slots(), out_slots, slot_capacity);
  return true;
}

void maplibre_native_release_retired_slots(int64_t texture_id) {
  auto lock = DesktopPlugin::Lock();
  if (GlTexture* texture = maplibre_native::FindGpuTexture(texture_id, nullptr, 0)) {
    texture->ReleaseRetiredSlots();
  }
}

bool maplibre_native_present_gpu_texture(int64_t texture_id, uint32_t slot,
                                         char* error, size_t error_size) {
  auto lock = DesktopPlugin::Lock();
  GlTexture* texture =
      maplibre_native::FindGpuTexture(texture_id, error, error_size);
  if (texture == nullptr) return false;
  std::string message;
  if (!texture->Present(slot, &message)) {
    WriteError(message, error, error_size);
    return false;
  }
  return true;
}

bool maplibre_native_gpu_texture_slot_in_use(int64_t texture_id,
                                             uint32_t slot) {
  auto lock = DesktopPlugin::Lock();
  GlTexture* texture = maplibre_native::FindGpuTexture(texture_id, nullptr, 0);
  return texture != nullptr && texture->SlotInUse(slot);
}

void maplibre_native_plugin_register_with_registrar(
    FlPluginRegistrar* registrar) {
  // The plugin lives as long as the process: render sessions on core workers
  // may outlive the engine, and Linux plugins get no shutdown call.
  new maplibre_native::LinuxPlugin(registrar);
}
