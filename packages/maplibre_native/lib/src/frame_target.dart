import 'dart:async';

import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

/// Ring depth of a zero-copy texture: one slot Flutter shows, one MapLibre
/// renders into, and one spare.
const gpuSlotCount = 3;

/// Releases a frame once Flutter and the plugin are done reading it
/// (`GpuSyncKind.cpuComplete`, the default): the plugin copies a frame before
/// it returns, and Flutter left the slots that the plugin reports free.
const _cpuComplete = GpuSync();

/// How often a target that holds frames checks whether Flutter let go of the
/// frames that it replaced, while there are any.
const _recycleInterval = Duration(milliseconds: 4);

/// The logical size of [extent], without its scale factor, which belongs to
/// the map.
LogicalSize logicalSize(LogicalExtent extent) =>
    LogicalSize(width: extent.width, height: extent.height);

/// The device pixel size of [extent].
(int, int) physicalSize(LogicalExtent extent) => (
  (extent.width * extent.scaleFactor).round().clamp(1, 16384),
  (extent.height * extent.scaleFactor).round().clamp(1, 16384),
);

/// What a [FrameTarget] needs of the renderer that owns it.
abstract interface class FrameTargetHost {
  /// Whether the renderer was disposed.
  bool get disposed;

  /// The extent the map renders at.
  LogicalExtent get extent;

  /// Runs [action] after every earlier frame presentation and target change.
  Future<T> onGpuQueue<T>(Future<T> Function() action);

  /// Asks for the map's next frame.
  void demandFrame();
}

/// How the frames of one map reach Flutter: the Flutter texture, the render
/// target the session draws into, and the plugin calls that hand each frame
/// over. Each platform has its own.
///
/// The renderer calls [present], [resize] and [endSession] on its GPU queue,
/// one at a time.
abstract base class FrameTarget {
  /// The renderer that owns this target, once it exists.
  FrameTargetHost? host;

  /// The Flutter texture id to show in a `Texture` widget.
  int get textureId;

  /// Whether frames reach Flutter without a CPU copy.
  bool get isZeroCopy => true;

  /// The frame demand flags of the session. A demand renders only a newer
  /// map update, and waits for one when there is none yet.
  FrameDemandFlag get demandFlags => FrameDemandFlag.waitForUpdate;

  /// Whether the target takes frames now. A target can stop taking them for
  /// a while, as Android does while the app is in the background.
  bool get acceptsFrames => true;

  /// Attaches a render session of [map] to this target. Frames wake through
  /// [frameWake]. When this throws, the renderer disposes the target.
  RenderSessionHandle attach(
    MapHandle map,
    LogicalExtent extent,
    Wake frameWake,
  );

  /// Sizes the target and the session to [extent].
  Future<void> resize(RenderSessionHandle session, LogicalExtent extent);

  /// Hands the frame the session rendered last to Flutter. Returns false when
  /// there was none to hand over.
  Future<bool> present(RenderSessionHandle session);

  /// Releases the session. A core-worker session detaches from its target
  /// there, off the UI thread, and the returned future completes once no
  /// library thread touches the target's graphics objects anymore.
  Future<void> endSession(RenderSessionHandle session) => session.release();

  /// Releases the texture once the session, map, and runtime are closed.
  void dispose();
}

