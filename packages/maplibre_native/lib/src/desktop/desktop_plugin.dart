import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:maplibre_native/src/desktop/bindings.g.dart';
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
/// `desktop/include/maplibre_native/maplibre_native_api.h`, which both
/// plugin libraries export.
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

  /// The Vulkan device on Flutter's GPU, created on first use.
  static VulkanContextDescriptor vulkanContext() => using((arena) {
    final context = arena<MaplibreNativeVulkanContext>();
    final error = arena<Char>(pluginErrorSize);
    if (!_bindings.maplibre_native_vulkan_context(
      context,
      error,
      pluginErrorSize,
    )) {
      throw StateError(_message(error));
    }
    final value = context.ref;
    return VulkanContextDescriptor(
      instance: NativePointer(value.instance),
      physicalDevice: NativePointer(value.physical_device),
      device: NativePointer(value.device),
      graphicsQueue: NativePointer(value.queue),
      graphicsQueueFamilyIndex: value.queue_family_index,
      getInstanceProcAddr: NativePointer(value.get_instance_proc_addr),
      getDeviceProcAddr: NativePointer(value.get_device_proc_addr),
    );
  });

  /// Registers a pixel buffer texture and returns its Flutter texture id.
  static int createPixelTexture() {
    final id = _bindings.maplibre_native_create_pixel_texture();
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

  /// Registers a zero-copy texture of [width] x [height] device pixels, or
  /// returns the reason it is unavailable on this GPU. Its images are shared
  /// with D3D11 on Windows and with OpenGL on Linux.
  static (GpuTexture?, String?) createGpuTexture(
    int width,
    int height,
    int slotCount,
  ) => using((arena) {
    final format = arena<Uint32>();
    final slots = arena<MaplibreNativeGpuSlot>(_maxSlots);
    final error = arena<Char>(pluginErrorSize);
    final id = _bindings.maplibre_native_create_gpu_texture(
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

  /// Replaces a GPU texture's ring with one of the new size. The old ring
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

  /// Releases the rings that resizes replaced.
  static void releaseRetiredSlots(int textureId) =>
      _bindings.maplibre_native_release_retired_slots(textureId);

  /// Copies the finished frame in [slot] into the texture Flutter shows next.
  static void presentGpuTexture(int textureId, int slot) => using((arena) {
    final error = arena<Char>(pluginErrorSize);
    if (!_bindings.maplibre_native_present_gpu_texture(
      textureId,
      slot,
      error,
      pluginErrorSize,
    )) {
      throw StateError(_message(error));
    }
  });

  /// Unregisters a texture of either kind.
  static void disposeTexture(int textureId) =>
      _bindings.maplibre_native_dispose_texture(textureId);

  static List<VulkanBorrowedTexture> _slots(
    Pointer<MaplibreNativeGpuSlot> slots,
    int count,
  ) => [
    for (var i = 0; i < count; i++)
      VulkanBorrowedTexture(
        image: BigInt.from(slots[i].image).toUnsigned(64),
        imageView: BigInt.from(slots[i].view).toUnsigned(64),
      ),
  ];

  static String _message(Pointer<Char> error) => pluginErrorMessage(error);
}
