import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:maplibre_native/src/android/android_plugin.dart';
import 'package:maplibre_native/src/darwin/darwin_plugin.dart';
import 'package:maplibre_native/src/windows/windows_plugin.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

/// Ring depth of a zero-copy texture: one slot Flutter shows, one MapLibre
/// renders into, and one spare.
const _gpuSlotCount = 3;

/// VK_IMAGE_LAYOUT_GENERAL. The session leaves each frame in the general
/// layout that D3D11 reads, and with the default initial layout of
/// VK_IMAGE_LAYOUT_UNDEFINED it takes a released slot back without a layout
/// transition.
const _vkImageLayoutGeneral = 1;

/// How frames reach Flutter.
enum _Target {
  /// Windows: a ring of D3D11 textures shared with Flutter, without a CPU
  /// copy.
  gpuTexture,

  /// Windows: CPU readback into a pixel buffer texture, where textures cannot
  /// be shared.
  pixelBuffer,

  /// Android: an EGL window surface or a Vulkan swapchain on the Surface of a
  /// Flutter SurfaceProducer.
  surface,

  /// iOS and macOS: a ring of Metal textures, each frame copied on the GPU
  /// into an IOSurface-backed pixel buffer that Flutter shows.
  metalTexture,
}

VulkanContextDescriptor? _vulkanContext;

/// The Vulkan device that the platform plugin created for MapLibre.
VulkanContextDescriptor _getVulkanContext() =>
    _vulkanContext ??= Platform.isAndroid
    ? AndroidPlugin.vulkanContext()
    : WindowsPlugin.vulkanContext();

OpenglContextDescriptor? _eglContext;

/// The EGL display and config that Android sessions create their contexts
/// from.
OpenglContextDescriptor _getEglContext() =>
    _eglContext ??= AndroidPlugin.eglContext();

/// Whether Android maps render through OpenGL ES rather than Vulkan. The C
/// library carries one backend, which the build hook picked: OpenGL ES unless
/// the app selected Vulkan.
final bool _androidUsesOpenGl =
    Platform.isAndroid &&
    supportedRenderBackendMask().contains(RenderBackendFlag.opengl);

/// Whether maps render through Metal, on iOS and macOS.
final bool _metal = Platform.isIOS || Platform.isMacOS;

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

/// Renders one MapLibre map into a Flutter texture.
///
/// - On Windows, the map renders on its session's core worker through Vulkan.
///   When the GPU shares textures between Vulkan and D3D11, the session
///   renders into a ring of shared textures that Flutter composites without a
///   CPU copy. Otherwise each frame is read back as RGBA8 into a pixel buffer
///   texture.
/// - On Android, the session presents to the Surface of a Flutter
///   SurfaceProducer texture: through an EGL window surface on a plugin render
///   thread (OpenGL ES, the default), or through a Vulkan swapchain on its
///   core worker.
/// - On iOS and macOS, the map renders on its session's core worker through
///   Metal into a ring of BGRA8 textures. The plugin copies each frame on the
///   GPU into an IOSurface-backed pixel buffer, which Flutter samples without
///   a CPU copy.
final class MapRenderer {
  MapRenderer._(
    this.textureId,
    this._runtime,
    this._map,
    this._session,
    this._extent,
    this._target, {
    this._format = 0,
    this._surfaceTexture,
    this._renderThread,
  });

  /// The Flutter texture id to show in a `Texture` widget.
  final int textureId;

  final RuntimeHandle _runtime;
  final MapHandle _map;
  final RenderSessionHandle _session;
  final _Target _target;
  final int _format;

  /// The SurfaceProducer texture on Android.
  final SurfaceTexture? _surfaceTexture;

  /// The thread that services the session of an OpenGL ES map on Android.
  final _RenderThread? _renderThread;

  /// Whether the session renders through OpenGL ES.
  bool get _opengl => _renderThread != null;