/// A target whose texture shows a ring of [gpuSlotCount] images that the
/// session renders into, as on Windows, Linux, iOS, and macOS.
///
/// Where the plugin copies each finished frame on the GPU before
/// [presentFrame] returns (Windows), the frame is released right after. Where
/// Flutter samples the frame's image itself (Linux, iOS, macOS;
/// [holdsFrames]), the frame on screen stays acquired, so MapLibre renders
/// into the other images, and each frame it replaced is released once
/// [slotInUse] reports its slot free.
abstract base class RingTarget extends FrameTarget {
  /// Creates a target for the plugin texture [textureId].
  RingTarget(this.textureId);

  @override
  final int textureId;

  /// Whether Flutter samples the presented image itself, so that a frame
  /// stays acquired while its slot is in use.
  bool get holdsFrames;

  /// The acquired frames by slot, oldest first. The last one is on screen.
  final _held = <(int, AcquiredFrameHandle)>[];

  Timer? _recycler;

  /// Hands [frame] to Flutter and returns its slot in the ring.
  int presentFrame(AcquiredFrameHandle frame);

  /// Whether Flutter may still sample [slot]. Only asked when [holdsFrames].
  bool slotInUse(int slot) => false;

  /// Gives the session a ring of images at [extent]. Every frame was
  /// released before.
  Future<void> resizeRing(RenderSessionHandle session, LogicalExtent extent);

  /// Has the plugin unregister the texture.
  void disposeTexture();

  /// Frames are complete on the GPU once acquired, so the plugin can copy or
  /// sample them without waiting.
  RenderSessionAttachOptions attachOptions(Wake frameWake) =>
      RenderSessionAttachOptions(
        driver: RenderDriverKind.coreWorker,
        producerSyncKinds: GpuSyncKindFlag.cpuComplete,
        frameWake: frameWake,
      );

  /// The session resizes only while it has no frame acquired, so the held
  /// frames go first. Flutter keeps showing the old ring's image until a
  /// frame of the new one arrives.
  @override
  Future<void> resize(RenderSessionHandle session, LogicalExtent extent) {
    _releaseHeld(all: true);
    return resizeRing(session, extent);
  }

  /// The frame's GPU writes completed before it became acquirable, so the
  /// plugin can copy or sample it once [presentFrame] returns.
  @override
  Future<bool> present(RenderSessionHandle session) async {
    _releaseHeld();
    final frame = session.acquireFrame();
    if (frame == null) return false;
    final int slot;
    try {
      slot = presentFrame(frame);
    } on Object {
      frame.release(_cpuComplete);
      rethrow;
    }
    if (!holdsFrames) {
      frame.release(_cpuComplete);
      return true;
    }
    _held.add((slot, frame));
    _scheduleRecycle();
    return true;
  }

  /// Releases the replaced frames whose slots Flutter no longer samples, or
  /// every held frame when [all] is set.
  void _releaseHeld({bool all = false}) {
    if (_held.isEmpty) return;
    final keep = <(int, AcquiredFrameHandle)>[];
    for (final (index, held) in _held.indexed) {
      final (slot, frame) = held;
      final onScreen = index == _held.length - 1;
      if (all || (!onScreen && !slotInUse(slot))) {
        frame.release(_cpuComplete);
      } else {
        keep.add(held);
      }
    }
    _held
      ..clear()
      ..addAll(keep);
  }

  /// Checks for released slots while every slot is held, as MapLibre then
  /// waits for a free slot to render the next frame. With a slot free, the
  /// next present releases what it can, and an idle map polls nothing.
  void _scheduleRecycle() {
    if (_recycler != null || _held.length < gpuSlotCount) return;
    _recycler = Timer.periodic(_recycleInterval, (timer) {
      if (host?.disposed ?? true) {
        timer.cancel();
        _recycler = null;
        return;
      }
      host!.onGpuQueue(() async => _releaseHeld()).ignore();
      if (_held.length < gpuSlotCount) {
        timer.cancel();
        _recycler = null;
      }
    });
  }

  @override
  Future<void> endSession(RenderSessionHandle session) {
    _recycler?.cancel();
    _recycler = null;
    _releaseHeld(all: true);
    return super.endSession(session);
  }

  /// The session no longer touches the ring.
  @override
  void dispose() => disposeTexture();
}

/// A [RingTarget] whose ring the C library allocates, as DXGI shared
/// textures on Windows and IOSurfaces on iOS and macOS. A resize has the
/// session allocate a new ring, which [ring] counts, so the plugin knows
/// when the images of a slot change.
abstract base class LibraryRingTarget extends RingTarget {
  /// Creates a target for the plugin texture [textureId].
  LibraryRingTarget(super.textureId);

  /// The number of the session's current ring.
  int ring = 0;

  @override
  Future<void> resizeRing(
    RenderSessionHandle session,
    LogicalExtent extent,
  ) async {
    await session.resize(logicalSize(extent));
    ring++;
  }
}

/// A [RingTarget] whose ring the plugin allocates and the session borrows,
/// as on Linux. A caller-owned ring is resized by replacing it rather than
/// through a session resize.
abstract base class BorrowedRingTarget<Slot> extends RingTarget {
  /// Creates a target for the plugin texture [textureId] and its first ring.
  BorrowedRingTarget(super.textureId, this.slots);

  /// The ring the session renders into.
  List<Slot> slots;

  /// Has the plugin replace the ring with one of [width] x [height] pixels.
  List<Slot> replaceRing(int width, int height);

  /// Moves [session] to the ring [slots] at [extent].
  Future<void> setRing(RenderSessionHandle session, LogicalExtent extent);

  /// Has the plugin release the rings that resizes replaced.
  void releaseRetiredRings();

  /// The session renders into the new ring once it moved there, and the
  /// plugin releases the old one then.
  @override
  Future<void> resizeRing(
    RenderSessionHandle session,
    LogicalExtent extent,
  ) async {
    final (width, height) = physicalSize(extent);
    slots = replaceRing(width, height);
    await setRing(session, extent);
    releaseRetiredRings();
  }
}
