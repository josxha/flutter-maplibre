#include <maplibre_native/maplibre_native_api.h>

#include <algorithm>
#include <cstdlib>
#include <cstring>

#include "desktop_plugin.h"

namespace maplibre_native {

namespace {

std::mutex g_mutex;
DesktopPlugin* g_plugin = nullptr;

}  // namespace

// static
DesktopPlugin* DesktopPlugin::Instance() { return g_plugin; }

// static
std::unique_lock<std::mutex> DesktopPlugin::Lock() {
  return std::unique_lock<std::mutex>(g_mutex);
}

DesktopPlugin::DesktopPlugin() {
  std::lock_guard<std::mutex> lock(g_mutex);
  g_plugin = this;
}

DesktopPlugin::~DesktopPlugin() {
  std::lock_guard<std::mutex> lock(g_mutex);
  Unregister();
}

void DesktopPlugin::Unregister() {
  if (g_plugin == this) g_plugin = nullptr;
}

// static
bool DesktopPlugin::ZeroCopyDisabled() {
  constexpr const char* kName = "MAPLIBRE_NATIVE_DISABLE_ZERO_COPY";
#if defined(_WIN32)
  char value[2] = {};
  return GetEnvironmentVariableA(kName, value, sizeof(value)) > 0;
#else
  const char* value = std::getenv(kName);
  return value != nullptr && value[0] != '\0';
#endif
}

}  // namespace maplibre_native

// C API

using maplibre_native::DesktopPlugin;
using maplibre_native::GpuTexture;
using maplibre_native::VulkanSlot;

namespace {

constexpr const char* kNotRegistered =
    "The maplibre_native plugin is not registered.";

void WriteError(const std::string& message, char* error, size_t error_size) {
  if (error == nullptr || error_size == 0) return;
  const size_t length = std::min(message.size(), error_size - 1);
  std::memcpy(error, message.data(), length);
  error[length] = '\0';
}

uint64_t Bits(const void* handle) {
  return static_cast<uint64_t>(reinterpret_cast<uintptr_t>(handle));
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

// The registered plugin, or null with |error| written; the caller holds the
// lock.
DesktopPlugin* Plugin(char* error, size_t error_size) {
  DesktopPlugin* plugin = DesktopPlugin::Instance();
  if (plugin == nullptr) WriteError(kNotRegistered, error, error_size);
  return plugin;
}

// Finds a GPU texture of the registered plugin; the caller holds the lock.
GpuTexture* FindGpuTexture(int64_t texture_id, char* error,
                           size_t error_size) {
  DesktopPlugin* plugin = DesktopPlugin::Instance();
  GpuTexture* texture =
      plugin == nullptr ? nullptr : plugin->FindGpuTexture(texture_id);
  if (texture == nullptr) {
    WriteError("No GPU texture with this id.", error, error_size);
  }
  return texture;
}

}  // namespace

bool maplibre_native_vulkan_context(MaplibreNativeVulkanContext* out_context,
                                    char* error, size_t error_size) {
  auto lock = DesktopPlugin::Lock();
  DesktopPlugin* plugin = Plugin(error, error_size);
  if (plugin == nullptr) return false;
  std::string message;
  maplibre_native::VulkanDevice* vulkan = plugin->GetVulkan(&message);
  if (vulkan == nullptr) {
    WriteError(message, error, error_size);
    return false;
  }
  *out_context = MaplibreNativeVulkanContext{
      Bits(vulkan->instance()),
      Bits(vulkan->physical_device()),
      Bits(vulkan->device()),
      Bits(vulkan->queue()),
      vulkan->queue_family_index(),
      Bits(reinterpret_cast<void*>(vulkan->get_instance_proc_addr())),
      Bits(reinterpret_cast<void*>(vulkan->get_device_proc_addr())),
  };
  return true;
}

int64_t maplibre_native_create_pixel_texture(void) {
  auto lock = DesktopPlugin::Lock();
  DesktopPlugin* plugin = DesktopPlugin::Instance();
  return plugin == nullptr ? -1 : plugin->CreatePixelTexture();
}

bool maplibre_native_update_pixel_texture(int64_t texture_id, uint32_t width,
                                          uint32_t height, uint32_t stride,
                                          const uint8_t* pixels, size_t length,
                                          char* error, size_t error_size) {
  if (pixels == nullptr || width == 0 || height == 0 ||
      stride < size_t{width} * 4 ||
      length < size_t{stride} * (height - 1) + size_t{width} * 4) {
    WriteError("Pixel data does not match its size.", error, error_size);
    return false;
  }
  auto lock = DesktopPlugin::Lock();
  DesktopPlugin* plugin = Plugin(error, error_size);
  if (plugin == nullptr) return false;
  if (!plugin->UpdatePixelTexture(texture_id, width, height, stride, pixels)) {
    WriteError("No pixel buffer texture with this id.", error, error_size);
    return false;
  }
  return true;
}

int64_t maplibre_native_create_gpu_texture(uint32_t width, uint32_t height,
                                           uint32_t slot_count,
                                           uint32_t* out_format,
                                           MaplibreNativeGpuSlot* out_slots,
                                           uint32_t slot_capacity, char* error,
                                           size_t error_size) {
  auto lock = DesktopPlugin::Lock();
  DesktopPlugin* plugin = Plugin(error, error_size);
  if (plugin == nullptr) return -1;
  std::string message;
  GpuTexture* texture =
      plugin->CreateGpuTexture(width, height, slot_count, &message);
  if (texture == nullptr) {
    WriteError(message, error, error_size);
    return -1;
  }
  *out_format = static_cast<uint32_t>(texture->format());
  WriteSlots(texture->slots(), out_slots, slot_capacity);
  return texture->id();
}

bool maplibre_native_resize_gpu_texture(int64_t texture_id, uint32_t width,
                                        uint32_t height,
                                        MaplibreNativeGpuSlot* out_slots,
                                        uint32_t slot_capacity, char* error,
                                        size_t error_size) {
  auto lock = DesktopPlugin::Lock();
  GpuTexture* texture = FindGpuTexture(texture_id, error, error_size);
  if (texture == nullptr) return false;
  std::string message;
  if (!texture->Resize(width, height, &message)) {
    WriteError(message, error, error_size);
    return false;
  }
  WriteSlots(texture->slots(), out_slots, slot_capacity);
  return true;
}

void maplibre_native_release_retired_slots(int64_t texture_id) {
  auto lock = DesktopPlugin::Lock();
  if (GpuTexture* texture = FindGpuTexture(texture_id, nullptr, 0)) {
    texture->ReleaseRetiredSlots();
  }
}

bool maplibre_native_present_gpu_texture(int64_t texture_id, uint32_t slot,
                                         char* error, size_t error_size) {
  auto lock = DesktopPlugin::Lock();
  GpuTexture* texture = FindGpuTexture(texture_id, error, error_size);
  if (texture == nullptr) return false;
  std::string message;
  if (!texture->Present(slot, &message)) {
    WriteError(message, error, error_size);
    return false;
  }
  return true;
}

void maplibre_native_dispose_texture(int64_t texture_id) {
  auto lock = DesktopPlugin::Lock();
  if (DesktopPlugin* plugin = DesktopPlugin::Instance()) {
    plugin->DisposeTexture(texture_id);
  }
}
