import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

const _channel = MethodChannel('maplibre_native');

/// Ring depth of a zero-copy texture: one slot Flutter shows, one MapLibre
/// renders into, and one spare.
const _gpuSlotCount = 3;

/// VK_IMAGE_LAYOUT_GENERAL. The session leaves each frame in the general
/// layout that D3D11 reads, and with the default initial layout of
/// VK_IMAGE_LAYOUT_UNDEFINED it takes a released slot back without a layout
/// transition.
const _vkImageLayoutGeneral = 1;

VulkanContextDescriptor? _vulkanContext;

/// The Vulkan device that the Windows plugin created on Flutter's GPU.
Future<VulkanContextDescriptor> _getVulkanContext() async {
  if (_vulkanContext case final context?) return context;
  final values = (await _channel.invokeMapMethod<String, int>(
    'vulkanContext',
  ))!;
  NativePointer pointer(String key) => NativePointer(values[key]!);
  return _vulkanContext = VulkanContextDescriptor(
    instance: pointer('instance'),
    physicalDevice: pointer('physicalDevice'),
    device: pointer('device'),
    graphicsQueue: pointer('queue'),
    graphicsQueueFamilyIndex: values['queueFamilyIndex']!,
    getInstanceProcAddr: pointer('getInstanceProcAddr'),
    getDeviceProcAddr: pointer('getDeviceProcAddr'),
  );
}

/// Renders one MapLibre map into a Flutter texture.
///
/// The map renders on its session's core worker through Vulkan. When the GPU
/// shares textures between Vulkan and D3D11, the session renders into a ring
/// of shared textures that Flutter composites without a CPU copy. Otherwise
/// each frame is read back as RGBA8 into a pixel buffer texture.
final class MapRenderer {
  MapRenderer._(
    this.textureId,
    this._runtime,
    this._map,
    this._session,
    this._extent,
    this._format, {
    required this.isZeroCopy,
  });

  /// The Flutter texture id to show in a `Texture` widget.
  final int textureId;

  /// Whether frames reach Flutter without a CPU copy.
  final bool isZeroCopy;

  final RuntimeHandle _runtime;
  final MapHandle _map;
  final RenderSessionHandle _session;
  final int _format;

  var _nextToken = 1;
  BigInt? _pendingToken;
  var _disposed = false;
  LogicalExtent _extent;
  LogicalExtent? _pendingExtent;
  var _resizing = false;

  /// Serializes frame presentation and target replacement, because a frame
  /// must not be acquired while the session replaces its target.
  Future<void> _gpuQueue = Future.value();

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
    final context = await _getVulkanContext();

    // Wakes can arrive before the renderer exists; their work waits for the
    // next wake then.
    MapRenderer? renderer;
    final runtime = runtimeCreate(
      RuntimeOptions(eventWake: Wake(callback: () => renderer?._drainEvents())),
    );
    final map = await runtime.createMap(MapOptions(initialExtent: extent));
    if (styleUrl != null) await map.setStyleUrl(styleUrl);

    final options = RenderSessionAttachOptions(
      driver: RenderDriverKind.coreWorker,
      frameWake: Wake(callback: () => renderer?._drainFrames()),
    );
    final (width, height) = _physicalSize(extent);
    final gpu = (await _channel.invokeMapMethod<String, Object?>(
      'createGpuTexture',
      {'width': width, 'height': height, 'slotCount': _gpuSlotCount},
    ))!;

    final int textureId;
    final RenderSessionAttachment attachment;
    var format = 0;
    if (gpu['textureId'] case final int id) {
      textureId = id;
      format = gpu['format']! as int;
      attachment = map.attachVulkanBorrowedTexture(
        _borrowedDescriptor(
          context,
          extent,
          format,
          gpu['slots']! as List<Object?>,
        ),
        options,
      );
    } else {
      debugPrint(
        'maplibre_native: zero-copy textures are unavailable '
        '(${gpu['error']}), falling back to CPU readback.',
      );
      textureId = (await _channel.invokeMethod<int>('createTexture'))!;
      attachment = map.attachVulkanOwnedTexture(
        VulkanOwnedTextureDescriptor(extent: extent, context: context),
        options,
      );
    }

    final created = renderer = MapRenderer._(
      textureId,
      runtime,
      map,
      attachment.session,
      extent,
      format,
      isZeroCopy: format != 0,
    )..onEvent = onEvent;
    await attachment.completed;
    created
      .._drainEvents()
      .._demandFrame();
    return created;
  }

  static VulkanBorrowedTextureDescriptor _borrowedDescriptor(
    VulkanContextDescriptor context,
    LogicalExtent extent,
    int format,
    List<Object?> slots,
  ) {
    final (width, height) = _physicalSize(extent);
    return VulkanBorrowedTextureDescriptor(
      extent: extent,
      physicalWidth: width,
      physicalHeight: height,
      context: context,
      textures: [
        for (final slot in slots.cast<List<Object?>>())
          VulkanBorrowedTexture(
            image: BigInt.from(slot[0]! as int).toUnsigned(64),
            imageView: BigInt.from(slot[1]! as int).toUnsigned(64),
          ),
      ],
      format: format,
      finalLayout: _vkImageLayoutGeneral,
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
        if (isZeroCopy) {
          await _onGpuQueue(() => _replaceGpuTarget(extent));
        } else {
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
    final slots = (await _channel.invokeListMethod<Object?>(
      'resizeGpuTexture',
      {'textureId': textureId, 'width': width, 'height': height},
    ))!;
    final context = await _getVulkanContext();
    await _session.setVulkanBorrowedTextureTarget(
      _borrowedDescriptor(context, extent, _format, slots),
    );
    await _channel.invokeMethod<void>('releaseRetiredSlots', {
      'textureId': textureId,
    });
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
      unawaited(isZeroCopy ? _onGpuQueue(_present) : _readBack());
    } else if (result.disposition == RenderResult.targetNotReady) {
      Timer(const Duration(milliseconds: 16), _demandFrame);
    } else {
      _demandFrame();
    }
  }

  /// Hands the latest frame to Flutter. The frame's GPU writes completed
  /// before it became acquirable, and the plugin copies it on the GPU before
  /// the call returns, so the frame is released right after.
  Future<void> _present() async {
    try {
      if (_disposed) return;
      final frame = _session.acquireFrame();
      if (frame == null) return;
      try {
        final slot = frame.getVulkanTexture().withView((view) => view.slot);
        await _channel.invokeMethod<void>('presentGpuTexture', {
          'textureId': textureId,
          'slot': slot,
        });
      } finally {
        frame.release(gpuSyncDefault());
      }
    } on Object catch (error) {
      debugPrint('maplibre_native: present failed: $error');
    } finally {
      _demandFrame();
    }
  }

  Future<void> _readBack() async {
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
    // A frame in presentation is released before the session goes.
    await _gpuQueue;
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
