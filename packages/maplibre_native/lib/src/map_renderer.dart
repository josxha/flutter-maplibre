import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:maplibre_native/src/android/android_target.dart';
import 'package:maplibre_native/src/darwin/darwin_target.dart';
import 'package:maplibre_native/src/database.dart';
import 'package:maplibre_native/src/desktop/desktop_target.dart';
import 'package:maplibre_native/src/frame_target.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

/// The render backends the current platform's plugin integrates, by name.
/// The C library must carry one of them.
Map<String, RenderBackendFlag> _pluginBackends() {
  if (Platform.isAndroid) {
    return {
      'OpenGL ES': RenderBackendFlag.openGl,
      'Vulkan': RenderBackendFlag.vulkan,
    };
  }
  if (Platform.isIOS || Platform.isMacOS) {
    return {'Metal': RenderBackendFlag.metal};
  }
  return {'Vulkan': RenderBackendFlag.vulkan};
}

/// Creates the frame target of the current platform.
FrameTarget _createTarget(LogicalExtent extent) {
  final mask = supportedRenderBackendMask();
  final backends = _pluginBackends();
  if (!backends.values.any(mask.contains)) {
    throw UnsupportedError(
      'maplibre_native on ${Platform.operatingSystem} renders through '
      '${backends.keys.join(' or ')}, but the MapLibre Native C library was '
      'built for another backend. Remove '
      'hooks.user_defines.maplibre_native_ffi.backend for this build.',
    );
  }
  if (Platform.isAndroid) return createAndroidTarget(extent);
  if (Platform.isIOS || Platform.isMacOS) return createDarwinTarget(extent);
  return createDesktopTarget(extent);
}

/// Renders one MapLibre map into a Flutter texture.
///
/// The [FrameTarget] of each platform decides how frames reach Flutter: see
/// `createDesktopTarget` (Windows and Linux), `createAndroidTarget`, and
/// `createDarwinTarget` (iOS and macOS). The renderer drives the session the
/// same way on every platform: it demands a frame, hands each rendered one to
/// its target, and demands the next.
final class MapRenderer implements FrameTargetHost {
  MapRenderer._(
    this._runtime,
    this._map,
    this._session,
    this._target,
    this._extent,
  ) {
    _target.host = this;
  }

  final RuntimeHandle _runtime;
  final MapHandle _map;
  final RenderSessionHandle _session;
  final FrameTarget _target;

  /// The Flutter texture id to show in a `Texture` widget.
  int get textureId => _target.textureId;

  /// Whether frames reach Flutter without a CPU copy.
  bool get isZeroCopy => _target.isZeroCopy;

  var _nextToken = 1;
  int? _pendingToken;
  var _disposed = false;
  LogicalExtent _extent;
  LogicalExtent? _pendingExtent;
  var _resizing = false;

  /// Serializes frame presentation and target changes, because a frame must
  /// not be acquired while the session replaces its target.
  Future<void> _gpuQueue = Future.value();

  /// The map, for camera, style, and projection calls.
  MapHandle get map => _map;

  /// Queries the features rendered at [geometry], in logical pixels. The
  /// C API answers asynchronously from the session's latest frame.
  Future<List<RenderedFeature>> queryRenderedFeatures(
    RenderedQueryGeometry geometry, {
    List<String>? layerIds,
  }) => _session.queryRenderedFeatures(
    geometry,
    options: layerIds == null
        ? null
        : RenderedFeatureQueryOptions(layerIds: layerIds),
  );

  @override
  bool get disposed => _disposed;

  /// The current logical extent of the map.
  @override
  LogicalExtent get extent => _pendingExtent ?? _extent;

  /// Receives every runtime event the map queues.
  void Function(RuntimeEvent event)? onEvent;

  /// Receives the projection and render result of each frame once
  /// Flutter can show it, so overlays can follow what is on screen rather than
  /// the latest camera, which the map image reaches a frame or two later. The
  /// projection converts for the view the frame drew, and the receiver owns
  /// it.
  ///
  /// On Windows, Linux, iOS, and macOS Flutter shows the frame in its next
  /// frame. On Android the frame went to the Surface, and Flutter takes the
  /// newest image there, which is nearly always the same one.
  void Function(MapProjectionHandle projection, RenderFrameResult frame)?
  onFrameShown;

  /// Creates a renderer of [extent] whose map queues the events of
  /// [eventMask]. [setUp] submits the map's first commands, such as its
  /// camera and style, which the map runs once it is created and before the
  /// session renders its first frame.
  static Future<MapRenderer> create({
    required LogicalExtent extent,
    RuntimeEventFlag? eventMask,
    Future<void> Function(MapHandle map)? setUp,
    void Function(RuntimeEvent event)? onEvent,
    void Function(MapProjectionHandle projection, RenderFrameResult frame)?
    onFrameShown,
  }) async {
    // Also initializes the platform's graphics context, which Android needs
    // before the C library's first use.
    final target = _createTarget(extent);

    // Wakes can arrive before the renderer exists; their work waits for the
    // next wake then. Events are delivered once, so the ones that arrive
    // before the renderer starts are kept until then.
    MapRenderer? renderer;
    final early = <RuntimeEvent>[];
    RuntimeHandle? runtime;
    MapHandle? map;
    final RenderSessionHandle session;
    try {
      runtime = await createRuntime();
      await runtime.setEventHandler(
        (events) => renderer?._started ?? false
            ? renderer!._onEvents(events)
            : early.addAll(events),
      );
      final created = runtime.createMap(
        MapOptions(initialExtent: extent, eventMask: eventMask),
      );
      map = created.map;
      // Commands run once the map is created, so they need not wait for it.
      await Future.wait([created.ready, ?setUp?.call(map)]);
      final attachment = target.attach(
        map,
        extent,
        _FrameWake(() => renderer?._drainFrames()).wake,
      );
      session = attachment.session;
      try {
        await attachment.ready;
      } on Object {
        await target.endSession(session);
        rethrow;
      }
    } on Object {
      await map?.close();
      await runtime?.close();
      target.dispose();
      rethrow;
    }

    return renderer = MapRenderer._(runtime, map, session, target, extent)
      ..onEvent = onEvent
      ..onFrameShown = onFrameShown
      .._early = early
      ..demandFrame();
  }

