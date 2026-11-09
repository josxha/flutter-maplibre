#ifndef FLUTTER_PLUGIN_MAPLIBRE_NATIVE_DESKTOP_PLUGIN_H_
#define FLUTTER_PLUGIN_MAPLIBRE_NATIVE_DESKTOP_PLUGIN_H_

#include <cstddef>
#include <cstdint>
#include <mutex>
#include <string>

namespace maplibre_native {

// Identifies the GPU that Flutter composites on: the adapter LUID on Windows,
// the device UUID that OpenGL reports on Linux.
struct GpuId {
  uint8_t bytes[16] = {};
  size_t size = 0;
};

// The Windows or Linux plugin behind the C API in
// include/maplibre_native/maplibre_native_api.h. This directory implements
// the functions that both share; each platform implements its own. Every
// Flutter engine registers an instance of its own, with its own texture
// registrar and textures, and Dart reaches the one of its engine through that
// API, never through a channel.
class DesktopPlugin {
 public:
  // The plugin registered by the engine |engine_id|, which is
  // `PlatformDispatcher.instance.engineId` of the calling isolate, or null
  // before registration and after shutdown. Callers hold the lock from Lock()
  // while they use it.
  static DesktopPlugin* ForEngine(int64_t engine_id);
  static std::unique_lock<std::mutex> Lock();

  // Whether MAPLIBRE_NATIVE_DISABLE_ZERO_COPY is set, which lets the CPU
  // readback path be tested on hardware that shares textures.
  static bool ZeroCopyDisabled();

  DesktopPlugin(const DesktopPlugin&) = delete;
  DesktopPlugin& operator=(const DesktopPlugin&) = delete;

  // Whether this plugin was registered by the engine |engine_id|, which is
  // the engine's pointer on Windows and Linux.
  virtual bool ServesEngine(int64_t engine_id) const = 0;

  // The GPU that Flutter renders on, or false with |error| set when frames
  // can't reach Flutter without a CPU copy.
  virtual bool GetGpuId(GpuId* id, std::string* error) = 0;

  virtual int64_t CreatePixelTexture() = 0;

  // Copies |height| rows of |width| RGBA8 pixels, |stride| bytes apart, which
  // the C API checked against their length. Returns false when no pixel
  // texture has |id|.
  virtual bool UpdatePixelTexture(int64_t id, size_t width, size_t height,
                                  size_t stride, const uint8_t* pixels) = 0;

  // Unregisters a texture of any kind.
  virtual void DisposeTexture(int64_t id) = 0;

 protected:
  DesktopPlugin();
  virtual ~DesktopPlugin();

  // Adds this plugin to the registered ones. Subclass constructors call it
  // last, so the C API never reaches a plugin in construction.
  void Register();

  // Removes this plugin from the registered ones; the caller holds the lock.
  // Subclass destructors call it first, so the C API never reaches a plugin
  // in destruction.
  void Unregister();
};

// Writes |message| to the C API's |error| buffer, when there is one.
void WriteError(const std::string& message, char* error, size_t error_size);

}  // namespace maplibre_native

#endif  // FLUTTER_PLUGIN_MAPLIBRE_NATIVE_DESKTOP_PLUGIN_H_
