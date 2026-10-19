// C API of the maplibre_native Windows plugin, which Dart calls through the
// ffigen bindings in lib/src/windows/bindings.g.dart. Regenerate them with
// `dart run ffigen --config ffigen.yaml` after changing this file.
//
// Functions that can fail return false or -1 and write a null-terminated
// message to |error|, of |error_size| bytes, when it is not null. Dart calls
// them on its UI thread; the plugin registers on the platform thread.

#ifndef FLUTTER_PLUGIN_MAPLIBRE_NATIVE_API_H_
#define FLUTTER_PLUGIN_MAPLIBRE_NATIVE_API_H_

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#ifdef FLUTTER_PLUGIN_IMPL
#define MAPLIBRE_NATIVE_EXPORT __declspec(dllexport)
#else
#define MAPLIBRE_NATIVE_EXPORT __declspec(dllimport)
#endif

#if defined(__cplusplus)
extern "C" {
#endif

// The process-wide Vulkan device that MapLibre render sessions borrow.
typedef struct MaplibreNativeVulkanContext {
  uint64_t instance;
  uint64_t physical_device;
  uint64_t device;
  uint64_t queue;
  uint32_t queue_family_index;
  uint64_t get_instance_proc_addr;
  uint64_t get_device_proc_addr;
} MaplibreNativeVulkanContext;

// One Vulkan image of a GPU texture's ring, and its view.
typedef struct MaplibreNativeGpuSlot {
  uint64_t image;
  uint64_t view;
} MaplibreNativeGpuSlot;

// Creates the Vulkan device on Flutter's GPU on first use.
MAPLIBRE_NATIVE_EXPORT bool maplibre_native_vulkan_context(
    MaplibreNativeVulkanContext* out_context, char* error, size_t error_size);

// Registers a CPU pixel buffer texture and returns its Flutter texture id.
MAPLIBRE_NATIVE_EXPORT int64_t maplibre_native_create_pixel_texture(void);

// Copies |height| rows of |width| RGBA8 pixels, |stride| bytes apart, into a
// pixel buffer texture and marks a new frame available.
MAPLIBRE_NATIVE_EXPORT bool maplibre_native_update_pixel_texture(
    int64_t texture_id, uint32_t width, uint32_t height, uint32_t stride,
    const uint8_t* pixels, size_t length, char* error, size_t error_size);

// Registers a zero-copy texture of |width| x |height| device pixels with a
// ring of |slot_count| images shared between Vulkan and D3D11. Writes the
// VkFormat and up to |slot_capacity| slots. Returns its Flutter texture id, or
// -1 when the GPU cannot share textures.
MAPLIBRE_NATIVE_EXPORT int64_t maplibre_native_create_gpu_texture(
    uint32_t width, uint32_t height, uint32_t slot_count, uint32_t* out_format,
    MaplibreNativeGpuSlot* out_slots, uint32_t slot_capacity, char* error,
    size_t error_size);

// Replaces the ring with one of the new size and writes its slots. The old
// ring stays valid until maplibre_native_release_retired_slots.
MAPLIBRE_NATIVE_EXPORT bool maplibre_native_resize_gpu_texture(
    int64_t texture_id, uint32_t width, uint32_t height,
    MaplibreNativeGpuSlot* out_slots, uint32_t slot_capacity, char* error,
    size_t error_size);

// Releases the rings that resizes replaced.
MAPLIBRE_NATIVE_EXPORT void maplibre_native_release_retired_slots(
    int64_t texture_id);

// Copies the finished frame in |slot| into the texture Flutter shows next.
MAPLIBRE_NATIVE_EXPORT bool maplibre_native_present_gpu_texture(
    int64_t texture_id, uint32_t slot, char* error, size_t error_size);

// Unregisters a texture of either kind.
MAPLIBRE_NATIVE_EXPORT void maplibre_native_dispose_texture(int64_t texture_id);

#if defined(__cplusplus)
}  // extern "C"
#endif

#endif  // FLUTTER_PLUGIN_MAPLIBRE_NATIVE_API_H_