  /// Whether frames reach Flutter without a CPU copy.
  bool get isZeroCopy => _target != _Target.pixelBuffer;

  var _nextToken = 1;
  BigInt? _pendingToken;
  var _disposed = false;
  LogicalExtent _extent;
  LogicalExtent? _pendingExtent;
  var _resizing = false;

  /// Whether the Android Surface accepts frames. Flutter takes it away while
  /// the app is in the background.
  var _surfaceAvailable = true;

  /// Serializes frame presentation and target replacement, because a frame
  /// must not be acquired while the session replaces its target.
  Future<void> _gpuQueue = Future.value();

  /// The map, for camera, style, and projection calls.
  MapHandle get map => _map;

  /// Queries the features rendered at [geometry], in logical pixels. The
  /// C API answers asynchronously from the session's latest frame.
  Future<List<QueriedFeature>> queryRenderedFeatures(
    RenderedQueryGeometry geometry, {
    List<String>? layerIds,
  }) => _session.queryRenderedFeatures(
    geometry,
    options: layerIds == null
        ? null
        : RenderedFeatureQueryOptions(layerIds: layerIds),
  );

  /// The current logical extent of the map.
  LogicalExtent get extent => _pendingExtent ?? _extent;

  /// Receives every runtime event the map queues.
  void Function(RuntimeEvent event)? onEvent;

  /// Receives the projection and render result of each frame once
  /// Flutter can show it, so overlays can follow what is on screen rather than
  /// the latest camera, which the map image reaches a frame or two later. The
  /// receiver owns the projection.
  ///
  /// On Windows, iOS, and macOS Flutter shows the frame in its next frame. On
  /// Android the frame went to the Surface, and Flutter takes the newest image
  /// there, which is nearly always the same one.
  void Function(MapProjectionHandle projection, RenderFrameResult frame)?
  onFrameShown;

