import 'dart:async';

import 'package:maplibre_native/src/darwin/darwin_plugin.dart';
import 'package:maplibre_native/src/frame_target.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

/// How often a target checks whether Flutter let go of the frames that it
/// replaced, while there are any.
const _recycleInterval = Duration(milliseconds: 4);

/// Creates the target of an iOS or macOS map, which renders on its session's
/// core worker through Metal into a ring of IOSurface-backed BGRA8 textures.
/// Flutter samples the slot of the frame on screen directly, without a copy.
FrameTarget createDarwinTarget(LogicalExtent extent) {
  final (width, height) = physicalSize(extent);
  final texture = DarwinPlugin.createGpuTexture(width, height, gpuSlotCount);
  return _MetalTextureTarget(texture.textureId, texture.slots);
}

/// Keeps the frame on screen acquired while Flutter samples its slot, so
/// MapLibre renders into the other slots, and releases each frame it
/// replaced once Flutter no longer samples that slot.
final class _MetalTextureTarget
    extends BorrowedRingTarget<MetalBorrowedTexture> {
  _MetalTextureTarget(super.textureId, super.slots);

  /// The acquired frames by slot, oldest first. The last one is on screen.
  final _held = <(int, AcquiredFrameHandle)>[];

  Timer? _recycler;

  MetalBorrowedTextureDescriptor _descriptor(LogicalExtent extent) {
    final (width, height) = physicalSize(extent);
    return MetalBorrowedTextureDescriptor(
      extent: extent,
      physicalWidth: width,
      physicalHeight: height,
      textures: slots,
    );
  }

  @override
  RenderSessionAttachment attachRing(
    MapHandle map,
    LogicalExtent extent,
    RenderSessionAttachOptions options,
  ) => map.attachMetalBorrowedTexture(_descriptor(extent), options);

  @override
  List<MetalBorrowedTexture> resizeRing(int width, int height) =>
      DarwinPlugin.resizeGpuTexture(textureId, width, height, gpuSlotCount);

  @override
  Future<void> setRing(RenderSessionHandle session, LogicalExtent extent) =>
      session.setMetalBorrowedTextureTarget(_descriptor(extent));

  /// The session renders into the new ring once it moved there, so the
  /// frames of the old one go. Flutter keeps the buffer it shows.
  @override
  Future<void> resize(RenderSessionHandle session, LogicalExtent extent) async {
    await super.resize(session, extent);
    _releaseHeld(all: true);
  }

  @override
  void releaseRetiredRings() => DarwinPlugin.releaseRetiredSlots(textureId);

  @override
  int slotOf(AcquiredFrameHandle frame) =>
      frame.getMetalTexture().withView((view) => view.slot);

  @override
  void presentSlot(int slot) => DarwinPlugin.presentGpuTexture(textureId, slot);

  /// The frame's GPU writes completed before it became acquirable, so
  /// Flutter samples its slot once [presentSlot] returns. The frame stays
  /// acquired until Flutter no longer samples the slot.
  @override
  Future<bool> present(RenderSessionHandle session) async {
    _releaseHeld();
    final frame = session.acquireFrame();
    if (frame == null) return false;
    final int slot;
    try {
      slot = slotOf(frame);
      presentSlot(slot);
    } on Object {
      frame.release(gpuSyncDefault());
      rethrow;
    }
    _held.add((slot, frame));
    _scheduleRecycle();
    return true;
  }

  /// Releases the replaced frames whose slots Flutter no longer samples, or
  /// every held frame when [all] is set.
  void _releaseHeld({bool all = false}) {
    final keep = <(int, AcquiredFrameHandle)>[];
    for (final (index, held) in _held.indexed) {
      final (slot, frame) = held;
      final onScreen = index == _held.length - 1;
      if (all || (!onScreen && !DarwinPlugin.slotInUse(textureId, slot))) {
        frame.release(gpuSyncDefault());
      } else {
        keep.add(held);
      }
    }
    _held
      ..clear()
      ..addAll(keep);
  }

  /// Checks for released slots while frames that are no longer on screen
  /// are held, as MapLibre waits for a free slot to render the next frame.
  void _scheduleRecycle() {
    if (_recycler != null || _held.length < 2) return;
    _recycler = Timer.periodic(_recycleInterval, (timer) {
      if (host?.disposed ?? true) {
        timer.cancel();
        _recycler = null;
        return;
      }
      host!.onGpuQueue(() async => _releaseHeld()).ignore();
      if (_held.length < 2) {
        timer.cancel();
        _recycler = null;
      }
    });
  }

  @override
  Future<bool> endSession(RenderSessionHandle session) async {
    _recycler?.cancel();
    _recycler = null;
    _releaseHeld(all: true);
    return super.endSession(session);
  }

  @override
  void disposeTexture() => DarwinPlugin.disposeTexture(textureId);
}
