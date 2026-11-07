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

/// A target whose texture the plugin backs with a ring of [gpuSlotCount]
/// images that the session borrows, as on Windows, Linux, iOS, and macOS.
///
/// Where the plugin copies each finished frame on the GPU before
/// [presentSlot] returns (Windows), the frame is released right after. Where
/// Flutter samples the slot itself (Linux, iOS, macOS; [holdsFrames]), the
/// frame on screen stays acquired, so MapLibre renders into the other slots,
/// and each frame it replaced is released once [slotInUse] reports its slot
/// free. A caller-owned ring is resized by replacing it rather than through a
/// session resize.
abstract base class BorrowedRingTarget<Slot> extends FrameTarget {
  /// Creates a target for the plugin texture [textureId] and its first ring.
  BorrowedRingTarget(this.textureId, this.slots);

  @override
  final int textureId;

  /// The ring the session renders into.
  List<Slot> slots;

  /// Whether Flutter samples the presented slot itself, so that a frame
  /// stays acquired while its slot is in use.
  bool get holdsFrames;

  /// The acquired frames by slot, oldest first. The last one is on screen.
  final _held = <(int, AcquiredFrameHandle)>[];

  Timer? _recycler;

  /// Attaches the session to the ring [slots] at [extent].
  RenderSessionHandle attachRing(
    MapHandle map,
    LogicalExtent extent,
    RenderSessionAttachOptions options,
  );

  /// Has the plugin replace the ring with one of [width] x [height] pixels.
  List<Slot> resizeRing(int width, int height);

  /// Moves [session] to the ring [slots] at [extent].
  Future<void> setRing(RenderSessionHandle session, LogicalExtent extent);

  /// Has the plugin release the rings that resizes replaced.
  void releaseRetiredRings();

  /// The ring slot that [frame] rendered into.
  int slotOf(AcquiredFrameHandle frame);

  /// Hands the frame in [slot] to Flutter.
  void presentSlot(int slot);

  /// Whether Flutter may still sample [slot]. Only asked when [holdsFrames].
  bool slotInUse(int slot) => false;

  /// Has the plugin unregister the texture and release its rings.
  void disposeTexture();

  /// Frames are complete on the GPU once acquired, so the plugin can copy or
  /// sample them without waiting.
  @override
  RenderSessionHandle attach(
    MapHandle map,
    LogicalExtent extent,
    Wake frameWake,
  ) => attachRing(
    map,
    extent,
    RenderSessionAttachOptions(
      driver: RenderDriverKind.coreWorker,
      producerSyncKinds: GpuSyncKindFlag.cpuComplete,
      frameWake: frameWake,
    ),
  );

  /// The session cannot move to the new ring while it has a frame acquired,
  /// so the held frames of the old ring go first. Flutter keeps sampling the
  /// old ring's slot until a frame of the new one arrives, and the session
  /// renders into the new ring from then on.
  @override
  Future<void> resize(RenderSessionHandle session, LogicalExtent extent) async {
    final (width, height) = physicalSize(extent);
    slots = resizeRing(width, height);
    _releaseHeld(all: true);
    await setRing(session, extent);
    releaseRetiredRings();
  }

  /// The frame's GPU writes completed before it became acquirable, so the
  /// plugin can copy or sample it once [presentSlot] returns.
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
    if (_recycler != null || _held.length < slots.length) return;
    _recycler = Timer.periodic(_recycleInterval, (timer) {
      if (host?.disposed ?? true) {
        timer.cancel();
        _recycler = null;
        return;
      }
      host!.onGpuQueue(() async => _releaseHeld()).ignore();
      if (_held.length < slots.length) {
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

  /// The session no longer touches the ring, which is the plugin's.
  @override
  void dispose() => disposeTexture();
}