  /// Creates a renderer of [extent]. When [styleUrl] is given, the map loads
  /// it before the first frame.
  static Future<MapRenderer> create({
    required LogicalExtent extent,
    String? styleUrl,
    void Function(RuntimeEvent event)? onEvent,
    void Function(MapProjectionHandle projection, RenderFrameResult frame)?
    onFrameShown,
  }) async {
    if (_metal &&
        !supportedRenderBackendMask().contains(RenderBackendFlag.metal)) {
      throw UnsupportedError(
        'maplibre_native renders through Metal on ${Platform.operatingSystem}, '
        'but the MapLibre Native C library was built for another backend. '
        'Remove hooks.user_defines.maplibre_native_ffi.backend for this build.',
      );
    }
    // Also initializes the C library for Android, before its first use.
    final opengl = _androidUsesOpenGl;
    final eglContext = opengl ? _getEglContext() : null;
    final vulkanContext = opengl || _metal ? null : _getVulkanContext();

    // Wakes can arrive before the renderer exists; their work waits for the
    // next wake then.
    MapRenderer? renderer;
    final runtime = runtimeCreate(
      RuntimeOptions(eventWake: Wake(callback: () => renderer?._drainEvents())),
    );
    final map = await runtime.createMap(MapOptions(initialExtent: extent));
    if (styleUrl != null) await map.setStyleUrl(styleUrl);

    final frameWake = Wake(callback: () => renderer?._drainFrames());
    final options = RenderSessionAttachOptions(
      driver: RenderDriverKind.coreWorker,
      frameWake: frameWake,
    );
    final (width, height) = _physicalSize(extent);

    if (Platform.isAndroid) {
      final texture = AndroidPlugin.createSurfaceTexture(
        width,
        height,
        opengl: opengl,
        onSurfaceChanged: (surface, oldSurface) {
          if (renderer case final renderer?) {
            unawaited(renderer._onSurfaceChanged(surface, oldSurface));
          } else if (oldSurface != 0) {
            // Nothing presents to the old surface yet.
            AndroidPlugin.releaseSurface(oldSurface, opengl: opengl);
          }
        },
        onSurfaceCleanup: () => renderer?._surfaceAvailable = false,
      );
      final RenderSessionAttachment attachment;
      _RenderThread? renderThread;
      if (eglContext != null) {
        // Attachment and every frame are driver work, so the thread starts
        // before the attachment completes.
        final thread = renderThread = _RenderThread();
        attachment = map.attachOpenglSurface(
          OpenglSurfaceDescriptor(
            extent: extent,
            context: eglContext,
            surface: NativePointer(texture.surface),
          ),
          RenderSessionAttachOptions(
            frameWake: frameWake,
            driverWorkWake: Wake(callback: thread.wake),
          ),
        );
        thread.start(attachment.session);
      } else {
        attachment = map.attachVulkanSurface(
          VulkanSurfaceDescriptor(
            extent: extent,
            context: vulkanContext!,
            surface: BigInt.from(texture.surface).toUnsigned(64),
          ),
          options,
        );
      }
      return _finishCreate(
        renderer = MapRenderer._(
          texture.textureId,
          runtime,
          map,
          attachment.session,
          extent,
          _Target.surface,
          surfaceTexture: texture,
          renderThread: renderThread,
        ),
        attachment,
        onEvent,
        onFrameShown,
      );
    }

    if (_metal) {
      final texture = DarwinPlugin.createGpuTexture(
        width,
        height,
        _gpuSlotCount,
      );
      final RenderSessionAttachment attachment;
      try {
        attachment = map.attachMetalBorrowedTexture(
          _metalDescriptor(extent, texture.slots),
          options,
        );
      } on Object {
        DarwinPlugin.disposeTexture(texture.textureId);
        rethrow;
      }
      return _finishCreate(
        renderer = MapRenderer._(
          texture.textureId,
          runtime,
          map,
          attachment.session,
          extent,
          _Target.metalTexture,
        ),
        attachment,
        onEvent,
        onFrameShown,
      );
    }

    final (gpu, unavailable) = WindowsPlugin.createGpuTexture(
      width,
      height,
      _gpuSlotCount,
    );

    final int textureId;
    final RenderSessionAttachment attachment;
    var format = 0;
    if (gpu != null) {
      textureId = gpu.textureId;
      format = gpu.format;
      attachment = map.attachVulkanBorrowedTexture(
        _borrowedDescriptor(vulkanContext!, extent, format, gpu.slots),
        options,
      );
    } else {
      debugPrint(
        'maplibre_native: zero-copy textures are unavailable '
        '($unavailable), falling back to CPU readback.',
      );
      textureId = WindowsPlugin.createPixelTexture();
      attachment = map.attachVulkanOwnedTexture(
        VulkanOwnedTextureDescriptor(extent: extent, context: vulkanContext!),
        options,
      );
    }

    return _finishCreate(
      renderer = MapRenderer._(
        textureId,
        runtime,
        map,
        attachment.session,
        extent,
        format != 0 ? _Target.gpuTexture : _Target.pixelBuffer,
        format: format,
      ),
      attachment,
      onEvent,
      onFrameShown,
    );
  }

  static Future<MapRenderer> _finishCreate(
    MapRenderer renderer,
    RenderSessionAttachment attachment,
    void Function(RuntimeEvent event)? onEvent,
    void Function(MapProjectionHandle projection, RenderFrameResult frame)?
    onFrameShown,
  ) async {
    renderer
      ..onEvent = onEvent
      ..onFrameShown = onFrameShown;
    await attachment.completed;
    renderer
      .._drainEvents()
      .._demandFrame();
    return renderer;
  }

  static VulkanBorrowedTextureDescriptor _borrowedDescriptor(
    VulkanContextDescriptor context,
    LogicalExtent extent,
    int format,
    List<VulkanBorrowedTexture> slots,
  ) {
    final (width, height) = _physicalSize(extent);
    return VulkanBorrowedTextureDescriptor(
      extent: extent,
      physicalWidth: width,
      physicalHeight: height,
      context: context,
      textures: slots,
      format: format,
      finalLayout: _vkImageLayoutGeneral,
    );
  }

