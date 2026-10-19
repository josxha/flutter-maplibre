import 'package:maplibre_native/src/android/bindings.g.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

/// A SurfaceProducer texture: its Flutter texture id, the Vulkan surface of
/// its current Surface, and the listener that the plugin calls on Surface
/// changes, which [AndroidPlugin.disposeTexture] releases.
typedef SurfaceTexture = ({
  int textureId,
  int surface,
  SurfaceListener listener,
});

/// The maplibre_native Android plugin, called through the jnigen bindings to
/// its Kotlin `MaplibreNativeApi`.
final class AndroidPlugin {
  AndroidPlugin._();

  /// Initializes the C library for Android once, and returns the Vulkan
  /// device that render sessions borrow.
  static VulkanContextDescriptor vulkanContext() {
    final values = MaplibreNativeApi.vulkanContext();
    try {
      return VulkanContextDescriptor(
        instance: NativePointer(values[0]),
        physicalDevice: NativePointer(values[1]),
        device: NativePointer(values[2]),
        graphicsQueue: NativePointer(values[3]),
        graphicsQueueFamilyIndex: values[4],
        getInstanceProcAddr: NativePointer(values[5]),
        getDeviceProcAddr: NativePointer(values[6]),
      );
    } finally {
      values.release();
    }
  }

  /// Creates a SurfaceProducer texture of [width] x [height] pixels.
  ///
  /// [onSurfaceChanged] receives the new and the old Vulkan surface when
  /// Flutter recreates the Surface, and [onSurfaceCleanup] runs when the
  /// Surface becomes invalid. Both run asynchronously on the isolate.
  static SurfaceTexture createSurfaceTexture(
    int width,
    int height, {
    required void Function(int surface, int oldSurface) onSurfaceChanged,
    required void Function() onSurfaceCleanup,
  }) {
    final listener = SurfaceListener.implement(
      $SurfaceListener(
        onSurfaceChanged: onSurfaceChanged,
        onSurfaceChanged$async: true,
        onSurfaceCleanup: onSurfaceCleanup,
        onSurfaceCleanup$async: true,
      ),
    );
    final values = MaplibreNativeApi.createSurfaceTexture(
      width,
      height,
      listener,
    );
    try {
      return (textureId: values[0], surface: values[1], listener: listener);
    } finally {
      values.release();
    }
  }

  /// Sizes a texture's buffers. Returns its Vulkan surface, and the old one
  /// when Flutter handed out a new Surface for the new size.
  static (int surface, int? oldSurface) resizeSurfaceTexture(
    int textureId,
    int width,
    int height,
  ) {
    final values = MaplibreNativeApi.resizeSurfaceTexture(
      textureId,
      width,
      height,
    );
    try {
      return (values[0], values[1] == 0 ? null : values[1]);
    } finally {
      values.release();
    }
  }

  /// Destroys a Vulkan surface that no session presents to anymore.
  static void releaseSurface(int surface) =>
      MaplibreNativeApi.releaseSurface(surface);

  /// Releases a texture and its listener. [keepSurface] keeps the Vulkan
  /// surface, which a swapchain that abandon quarantined still needs.
  static void disposeTexture(
    SurfaceTexture texture, {
    required bool keepSurface,
  }) {
    MaplibreNativeApi.disposeTexture(texture.textureId, keepSurface);
    texture.listener.release();
  }
}
