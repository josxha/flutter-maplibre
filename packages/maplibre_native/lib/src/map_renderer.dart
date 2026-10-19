import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:maplibre_native/src/vulkan_context.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

const _channel = MethodChannel('maplibre_native');

/// Renders one MapLibre map into a Flutter texture.
///
/// The map renders on its session's core worker into a session-owned Vulkan
/// texture. Each rendered frame is read back as RGBA8 and copied into a
/// pixel buffer texture that the Windows plugin registered.
final class MapRenderer {
  MapRenderer._(
    this.textureId,
    this._runtime,
    this._map,
    this._session,
    this._extent,
  );

  /// The Flutter texture id to show in a `Texture` widget.
  final int textureId;

  final RuntimeHandle _runtime;
  final MapHandle _map;
  final RenderSessionHandle _session;

  var _nextToken = 1;
  BigInt? _pendingToken;
  var _readingBack = false;
  var _disposed = false;
  LogicalExtent _extent;
  LogicalExtent? _pendingExtent;
  var _resizing = false;

  /// The map, for camera, style, and projection calls.
  MapHandle get map => _map;

  /// The current logical extent of the map.
  LogicalExtent get extent => _pendingExtent ?? _extent;

  /// Receives every runtime event the map queues.
  void Function(RuntimeEvent event)? onEvent;

  /// Creates a renderer of [extent]. When [styleUrl] is given, the map loads
  /// it before the first frame.
  static Future<MapRenderer> create({
    required LogicalExtent extent,
    String? styleUrl,
    void Function(RuntimeEvent event)? onEvent,
  }) async {
    final textureId = (await _channel.invokeMethod<int>('createTexture'))!;

    // Wakes can arrive before the renderer exists; their work waits for the
    // next wake then.
    MapRenderer? renderer;
    final runtime = runtimeCreate(
      RuntimeOptions(eventWake: Wake(callback: () => renderer?._drainEvents())),
    );
    final map = await runtime.createMap(MapOptions(initialExtent: extent));
    if (styleUrl != null) await map.setStyleUrl(styleUrl);

    final attachment = map.attachVulkanOwnedTexture(
      VulkanOwnedTextureDescriptor(
        extent: extent,
        context: VulkanContext.shared.descriptor,
      ),
      RenderSessionAttachOptions(
        driver: RenderDriverKind.coreWorker,
        frameWake: Wake(callback: () => renderer?._drainFrames()),
      ),
    );
    final created = renderer = MapRenderer._(
      textureId,
      runtime,
      map,
      attachment.session,
      extent,
    )..onEvent = onEvent;
    await attachment.completed;
    created
      .._drainEvents()
      .._demandFrame();
    return created;
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
        await _session.resize(extent);
      }
    } on MaplibreException catch (error) {
      debugPrint('maplibre_native: resize failed: $error');
    } finally {
      _resizing = false;
    }
  }

  /// Arms a demand that renders the map's next update, and waits for one
  /// when there is none yet.
  void _demandFrame() {
    if (_disposed || _pendingToken != null) return;
    final token = BigInt.from(_nextToken++);
    _pendingToken = token;
    _session.requestFrame(
      FrameDemand(
        flags: FrameDemandFlag.ifNeeded | FrameDemandFlag.waitForUpdate,
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
      unawaited(_readBack());
    } else if (result.disposition == RenderResult.targetNotReady) {
      Timer(const Duration(milliseconds: 16), _demandFrame);
    } else {
      _demandFrame();
    }
  }

  Future<void> _readBack() async {
    if (_readingBack) return;
    _readingBack = true;
    try {
      final image = await _session.readTexture();
      if (_disposed) return;
      await _channel.invokeMethod<void>('updateTexture', {
        'textureId': textureId,
        'width': image.info.width,
        'height': image.info.height,
        'stride': image.info.stride,
        'pixels': image.data,
      });
    } on MaplibreException catch (error) {
      debugPrint('maplibre_native: readback failed: $error');
    } finally {
      _readingBack = false;
      _demandFrame();
    }
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
    try {
      _session.abandon();
    } on MaplibreException {
      // A session that already let go of its target has nothing to abandon.
    }
    _session.close();
    await _map.close();
    await _runtime.close();
    await _channel.invokeMethod<void>('disposeTexture', {
      'textureId': textureId,
    });
  }
}