  var _started = false;
  List<RuntimeEvent> _early = const [];

  /// Delivers the events that arrived before the renderer existed to
  /// [onEvent], and from then on every event as it arrives.
  void start() {
    if (_started) return;
    _started = true;
    final early = _early;
    _early = const [];
    _onEvents(early);
  }

  /// Runs [action] after every earlier queued GPU action.
  @override
  Future<T> onGpuQueue<T>(Future<T> Function() action) {
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
        await onGpuQueue(() async {
          if (!_disposed) await _target.resize(_session, extent);
        });
      }
    } on Object catch (error) {
      debugPrint('maplibre_native: resize failed: $error');
    } finally {
      _resizing = false;
    }
  }

  /// Whether the renderer stops demanding frames. The map, its session and
  /// the texture stay, and the texture keeps the last frame. A demand that is
  /// already armed still renders one more frame. On resume, the next frame
  /// shows the map's latest update.
  bool get paused => _paused;
  var _paused = false;
  set paused(bool paused) {
    if (paused == _paused) return;
    _paused = paused;
    if (!paused) demandFrame();
  }

  /// Arms a demand that renders the map's next update, and waits for one
  /// when there is none yet.
  @override
  void demandFrame() {
    if (_disposed ||
        _paused ||
        _pendingToken != null ||
        !_target.acceptsFrames) {
      return;
    }
    final token = _nextToken++;
    _pendingToken = token;
    _session.requestFrame(
      FrameDemand(flags: _target.demandFlags, token: token),
    );
  }

  void _drainFrames() {
    if (_disposed) return;
    RenderFrameResult? result;
    for (final candidate in _session.drainFrameResults()) {
      if (candidate.token == _pendingToken) result = candidate;
    }
    if (result == null) return;
    _pendingToken = null;
    if (result.disposition == RenderResult.rendered) {
      final frame = result;
      unawaited(onGpuQueue(() => _present(frame)));
    } else if (result.disposition == RenderResult.targetNotReady) {
      Timer(const Duration(milliseconds: 16), demandFrame);
    } else {
      demandFrame();
    }
  }

  /// Hands the latest frame to Flutter through the target, then demands the
  /// next one.
  Future<void> _present(RenderFrameResult result) async {
    try {
      if (_disposed) return;
      if (await _target.present(_session) && !_disposed) _showFrame(result);
    } on Object catch (error) {
      debugPrint('maplibre_native: present failed: $error');
    } finally {
      demandFrame();
    }
  }

  /// Hands [frame] and the projection of the view it drew to [onFrameShown]
  /// once the frame reached Flutter.
  void _showFrame(RenderFrameResult frame) {
    final onFrameShown = this.onFrameShown;
    if (_disposed || onFrameShown == null) return;
    onFrameShown(MapProjectionHandle.create(frame.view), frame);
  }

  void _onEvents(List<RuntimeEvent> events) {
    if (_disposed) return;
    for (final event in events) {
      if (event.type == RuntimeEventType.mapLoadingFailed ||
          event.type == RuntimeEventType.mapRenderError ||
          event.type == RuntimeEventType.mapGlyphsError ||
          event.type == RuntimeEventType.mapSpriteError) {
        debugPrint('maplibre_native: ${event.message}');
      }
      onEvent?.call(event);
    }
  }

  /// Releases the session, map, runtime, and texture.
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    // A frame in presentation is released before the session goes.
    await _gpuQueue;
    await _target.endSession(_session);
    await _map.close();
    await _runtime.close();
    _target.dispose();
  }
}

/// The frame wake of a session, which runs [_onWake] on the isolate.
///
/// The binding roots a session's queued wake only through a field that it
/// never reads, which AOT builds drop, so in profile and release builds the
/// wake is collected and the map stops after a few frames. This wake is held
/// by its own callables instead, which native code calls from any thread and
/// which close once the C library releases the wake.
final class _FrameWake {
  _FrameWake(this._onWake) {
    _callback = NativeCallable<Void Function(Pointer<Void>)>.listener(
      (Pointer<Void> _) => _onWake(),
    )..keepIsolateAlive = false;
    _release = NativeCallable<Void Function(Pointer<Void>)>.listener(
      (Pointer<Void> _) => _close(),
    )..keepIsolateAlive = false;
  }

  final void Function() _onWake;
  late final NativeCallable<Void Function(Pointer<Void>)> _callback;
  late final NativeCallable<Void Function(Pointer<Void>)> _release;

  /// The wake to attach the session with, which consumes it.
  Wake get wake => Wake.native(
    callback: NativePointer(_callback.nativeFunction.address),
    releaseUserData: NativePointer(_release.nativeFunction.address),
  );

  void _close() {
    _callback.close();
    _release.close();
  }
}
