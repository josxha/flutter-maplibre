import 'package:flutter/foundation.dart';
import 'package:maplibre_native/src/android/android_plugin.dart';
import 'package:maplibre_native/src/frame_target.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

VulkanContextDescriptor? _vulkanContext;
OpenglContextDescriptor? _eglContext;

/// Whether Android maps render through OpenGL ES rather than Vulkan. The C
/// library carries one backend, which the build hook picked: OpenGL ES unless
/// the app selected Vulkan.
bool get _usesOpenGl =>
    supportedRenderBackendMask().contains(RenderBackendFlag.opengl);

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

/// The native thread that services an OpenGL ES session on Android.
///
/// EGL surface sessions use the caller-graphics-thread driver, so their
/// rendering runs where it is serviced. That is a plugin thread rather than
/// the Dart isolate, which runs on Android's main thread. The session asks for
/// service through its driver work wake, which the isolate forwards here.
final class _RenderThread {
  int? _handle;

  void start(RenderSessionHandle session) {
    _handle = AndroidPlugin.startRenderThread(session);
    // A wake that arrived before the thread existed found nothing to wake.
    wake();
  }

  void wake() {
    if (_handle case final handle?) AndroidPlugin.wakeRenderThread(handle);
  }

  /// Ends the thread once its work in flight is done.
  void stop() {
    if (_handle case final handle?) AndroidPlugin.stopRenderThread(handle);
    _handle = null;
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

  /// The thread that services the session of an OpenGL ES map.
  _RenderThread? _renderThread;

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
  RenderSessionAttachment attach(
    MapHandle map,
    LogicalExtent extent,
    Wake frameWake,
  ) {
    final RenderSessionAttachment attachment;
    if (opengl) {
      // Attachment and every frame are driver work, so the thread starts
      // before the attachment completes.
      final thread = _renderThread = _RenderThread();
      attachment = map.attachOpenglSurface(
        _openglDescriptor(_texture.surface, extent),
        RenderSessionAttachOptions(
          frameWake: frameWake,
          driverWorkWake: Wake(callback: thread.wake),
        ),
      );
      thread.start(attachment.session);
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

  OpenglSurfaceDescriptor _openglDescriptor(
    int surface,
    LogicalExtent extent,
  ) => OpenglSurfaceDescriptor(
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
    surface: BigInt.from(surface).toUnsigned(64),
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
        await session.setOpenglSurfaceTarget(
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
  Future<bool> endSession(RenderSessionHandle session) async {
    final thread = _renderThread;
    if (thread == null) return abandonSession(session);
    // Only the render thread may destroy the session's GL objects, which
    // abandon would keep until process exit, so the session detaches there
    // first.
    var detached = false;
    try {
      await session.detach();
      detached = true;
    } on MaplibreException catch (error) {
      debugPrint('maplibre_native: detach failed: $error');
    }
    thread.stop();
    if (!detached) abandonSession(session);
    return false;
  }

  /// A swapchain kept until process exit needs its VkSurfaceKHR as long.
  @override
  void dispose({required bool quarantined}) =>
      AndroidPlugin.disposeTexture(_texture, keepSurface: quarantined);
}