  static MetalBorrowedTextureDescriptor _metalDescriptor(
    LogicalExtent extent,
    List<MetalBorrowedTexture> slots,
  ) {
    final (width, height) = _physicalSize(extent);
    return MetalBorrowedTextureDescriptor(
      extent: extent,
      physicalWidth: width,
      physicalHeight: height,
      textures: slots,
    );
  }

  static (int, int) _physicalSize(LogicalExtent extent) => (
    (extent.width * extent.scaleFactor).round().clamp(1, 16384),
    (extent.height * extent.scaleFactor).round().clamp(1, 16384),
  );

  /// Runs [action] after every earlier queued GPU action.
  Future<T> _onGpuQueue<T>(Future<T> Function() action) {
    final result = _gpuQueue.then((_) => action());
    _gpuQueue = result.then<void>((_) {}, onError: (Object _) {});
    return result;
  }

  /// Resizes the map and its texture. Resizes that arrive while one is in
  /// flight collapse into the latest.
  void resize(LogicalExtent extent) {
    if (extent == (_pendingExtent ?? _extent)) return;
    _pendingExtent = extent;
    if (_resizing) return;
    unawaited(_applyResizes());
  }

  Future<void> _applyResizes() async {
    _resizing = true;
    try {
      while (_pendingExtent != null && !_disposed) {
        final extent = _pendingExtent!;
        _pendingExtent = null;
        _extent = extent;
        switch (_target) {
          case _Target.gpuTexture:
            await _onGpuQueue(() => _replaceGpuTarget(extent));
          case _Target.metalTexture:
            await _onGpuQueue(() => _replaceMetalTarget(extent));
          case _Target.surface:
            await _onGpuQueue(() => _resizeSurface(extent));
          case _Target.pixelBuffer:
            await _session.resize(extent);
        }
      }
    } on Object catch (error) {
      debugPrint('maplibre_native: resize failed: $error');
    } finally {
      _resizing = false;
    }
  }

  /// Gives the session a ring of the new size. A caller-owned target is
  /// sized by replacing it rather than through a session resize.
  Future<void> _replaceGpuTarget(LogicalExtent extent) async {
    if (_disposed) return;
    final (width, height) = _physicalSize(extent);
    final slots = WindowsPlugin.resizeGpuTexture(
      textureId,
      width,
      height,
      _gpuSlotCount,
    );
    await _session.setVulkanBorrowedTextureTarget(
      _borrowedDescriptor(_getVulkanContext(), extent, _format, slots),
    );
    WindowsPlugin.releaseRetiredSlots(textureId);
  }

  /// Gives the session a Metal ring of the new size, as [_replaceGpuTarget]
  /// does on Windows.
  Future<void> _replaceMetalTarget(LogicalExtent extent) async {
    if (_disposed) return;
    final (width, height) = _physicalSize(extent);
    final slots = DarwinPlugin.resizeGpuTexture(
      textureId,
      width,
      height,
      _gpuSlotCount,
    );
    await _session.setMetalBorrowedTextureTarget(
      _metalDescriptor(extent, slots),
    );
    DarwinPlugin.releaseRetiredSlots(textureId);
  }

  /// Sizes the SurfaceProducer's buffers and the session. Flutter may hand
  /// out a new Surface for the new size, which the session then moves to.
  Future<void> _resizeSurface(LogicalExtent extent) async {
    if (_disposed) return;
    final (width, height) = _physicalSize(extent);
    final (surface, oldSurface) = AndroidPlugin.resizeSurfaceTexture(
      textureId,
      width,
      height,
    );
    if (oldSurface != null) {
      await _replaceSurface(surface, oldSurface, extent: extent);
    } else {
      await _session.resize(extent);
    }
  }

