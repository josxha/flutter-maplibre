// C API of the maplibre_native iOS and macOS plugin, which Dart calls through
// the ffigen bindings in lib/src/darwin/bindings.g.dart. Regenerate them with
// `cd tool/codegen && dart run ffigen.dart` after changing this file.
//
// Dart finds the functions through +[MaplibreNativePlugin symbols], which it
// calls through the Objective-C runtime, rather than through dlsym: the plugin
// can be linked statically into the app, whose release builds strip global
// symbols.
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

// Registers a zero-copy texture of |width| x |height| device pixels with a
// ring of |slot_count| BGRA8 Metal textures that MapLibre renders into, and
// writes up to |slot_capacity| `id<MTLTexture>` pointers, which stay owned by
// the plugin. Returns its Flutter texture id, or -1 on failure.
int64_t maplibre_native_create_gpu_texture(uint32_t width, uint32_t height,
                                           uint32_t slot_count,
                                           uint64_t* out_slots,
                                           uint32_t slot_capacity, char* error,
                                           size_t error_size);

// Replaces the ring with one of the new size and writes its textures. The old
// ring stays valid until maplibre_native_release_retired_slots.
bool maplibre_native_resize_gpu_texture(int64_t texture_id, uint32_t width,
                                        uint32_t height, uint64_t* out_slots,
                                        uint32_t slot_capacity, char* error,
                                        size_t error_size);

// Releases the rings that resizes replaced.
void maplibre_native_release_retired_slots(int64_t texture_id);

// Copies the finished frame in |slot| into the pixel buffer Flutter shows next
// and waits for the copy, so the frame can be released right after.
bool maplibre_native_present_gpu_texture(int64_t texture_id, uint32_t slot,
                                         char* error, size_t error_size);

// Unregisters a texture.
void maplibre_native_dispose_texture(int64_t texture_id);

#if defined(__cplusplus)
}  // extern "C"
#endif

#endif  // MAPLIBRE_NATIVE_API_H_
