import 'dart:ffi';

import 'package:jni/jni.dart';
import 'package:maplibre_native/src/android/bindings.g.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

/// A SurfaceProducer texture: its Flutter texture id, and the listener that
/// the plugin calls on Surface changes, which [AndroidPlugin.disposeTexture]
/// releases.
typedef SurfaceTexture = ({int textureId, SurfaceListener listener});

/// The maplibre_native Android plugin, called through the jnigen bindings to
/// its Kotlin `MaplibreNativeApi`.
final class AndroidPlugin {
  AndroidPlugin._();

  static var _initialized = false;

  /// Hands the C library the Java VM and the app context once, before its
  /// first use.
  static void initialize() {
    if (_initialized) return;
    final context = MaplibreNativeApi.applicationContext();
    try {
      initAndroid(jniEnv, _pointer(context));
    } finally {
      context.release();
    }
    _initialized = true;
  }

  /// The `jobject` of [object], for the C library, which takes its own
  /// reference where it keeps one. `package:jni` has no public accessor for
  /// it.
  static NativePointer _pointer(JObject object) =>
      // ignore: invalid_use_of_internal_member
      NativePointer(object.reference.pointer.address);

  /// The `JNIEnv*` of the calling thread, which `package:jni` attached to
  /// the Java VM before its first call. JNI's invocation interface puts
  /// `GetEnv` at index 6 of the VM's function table. `package:jni` has no
  /// public accessor for it.
  static NativePointer get jniEnv => using((arena) {
    final vm = arena<Pointer<Void>>();
    // ignore: invalid_use_of_internal_member
    if (Jni.env.GetJavaVM(vm.cast()) != 0) {
      throw StateError('JNI has no Java VM.');
    }
    final getEnv = vm.value
        .cast<
          Pointer<
            Pointer<
              NativeFunction<
                Int32 Function(Pointer<Void>, Pointer<Pointer<Void>>, Int32)
              >
            >
          >
        >()
        .value[6]
        .asFunction<int Function(Pointer<Void>, Pointer<Pointer<Void>>, int)>();
    final env = arena<Pointer<Void>>();
    const jniVersion1_6 = 0x00010006;
    if (getEnv(vm.value, env, jniVersion1_6) != 0) {
      throw StateError('This thread is not attached to the Java VM.');
    }
    return NativePointer(env.value.address);
  });

  /// Creates a SurfaceProducer texture of [width] x [height] pixels.
  ///
  /// [onSurfaceAvailable] runs when the Surface is back after
  /// [onSurfaceCleanup] took it away, maybe as a new one. Both run
  /// asynchronously on the isolate.
  static SurfaceTexture createSurfaceTexture(
    int width,
    int height, {
    required void Function() onSurfaceAvailable,
    required void Function() onSurfaceCleanup,
  }) {
    final listener = SurfaceListener.implement(
      $SurfaceListener(
        onSurfaceAvailable: onSurfaceAvailable,
        onSurfaceAvailable$async: true,
        onSurfaceCleanup: onSurfaceCleanup,
        onSurfaceCleanup$async: true,
      ),
    );
    final textureId = MaplibreNativeApi.createSurfaceTexture(
      width,
      height,
      listener,
    );
    return (textureId: textureId, listener: listener);
  }

  /// Runs [use] with the current Surface of a texture, as the descriptor
  /// fields of the C library name it, and releases the Surface's reference
  /// after. The library takes its own reference to the window.
  static T withSurface<T>(
    int textureId,
    T Function(NativePointer jniEnv, NativePointer surface) use,
  ) {
    final surface = MaplibreNativeApi.surface(textureId);
    try {
      return use(jniEnv, _pointer(surface));
    } finally {
      surface.release();
    }
  }

  /// Sizes a texture's buffers. Returns whether Flutter handed out a new
  /// Surface for them.
  static bool resizeSurfaceTexture(int textureId, int width, int height) =>
      MaplibreNativeApi.resizeSurfaceTexture(textureId, width, height);

  /// Releases a texture and its listener.
  static void disposeTexture(SurfaceTexture texture) {
    MaplibreNativeApi.disposeTexture(texture.textureId);
    texture.listener.release();
  }
}