  /// The Surface is available again, e.g. when the app returned from the
  /// background: rendering moves to [surface] when Flutter recreated it
  /// ([oldSurface] is 0 when it did not) and resumes.
  Future<void> _onSurfaceChanged(int surface, int oldSurface) async {
    if (_disposed) {
      // Nothing presents to the old surface anymore.
      if (oldSurface != 0) {
        AndroidPlugin.releaseSurface(oldSurface, opengl: _opengl);
      }
      return;
    }
    await _onGpuQueue(() async {
      if (oldSurface != 0) await _replaceSurface(surface, oldSurface);
      _surfaceAvailable = true;
      _demandFrame();
    });
  }

  /// Moves the session to [surface] and releases [oldSurface] once it no
  /// longer presents there.
  Future<void> _replaceSurface(
    int surface,
    int oldSurface, {
    LogicalExtent? extent,
  }) async {
    if (_disposed) {
      AndroidPlugin.releaseSurface(oldSurface, opengl: _opengl);
      return;
    }
    if (_opengl) {
      // The old EGLSurface stays current on the render thread until the next
      // frame, but EGL defers destroying it until then.
      await _session.setOpenglSurfaceTarget(
        OpenglSurfaceDescriptor(
          extent: extent ?? _extent,
          context: _getEglContext(),
          surface: NativePointer(surface),
        ),
      );
    } else {
      await _session.setVulkanSurfaceTarget(
        VulkanSurfaceDescriptor(
          extent: extent ?? _extent,
          context: _getVulkanContext(),
          surface: BigInt.from(surface).toUnsigned(64),
        ),
      );
    }
    AndroidPlugin.releaseSurface(oldSurface, opengl: _opengl);
  }

  /// Arms a demand that renders the map's next update, and waits for one
  /// when there is none yet.
  void _demandFrame() {
    if (_disposed || _pendingToken != null || !_surfaceAvailable) return;
    final token = BigInt.from(_nextToken++);
    _pendingToken = token;
    _session.requestFrame(
      FrameDemand(
        flags: _target == _Target.surface
            ? FrameDemandFlag.ifNeeded |
                  FrameDemandFlag.waitForUpdate |
                  FrameDemandFlag.present
            : FrameDemandFlag.ifNeeded | FrameDemandFlag.waitForUpdate,
        token: token,
        coalescingBoundary: BigInt.zero,
        timeoutNs: BigInt.zero,
      ),
    );
  }

  void _drainFrames() {
    if (_disposed) return;
    final batch = _session.drainFrameResults();
    if (batch == null) return;
    RenderFrameResult? result;
    try {
      for (final candidate in batch.getValue().results) {
        if (candidate.token == _pendingToken) result = candidate;
      }
    } finally {
      batch.close();
    }
    if (result == null) return;
    _pendingToken = null;
    if (result.disposition == RenderResult.rendered) {
      // Taken before the next demand, so it is this frame's transform.
      final projection = _renderedProjection();
      final frame = result;
      switch (_target) {
        case _Target.gpuTexture || _Target.metalTexture:
          unawaited(_onGpuQueue(() => _present(projection, frame)));
        case _Target.pixelBuffer:
          unawaited(_readBack(projection, frame));
        case _Target.surface:
          // The session presented the frame to the Surface.
          _showFrame(projection, frame);
          _demandFrame();
      }
    } else if (result.disposition == RenderResult.targetNotReady) {
      Timer(const Duration(milliseconds: 16), _demandFrame);
    } else {
      _demandFrame();
    }
  }

