import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:maplibre_native/src/desktop/bindings.g.dart';
import 'package:maplibre_native/src/engine.dart';
import 'package:maplibre_native/src/plugin_error.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

/// The most ring slots a GPU texture has.
const _maxSlots = 8;

/// A zero-copy texture: its Flutter texture id, the VkFormat of its images,
/// and its ring of Vulkan images.
typedef GpuTexture = ({
  int textureId,
  int format,
  List<VulkanBorrowedTexture> slots,
});

/// The maplibre_native Windows or Linux plugin, called through the C API in
/// `desktop/include/maplibre_native/maplibre_native_api.h`. Each plugin
/// library exports the shared functions and its own.
final class DesktopPlugin {
  DesktopPlugin._();

  static final _bindings = MaplibreNativeDesktopBindings(
    // The app links the plugin, so the library is loaded already.
    DynamicLibrary.open(
      Platform.isWindows
          ? 'maplibre_native_plugin.dll'
          : 'libmaplibre_native_plugin.so',
    ),
  );

  /// The ID of the GPU that Flutter renders on (the adapter LUID on
  /// Windows, the OpenGL device UUID on Linux), or the reason frames can't
  /// reach Flutter without a CPU copy.
  static (Uint8List?, String?) gpuId() => using((arena) {
    const capacity = 16;
    final id = arena<Uint8>(capacity);
    final error = arena<Char>(pluginErrorSize);
    final size = _bindings.maplibre_native_gpu_id(
      engineId,
      id,
      capacity,
      error,
      pluginErrorSize,
    );
    if (size < 0) return (null, _message(error));
    return (Uint8List.fromList(id.asTypedList(size)), null);
  });

  /// Registers a pixel buffer texture and returns its Flutter texture id.
  static int createPixelTexture() {
    final id = _bindings.maplibre_native_create_pixel_texture(engineId);
    if (id < 0) {
      throw StateError('The maplibre_native plugin is not registered.');
    }
    return id;
  }

  /// Copies an RGBA8 frame into a pixel buffer texture.
  static void updatePixelTexture(
    int textureId, {
    required int width,
    required int height,
    required int stride,
    required Uint8List pixels,
  }) => using((arena) {
    final buffer = arena<Uint8>(pixels.length)
      ..asTypedList(pixels.length).setAll(0, pixels);
    final error = arena<Char>(pluginErrorSize);
    if (!_bindings.maplibre_native_update_pixel_texture(
      engineId,
      textureId,
      width,
      height,
      stride,
      buffer,
      pixels.length,
      error,
      pluginErrorSize,
    )) {
      throw StateError(_message(error));
    }
  });

  /// Windows: registers a texture that shows a ring of DXGI shared
  /// textures, or returns the reason it is unavailable.
  static (int?, String?) createSharedTexture() => using((arena) {
    final error = arena<Char>(pluginErrorSize);
    final id = _bindings.maplibre_native_create_shared_texture(
      engineId,
      error,
      pluginErrorSize,
    );
    return id < 0 ? (null, _message(error)) : (id, null);
  });

  /// Windows: copies the finished frame in the DXGI shared texture [handle],
  /// at [slot] of the ring [ring], into the texture that Flutter shows.
  static void presentSharedTexture(
    int textureId, {
    required int ring,
    required int slot,
    required int handle,
  }) => using((arena) {
    final error = arena<Char>(pluginErrorSize);
    if (!_bindings.maplibre_native_present_shared_texture(
      engineId,
      textureId,
      ring,
      slot,
      handle,
      error,
      pluginErrorSize,
    )) {
      throw StateError(_message(error));
    }
  });

  /// Linux: registers a zero-copy texture of [width] x [height] device
  /// pixels with a ring of images on the Vulkan device [context], whose
  /// memory Flutter's OpenGL context samples, or returns the reason it is
  /// unavailable on this GPU.
  static (GpuTexture?, String?) createGpuTexture(
    VulkanContextDescriptor context,
    int width,
    int height,
    int slotCount,
  ) => using((arena) {
    final vulkan = arena<MaplibreNativeVulkanContext>();
    vulkan.ref
      ..instance = context.instance.address
      ..physical_device = context.physicalDevice.address
      ..device = context.device.address
      ..get_instance_proc_addr = context.getInstanceProcAddr.address
      ..get_device_proc_addr = context.getDeviceProcAddr.address;
    final format = arena<Uint32>();
    final slots = arena<MaplibreNativeGpuSlot>(_maxSlots);
    final error = arena<Char>(pluginErrorSize);
    final id = _bindings.maplibre_native_create_gpu_texture(
      engineId,
      vulkan,
      width,
      height,
      slotCount,
      format,
      slots,
      _maxSlots,
      error,
      pluginErrorSize,
    );
    if (id < 0) return (null, _message(error));
    return (
      (textureId: id, format: format.value, slots: _slots(slots, slotCount)),
      null,
    );
  });

  /// Linux: replaces a GPU texture's ring with one of the new size. The old ring
  /// stays valid until [releaseRetiredSlots].
  static List<VulkanBorrowedTexture> resizeGpuTexture(
    int textureId,
    int width,
    int height,
    int slotCount,
  ) => using((arena) {
    final slots = arena<MaplibreNativeGpuSlot>(_maxSlots);
    final error = arena<Char>(pluginErrorSize);
    if (!_bindings.maplibre_native_resize_gpu_texture(
      engineId,
      textureId,
      width,
      height,
      slots,
      _maxSlots,
      error,
      pluginErrorSize,
    )) {
      throw StateError(_message(error));
    }
    return _slots(slots, slotCount);
  });

  /// Linux: releases the rings that resizes replaced.
  static void releaseRetiredSlots(int textureId) =>
      _bindings.maplibre_native_release_retired_slots(engineId, textureId);

  /// Linux: has Flutter sample the finished frame in [slot] until
  /// [slotInUse] reports it free.
  static void presentGpuTexture(int textureId, int slot) => using((arena) {
    final error = arena<Char>(pluginErrorSize);
    if (!_bindings.maplibre_native_present_gpu_texture(
      engineId,
      textureId,
      slot,
      error,
      pluginErrorSize,
    )) {
      throw StateError(_message(error));
    }
  });

  /// Linux: whether Flutter may still sample [slot] of a GPU texture.
  static bool slotInUse(int textureId, int slot) => _bindings
      .maplibre_native_gpu_texture_slot_in_use(engineId, textureId, slot);

  /// Unregisters a texture of any kind.
  static void disposeTexture(int textureId) =>
      _bindings.maplibre_native_dispose_texture(engineId, textureId);

  static List<VulkanBorrowedTexture> _slots(
    Pointer<MaplibreNativeGpuSlot> slots,
    int count,
  ) => [
    for (var i = 0; i < count; i++)
      VulkanBorrowedTexture(image: slots[i].image, imageView: slots[i].view),
  ];

  static String _message(Pointer<Char> error) => pluginErrorMessage(error);
}
