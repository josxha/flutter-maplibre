import 'package:flutter/foundation.dart';
import 'package:maplibre_native/src/android/android_plugin.dart';
import 'package:maplibre_native/src/frame_target.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

VulkanContextDescriptor? _vulkanContext;
OpenGlContextDescriptor? _eglContext;

/// Whether Android maps render through OpenGL ES rather than Vulkan. The C
/// library carries one backend, which the build hook picked: OpenGL ES unless
/// the app selected Vulkan.
bool get _usesOpenGl =>
    supportedRenderBackendMask().contains(RenderBackendFlag.openGl);

/// Creates the target of an Android map, which presents to the Surface of a
/// Flutter SurfaceProducer texture: through an EGL window surface on a plugin
/// render thread (OpenGL ES, the default), or through a Vulkan swapchain on
/// its core worker.
FrameTarget createAndroidTarget(LogicalExtent extent) {
  final opengl = _usesOpenGl;
  // Also initializes the C library for Android, before its first use.
  if (opengl) {
    _eglContext ??= AndroidPlugin.eglContext();
  } else {
    _vulkanContext ??= AndroidPlugin.vulkanContext();
  }
  return _SurfaceTarget(extent, opengl: opengl);
}

/// An OpenGL ES session's place on the plugin's render thread.
///
/// EGL surface sessions use the caller-graphics-thread driver, so their
/// rendering runs where it is serviced. That is one plugin thread for all
/// maps rather than the Dart isolate, which runs on Android's main thread.
/// The session asks for service through its driver work [wake], which wakes
/// the thread natively.
final class _RenderClient {
  factory _RenderClient() {
    final (handle, wake) = AndroidPlugin.addRenderClient();
    return _RenderClient._(handle, wake);
  }

  _RenderClient._(this._handle, this.wake);

  final int _handle;
  final Wake wake;
  var _removed = false;

  /// Starts servicing [session], also for work it queued before.
  void start(RenderSessionHandle session) =>
      AndroidPlugin.setRenderClientSession(_handle, session);

  /// Stops servicing the session once its work in flight is done.
  void stop() {
    if (_removed) return;
    _removed = true;
    AndroidPlugin.removeRenderClient(_handle);
  }
}

final class _SurfaceTarget extends FrameTarget {
  _SurfaceTarget(LogicalExtent extent, {required this.opengl}) {
    final (width, height) = physicalSize(extent);
    _texture = AndroidPlugin.createSurfaceTexture(
      width,
      height,
      opengl: opengl,
      onSurfaceChanged: _onSurfaceChanged,
      onSurfaceCleanup: () => _surfaceAvailable = false,
    );
  }

  /// Whether the session renders through OpenGL ES.
  final bool opengl;

  late final SurfaceTexture _texture;

  /// Where the render thread services the session of an OpenGL ES map.
  _RenderClient? _renderClient;

  RenderSessionHandle? _session;

  /// Whether the Surface accepts frames. Flutter takes it away while the app
  /// is in the background.
  var _surfaceAvailable = true;

  @override
  int get textureId => _texture.textureId;

  @override
  FrameDemandFlag get demandFlags =>
      super.demandFlags | FrameDemandFlag.present;

  @override
  bool get acceptsFrames => _surfaceAvailable;

  @override
  NewRenderSession attach(MapHandle map, LogicalExtent extent, Wake frameWake) {
    final NewRenderSession attachment;
    if (opengl) {
      // Attachment and every frame are driver work, which the client wakes
      // the render thread for from the start.
      final client = _renderClient = _RenderClient();
      try {
        attachment = map.attachOpenGlSurface(
          _openglDescriptor(_texture.surface, extent),
          RenderSessionAttachOptions(
            driver: RenderDriverKind.callerGraphicsThread,
            frameWake: frameWake,
            driverWorkWake: client.wake,
          ),
        );
      } on Object {
        client.stop();
        _renderClient = null;
        rethrow;
      }
      client.start(attachment.session);
    } else {
      attachment = map.attachVulkanSurface(
        _vulkanDescriptor(_texture.surface, extent),
        RenderSessionAttachOptions(
          driver: RenderDriverKind.coreWorker,
          frameWake: frameWake,
        ),
      );
    }
    _session = attachment.session;
    return attachment;
  }

  OpenGlSurfaceDescriptor _openglDescriptor(
    int surface,
    LogicalExtent extent,
  ) => OpenGlSurfaceDescriptor(
    extent: extent,
    context: _eglContext!,
    surface: NativePointer(surface),
  );

  VulkanSurfaceDescriptor _vulkanDescriptor(
    int surface,
    LogicalExtent extent,
  ) => VulkanSurfaceDescriptor(
    extent: extent,
    context: _vulkanContext!,
    surface: surface,
  );

  /// Sizes the SurfaceProducer's buffers and the session. Flutter may hand
  /// out a new Surface for the new size, which the session then moves to.
  @override
  Future<void> resize(RenderSessionHandle session, LogicalExtent extent) async {
    final (width, height) = physicalSize(extent);
    final (surface, oldSurface) = AndroidPlugin.resizeSurfaceTexture(
      textureId,
      width,
      height,
    );
    if (oldSurface != null) {
      await _replaceSurface(surface, oldSurface, extent);
    } else {
      await session.resize(extent);
    }
  }

  /// The session presented the frame to the Surface, and Flutter takes the
  /// newest image there.
  @override
  Future<bool> present(RenderSessionHandle session) async => true;

  /// The Surface is available again, e.g. when the app returned from the
  /// background: rendering moves to [surface] when Flutter recreated it
  /// ([oldSurface] is 0 when it did not) and resumes.
  void _onSurfaceChanged(int surface, int oldSurface) {
    final host = this.host;
    if (host == null || host.disposed || _session == null) {
      // Nothing presents to the old surface (anymore).
      if (oldSurface != 0) {
        AndroidPlugin.releaseSurface(oldSurface, opengl: opengl);
      }
      return;
    }
    host.onGpuQueue(() async {
      if (oldSurface != 0) {
        await _replaceSurface(surface, oldSurface, host.extent);
      }
      _surfaceAvailable = true;
      host.demandFrame();
    }).ignore();
  }

  /// Moves the session to [surface] and releases [oldSurface] once it no
  /// longer presents there.
  Future<void> _replaceSurface(
    int surface,
    int oldSurface,
    LogicalExtent extent,
  ) async {
    final session = _session;
    if (session != null && !(host?.disposed ?? false)) {
      if (opengl) {
        // The old EGLSurface stays current on the render thread until the
        // next frame, but EGL defers destroying it until then.
        await session.setOpenGlSurfaceTarget(
          _openglDescriptor(surface, extent),
        );
      } else {
        await session.setVulkanSurfaceTarget(
          _vulkanDescriptor(surface, extent),
        );
      }
    }
    AndroidPlugin.releaseSurface(oldSurface, opengl: opengl);
  }

  @override
  Future<void> endSession(RenderSessionHandle session) async {
    final client = _renderClient;
    if (client != null) {
      // Only the render thread may destroy the session's GL objects, which
      // closing an attached caller-thread session would keep until process
      // exit, so the session detaches there first.
      try {
        await session.detach();
      } on MaplibreException catch (error) {
        debugPrint('maplibre_native: detach failed: $error');
      }
      client.stop();
    }
    await session.close();
  }

  /// The session closed, so nothing presents to the surface anymore.
  @override
  void dispose() => AndroidPlugin.disposeTexture(_texture);
}
