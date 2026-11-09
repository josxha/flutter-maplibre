#include <maplibre_native/maplibre_native_api.h>

#include <algorithm>
#include <cstdlib>
#include <cstring>
#include <vector>

#if defined(_WIN32)
#include <windows.h>
#endif

#include "desktop_plugin.h"

namespace maplibre_native {

namespace {

std::mutex g_mutex;
// One plugin per engine, in registration order.
std::vector<DesktopPlugin*> g_plugins;

}  // namespace

// static
DesktopPlugin* DesktopPlugin::ForEngine(int64_t engine_id) {
  for (DesktopPlugin* plugin : g_plugins) {
    if (plugin->ServesEngine(engine_id)) return plugin;
  }
  return nullptr;
}

// static
std::unique_lock<std::mutex> DesktopPlugin::Lock() {
  return std::unique_lock<std::mutex>(g_mutex);
}

DesktopPlugin::DesktopPlugin() {
  std::lock_guard<std::mutex> lock(g_mutex);
  g_plugins.push_back(this);
}

DesktopPlugin::~DesktopPlugin() {
  std::lock_guard<std::mutex> lock(g_mutex);
  Unregister();
}

void DesktopPlugin::Unregister() {
  g_plugins.erase(std::remove(g_plugins.begin(), g_plugins.end(), this),
                  g_plugins.end());
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

void WriteError(const std::string& message, char* error, size_t error_size) {
  if (error == nullptr || error_size == 0) return;
  const size_t length = std::min(message.size(), error_size - 1);
  std::memcpy(error, message.data(), length);
  error[length] = '\0';
}

}  // namespace maplibre_native

// The functions that both platforms share.

using maplibre_native::DesktopPlugin;
using maplibre_native::WriteError;

int32_t maplibre_native_gpu_id(int64_t engine_id, uint8_t* out_id,
                               size_t capacity, char* error,
                               size_t error_size) {
  auto lock = DesktopPlugin::Lock();
  DesktopPlugin* plugin = DesktopPlugin::ForEngine(engine_id);
  if (plugin == nullptr) {
    WriteError("The maplibre_native plugin is not registered.", error,
               error_size);
    return -1;
  }
  if (DesktopPlugin::ZeroCopyDisabled()) {
    WriteError("MAPLIBRE_NATIVE_DISABLE_ZERO_COPY is set.", error, error_size);
    return -1;
  }
  maplibre_native::GpuId id;
  std::string message;
  if (!plugin->GetGpuId(&id, &message)) {
    WriteError(message, error, error_size);
    return -1;
  }
  if (id.size > capacity) {
    WriteError("The GPU ID does not fit.", error, error_size);
    return -1;
  }
  std::memcpy(out_id, id.bytes, id.size);
  return static_cast<int32_t>(id.size);
}

int64_t maplibre_native_create_pixel_texture(int64_t engine_id) {
  auto lock = DesktopPlugin::Lock();
  DesktopPlugin* plugin = DesktopPlugin::ForEngine(engine_id);
  return plugin == nullptr ? -1 : plugin->CreatePixelTexture();
}

bool maplibre_native_update_pixel_texture(int64_t engine_id, int64_t texture_id,
                                          uint32_t width, uint32_t height,
                                          uint32_t stride,
                                          const uint8_t* pixels, size_t length,
                                          char* error, size_t error_size) {
  if (pixels == nullptr || width == 0 || height == 0 ||
      stride < size_t{width} * 4 ||
      length < size_t{stride} * (height - 1) + size_t{width} * 4) {
    WriteError("Pixel data does not match its size.", error, error_size);
    return false;
  }
  auto lock = DesktopPlugin::Lock();
  DesktopPlugin* plugin = DesktopPlugin::ForEngine(engine_id);
  if (plugin == nullptr ||
      !plugin->UpdatePixelTexture(texture_id, width, height, stride, pixels)) {
    WriteError("No pixel buffer texture with this id.", error, error_size);
    return false;
  }
  return true;
}

void maplibre_native_dispose_texture(int64_t engine_id, int64_t texture_id) {
  auto lock = DesktopPlugin::Lock();
  if (DesktopPlugin* plugin = DesktopPlugin::ForEngine(engine_id)) {
    plugin->DisposeTexture(texture_id);
  }
}
