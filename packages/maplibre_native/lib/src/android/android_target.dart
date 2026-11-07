import 'package:maplibre_native/src/android/android_plugin.dart';
import 'package:maplibre_native/src/frame_target.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

/// Creates the target of an Android map, which presents to the Surface of a
/// Flutter SurfaceProducer texture on its session's core worker, through the
/// graphics context that the C library creates: an EGL context of its own
/// (OpenGL ES, the default), or a Vulkan device and swapchain.
FrameTarget createAndroidTarget(LogicalExtent extent) {
  AndroidPlugin.initialize();
  return _SurfaceTarget(extent);
}

final class _SurfaceTarget extends FrameTarget {
  _SurfaceTarget(LogicalExtent extent) {
    final (width, height) = physicalSize(extent);
    _texture = AndroidPlugin.createSurfaceTexture(
      width,
      height,
      onSurfaceAvailable: _onSurfaceAvailable,
      onSurfaceCleanup: _onSurfaceCleanup,
    );
  }

  late final SurfaceTexture _texture;

  RenderSessionHandle? _session;

  /// Whether the Surface accepts frames. Flutter takes it away while the app
  /// is in the background.
  var _surfaceAvailable = true;

  @override
  int get textureId => _texture.textureId;

  @override
  bool get acceptsFrames => _surfaceAvailable;

  @override
  RenderSessionHandle attach(
    MapHandle map,
    LogicalExtent extent,
    Wake frameWake,
  ) => _session = AndroidPlugin.withSurface<RenderSessionHandle>(
    textureId,
    (jniEnv, surface) => map.attachAndroidSurface(
      AndroidSurfaceDescriptor(
        logicalSize: logicalSize(extent),
        jniEnv: jniEnv,
        surface: surface,
      ),
      RenderSessionAttachOptions(
        driver: RenderDriverKind.coreWorker,
        frameWake: frameWake,
      ),
    ),
  );

  /// Sizes the SurfaceProducer's buffers and the session. Flutter may hand
  /// out a new Surface for the new size, which the session then moves to.
  @override
  Future<void> resize(RenderSessionHandle session, LogicalExtent extent) async {
    final (width, height) = physicalSize(extent);
    if (AndroidPlugin.resizeSurfaceTexture(textureId, width, height)) {
      await _setSurface(session, extent);
    } else {
      await session.resize(logicalSize(extent));
    }
  }

  /// The session presented the frame to the Surface, and Flutter takes the
  /// newest image there.
  @override
  Future<bool> present(RenderSessionHandle session) async => true;

  /// Moves [session] to the texture's current Surface.
  Future<void> _setSurface(RenderSessionHandle session, LogicalExtent extent) =>
      AndroidPlugin.withSurface(
        textureId,
        (jniEnv, surface) => session.setAndroidSurfaceTarget(
          AndroidSurfaceReplacement(
            logicalSize: logicalSize(extent),
            jniEnv: jniEnv,
            surface: surface,
          ),
        ),
      );

  /// The Surface goes away, e.g. when the app moves to the background: the
  /// session lets go of it, and frames pause until it is back. The session
  /// keeps its own reference to the window, so a frame in flight finishes.
  void _onSurfaceCleanup() {
    _surfaceAvailable = false;
    final host = this.host;
    final session = _session;
    if (host == null || host.disposed || session == null) return;
    host.onGpuQueue(session.releaseTarget).ignore();
  }

  /// The Surface is back, maybe as a new one: the session presents to it and
  /// rendering resumes.
  void _onSurfaceAvailable() {
    final host = this.host;
    final session = _session;
    if (host == null || host.disposed || session == null) return;
    host.onGpuQueue(() async {
      if (host.disposed) return;
      await _setSurface(session, host.extent);
      _surfaceAvailable = true;
      host.demandFrame();
    }).ignore();
  }

  /// The session closed, so nothing presents to the surface anymore.
  @override
  void dispose() => AndroidPlugin.disposeTexture(_texture);
}
