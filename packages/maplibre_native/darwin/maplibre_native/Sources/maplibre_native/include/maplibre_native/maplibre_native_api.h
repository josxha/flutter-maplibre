// C API of the maplibre_native iOS and macOS plugin, which Dart calls through
// the ffigen bindings in lib/src/darwin/bindings.g.dart. Regenerate them with
// `cd tool/codegen && dart run ffigen.dart` after changing this file.
//
// Dart finds the functions through +[MaplibreNativePlugin symbols], which it
// calls through the Objective-C runtime, rather than through dlsym: the plugin
// can be linked statically into the app, whose release builds strip global
// symbols.
//
// Every function takes the |engine_id| of the calling isolate,
// `PlatformDispatcher.instance.engineId`. Each Flutter engine registers a
// plugin of its own, with its own texture registry, and its texture ids only
// name textures of that engine.
//
// Functions that can fail return false or -1 and write a null-terminated
// message to |error|, of |error_size| bytes, when it is not null. Dart calls
// them on its UI thread.

#ifndef MAPLIBRE_NATIVE_API_H_
#define MAPLIBRE_NATIVE_API_H_

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#if defined(__cplusplus)
extern "C" {
#endif

// A function of this API and its name, as +[MaplibreNativePlugin symbols]
// lists them. The list ends with an entry whose name is null.
typedef struct MaplibreNativeSymbol {
  const char* name;
  void* address;
} MaplibreNativeSymbol;

// Registers a zero-copy texture that shows the frames of a ring of IOSurfaces,
// which the C library allocates and renders into, and returns its Flutter
// texture id, or -1 on failure.
int64_t maplibre_native_create_gpu_texture(int64_t engine_id, char* error,
                                           size_t error_size);

// Makes the finished frame in the IOSurfaceRef |surface|, at |slot| of the
// ring |ring|, the one Flutter shows next, without a copy. |ring| changes
// when the ring's surfaces do; the plugin wraps each surface of a ring in a
// pixel buffer once. The frame stays acquired until
// maplibre_native_gpu_texture_slot_in_use reports the slot free.
bool maplibre_native_present_gpu_texture(int64_t engine_id,
                                         int64_t texture_id, uint32_t ring,
                                         uint32_t slot, void* surface,
                                         char* error, size_t error_size);

// Whether Flutter may still sample |slot|, so its frame must stay acquired:
// the slot is the presented one, or one of the last two that Flutter took.
bool maplibre_native_gpu_texture_slot_in_use(int64_t engine_id,
                                             int64_t texture_id,
                                             uint32_t slot);

// Unregisters a texture.
void maplibre_native_dispose_texture(int64_t engine_id, int64_t texture_id);

#if defined(__cplusplus)
}  // extern "C"
#endif

#endif  // MAPLIBRE_NATIVE_API_H_