  /// Hands the latest frame to Flutter. The frame's GPU writes completed
  /// before it became acquirable, and the plugin copies it on the GPU before
  /// the call returns, so the frame is released right after.
  Future<void> _present(
    MapProjectionHandle? projection,
    RenderFrameResult result,
  ) async {
    var shown = false;
    try {
      if (_disposed) return;
      final frame = _session.acquireFrame();
      if (frame == null) return;
      try {
        if (_target == _Target.metalTexture) {
          final slot = frame.getMetalTexture().withView((view) => view.slot);
          DarwinPlugin.presentGpuTexture(textureId, slot);
        } else {
          final slot = frame.getVulkanTexture().withView((view) => view.slot);
          WindowsPlugin.presentGpuTexture(textureId, slot);
        }
        _showFrame(projection, result);
        shown = true;
      } finally {
        frame.release(gpuSyncDefault());
      }
    } on Object catch (error) {
      debugPrint('maplibre_native: present failed: $error');
    } finally {
      if (!shown) projection?.close();
      _demandFrame();
    }
  }

  Future<void> _readBack(
    MapProjectionHandle? projection,
    RenderFrameResult result,
  ) async {
    var shown = false;
    try {
      final image = await _session.readTexture();
      if (_disposed) return;
      WindowsPlugin.updatePixelTexture(
        textureId,
        width: image.info.width,
        height: image.info.height,
        stride: image.info.stride,
        pixels: image.data,
      );
      _showFrame(projection, result);
      shown = true;
    } on MaplibreException catch (error) {
      debugPrint('maplibre_native: readback failed: $error');
    } finally {
      if (!shown) projection?.close();
      _demandFrame();
    }
  }

  /// The transform of the frame the session drew last, or null when it has
  /// none, as right after a resize.
  MapProjectionHandle? _renderedProjection() {
    if (onFrameShown == null) return null;
    try {
      return _session.createProjection();
    } on MaplibreException {
      return null;
    }
  }

  /// Hands [projection] to [onFrameShown] once its frame reached Flutter.
  void _showFrame(MapProjectionHandle? projection, RenderFrameResult frame) {
    if (projection == null) return;
    final onFrameShown = this.onFrameShown;
    if (_disposed || onFrameShown == null) {
      projection.close();
      return;
    }
    onFrameShown(projection, frame);
  }

  void _drainEvents() {
    if (_disposed) return;
    final batch = _runtime.drainEvents();
    if (batch == null) return;
    try {
      for (final event in batch.getValue().events) {
        if (event.type == RuntimeEventType.mapLoadingFailed ||
            event.type == RuntimeEventType.mapRenderError) {
          debugPrint('maplibre_native: ${event.message}');
        }
        onEvent?.call(event);
      }
    } finally {
      batch.close();
    }
  }

  /// Releases the session, map, runtime, and texture.
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    // A frame in presentation is released before the session goes.
    await _gpuQueue;
    var quarantined = false;
    if (_renderThread case final thread?) {
      // Only the render thread may destroy the session's GL objects, which
      // abandon would keep until process exit, so the session detaches there
      // first.
      var detached = false;
      try {
        await _session.detach();
        detached = true;
      } on MaplibreException catch (error) {
        debugPrint('maplibre_native: detach failed: $error');
      }
      thread.stop();
      if (!detached) _abandon();
    } else {
      quarantined = _abandon();
    }
    _session.close();
    await _map.close();
    await _runtime.close();
    if (_surfaceTexture case final texture?) {
      // A swapchain kept until process exit needs its VkSurfaceKHR as long.
      AndroidPlugin.disposeTexture(texture, keepSurface: quarantined);
    } else if (_target == _Target.metalTexture) {
      // Abandon destroyed the session's Metal objects, and the ring is the
      // plugin's.
      DarwinPlugin.disposeTexture(textureId);
    } else {
      WindowsPlugin.disposeTexture(textureId);
    }
  }

  /// Ends the session's work. Returns whether it kept graphics objects that
  /// need their parents until process exit.
  bool _abandon() {
    try {
      return _session.abandon().quarantinedResourceCount > 0;
    } on MaplibreException {
      // A session that already let go of its target has nothing to abandon.
      return false;
    }
  }
}
