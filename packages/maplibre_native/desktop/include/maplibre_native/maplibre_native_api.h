// C API of the maplibre_native Windows and Linux plugins, which Dart calls
// through the ffigen bindings in lib/src/desktop/bindings.g.dart. Regenerate
// them with `cd tool/codegen && dart run ffigen.dart` after changing this file.
//
// MapLibre renders through Vulkan on a device that the C library creates on
// Flutter's GPU, which maplibre_native_gpu_id names. On Windows the library
// allocates a ring of DXGI shared textures, and the plugin copies each frame
// into a texture that Flutter shows. On Linux the plugin allocates a ring of
// Vulkan images whose memory Flutter's OpenGL context samples. Each platform
// defines only its own functions, which Dart calls only there.
//
// Every function takes the |engine_id| of the calling isolate,
// `PlatformDispatcher.instance.engineId`. Each Flutter engine registers a
// plugin of its own, with its own texture registrar, and its texture ids only
// name textures of that engine.
//
// Functions that can fail return false or -1 and write a null-terminated
// message to |error|, of |error_size| bytes, when it is not null. Dart calls
// them on its UI thread; the plugin registers on the platform thread.

#ifndef FLUTTER_PLUGIN_MAPLIBRE_NATIVE_API_H_
#define FLUTTER_PLUGIN_MAPLIBRE_NATIVE_API_H_

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#if defined(_WIN32)
#ifdef FLUTTER_PLUGIN_IMPL
#define MAPLIBRE_NATIVE_EXPORT __declspec(dllexport)
#else
#define MAPLIBRE_NATIVE_EXPORT __declspec(dllimport)
#endif
#else
#define MAPLIBRE_NATIVE_EXPORT __attribute__((visibility("default")))
#endif

#if defined(__cplusplus)
extern "C" {
#endif

// The Vulkan device of the C library that render sessions use, as
// VulkanDeviceHandle.getContext() reports it.
typedef struct MaplibreNativeVulkanContext {
  uint64_t instance;
  uint64_t physical_device;
  uint64_t device;
  uint64_t get_instance_proc_addr;
  uint64_t get_device_proc_addr;
} MaplibreNativeVulkanContext;

// One Vulkan image of a GPU texture's ring, and its view.
typedef struct MaplibreNativeGpuSlot {
  uint64_t image;
  uint64_t view;
} MaplibreNativeGpuSlot;

// Writes the ID of the GPU that Flutter renders on to |out_id|, of
// |capacity| bytes, and returns its size: the 8-byte adapter LUID on Windows,
// the 16-byte device UUID that OpenGL reports on Linux. Returns -1 when
// frames can't reach Flutter without a CPU copy, or when
// MAPLIBRE_NATIVE_DISABLE_ZERO_COPY is set.
MAPLIBRE_NATIVE_EXPORT int32_t maplibre_native_gpu_id(int64_t engine_id,
                                                      uint8_t* out_id,
                                                      size_t capacity,
                                                      char* error,
                                                      size_t error_size);

// Registers a CPU pixel buffer texture and returns its Flutter texture id.
MAPLIBRE_NATIVE_EXPORT int64_t
maplibre_native_create_pixel_texture(int64_t engine_id);

// Copies |height| rows of |width| RGBA8 pixels, |stride| bytes apart, into a
// pixel buffer texture and marks a new frame available.
MAPLIBRE_NATIVE_EXPORT bool maplibre_native_update_pixel_texture(
    int64_t engine_id, int64_t texture_id, uint32_t width, uint32_t height,
    uint32_t stride, const uint8_t* pixels, size_t length, char* error,
    size_t error_size);

// Unregisters a texture of any kind.
MAPLIBRE_NATIVE_EXPORT void maplibre_native_dispose_texture(int64_t engine_id,
                                                            int64_t texture_id);

// Windows: registers a texture that shows the frames of a ring of DXGI
// shared textures, and returns its Flutter texture id.
MAPLIBRE_NATIVE_EXPORT int64_t maplibre_native_create_shared_texture(
    int64_t engine_id, char* error, size_t error_size);

// Windows: copies the finished frame in the DXGI shared texture |handle|, an
// NT handle, into the texture that Flutter shows, before it returns. |ring|
// changes when the ring's textures do, and |slot| is the texture's index in
// the ring; the plugin opens each texture of a ring once.
MAPLIBRE_NATIVE_EXPORT bool maplibre_native_present_shared_texture(
    int64_t engine_id, int64_t texture_id, uint32_t ring, uint32_t slot,
    uint64_t handle, char* error, size_t error_size);

// Linux: registers a zero-copy texture of |width| x |height| device pixels
// with a ring of |slot_count| images on the Vulkan device |context|, whose
// memory Flutter's OpenGL context samples. Writes the VkFormat and up to
// |slot_capacity| slots. Returns its Flutter texture id, or -1 when the GPU
// cannot share the images.
MAPLIBRE_NATIVE_EXPORT int64_t maplibre_native_create_gpu_texture(
    int64_t engine_id, const MaplibreNativeVulkanContext* context,
    uint32_t width, uint32_t height, uint32_t slot_count, uint32_t* out_format,
    MaplibreNativeGpuSlot* out_slots, uint32_t slot_capacity, char* error,
    size_t error_size);

// Linux: replaces the ring with one of the new size and writes its slots. The
// old ring stays valid until maplibre_native_release_retired_slots.
MAPLIBRE_NATIVE_EXPORT bool maplibre_native_resize_gpu_texture(
    int64_t engine_id, int64_t texture_id, uint32_t width, uint32_t height,
    MaplibreNativeGpuSlot* out_slots, uint32_t slot_capacity, char* error,
    size_t error_size);

// Linux: releases the rings that resizes replaced.
MAPLIBRE_NATIVE_EXPORT void maplibre_native_release_retired_slots(
    int64_t engine_id, int64_t texture_id);

// Linux: has Flutter sample the finished frame in |slot|, which stays in use
// until maplibre_native_gpu_texture_slot_in_use reports it free.
MAPLIBRE_NATIVE_EXPORT bool maplibre_native_present_gpu_texture(
    int64_t engine_id, int64_t texture_id, uint32_t slot, char* error,
    size_t error_size);

// Linux: whether Flutter may still sample |slot| of a GPU texture. False for
// a texture that does not exist.
MAPLIBRE_NATIVE_EXPORT bool maplibre_native_gpu_texture_slot_in_use(
    int64_t engine_id, int64_t texture_id, uint32_t slot);

#if defined(__cplusplus)
}  // extern "C"
#endif

#endif  // FLUTTER_PLUGIN_MAPLIBRE_NATIVE_API_H_
