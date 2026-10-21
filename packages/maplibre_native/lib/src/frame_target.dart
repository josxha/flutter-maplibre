import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

/// Ring depth of a zero-copy texture: one slot Flutter shows, one MapLibre
/// renders into, and one spare.
const gpuSlotCount = 3;

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

  /// The frame demand flags of the session.
  FrameDemandFlag get demandFlags =>
      FrameDemandFlag.ifNeeded | FrameDemandFlag.waitForUpdate;

  /// Whether the target takes frames now. A target can stop taking them for
  /// a while, as Android does while the app is in the background.
  bool get acceptsFrames => true;

  /// Attaches a render session of [map] to this target. Frames wake through
  /// [frameWake]. When this throws, the renderer disposes the target.
  RenderSessionAttachment attach(
    MapHandle map,
    LogicalExtent extent,
    Wake frameWake,
  );

  /// Sizes the target and the session to [extent].
  Future<void> resize(RenderSessionHandle session, LogicalExtent extent);

  /// Hands the frame the session rendered last to Flutter. Returns false when
  /// there was none to hand over.
  Future<bool> present(RenderSessionHandle session);

  /// Ends the session's work before it closes. Returns whether it kept
  /// graphics objects that need their parents until process exit.
  Future<bool> endSession(RenderSessionHandle session) async =>
      abandonSession(session);

  /// Releases the texture once the session, map, and runtime are closed.
  /// [quarantined] is what [endSession] returned.
  void dispose({required bool quarantined});
}

/// Abandons [session]. Returns whether it kept graphics objects that need
/// their parents until process exit.
bool abandonSession(RenderSessionHandle session) {
  try {
    return session.abandon().quarantinedResourceCount > 0;
  } on MaplibreException {
    // A session that already let go of its target has nothing to abandon.
    return false;
  }
}

/// A target whose texture the plugin backs with a ring of [gpuSlotCount]
/// images that the session borrows, as on Windows, Linux, iOS, and macOS.
///
/// Each finished frame is copied on the GPU into the texture Flutter shows,
/// so the ring is free again once the copy returns. A caller-owned ring is
/// resized by replacing it rather than through a session resize.
abstract base class BorrowedRingTarget<Slot> extends FrameTarget {
  /// Creates a target for the plugin texture [textureId] and its first ring.
  BorrowedRingTarget(this.textureId, this.slots);

  @override
  final int textureId;

  /// The ring the session renders into.
  List<Slot> slots;

  /// Attaches the session to the ring [slots] at [extent].
  RenderSessionAttachment attachRing(
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

  /// Has the plugin copy the frame in [slot] into the texture Flutter shows.
  void presentSlot(int slot);

  /// Has the plugin unregister the texture and release its rings.
  void disposeTexture();

  @override
  RenderSessionAttachment attach(
    MapHandle map,
    LogicalExtent extent,
    Wake frameWake,
  ) => attachRing(
    map,
    extent,
    RenderSessionAttachOptions(
      driver: RenderDriverKind.coreWorker,
      frameWake: frameWake,
    ),
  );

  @override
  Future<void> resize(RenderSessionHandle session, LogicalExtent extent) async {
    final (width, height) = physicalSize(extent);
    slots = resizeRing(width, height);
    await setRing(session, extent);
    releaseRetiredRings();
  }

  /// The frame's GPU writes completed before it became acquirable, and the
  /// plugin copies it on the GPU before [presentSlot] returns, so the frame is
  /// released right after.
  @override
  Future<bool> present(RenderSessionHandle session) async {
    final frame = session.acquireFrame();
    if (frame == null) return false;
    try {
      presentSlot(slotOf(frame));
      return true;
    } finally {
      frame.release(gpuSyncDefault());
    }
  }

  /// Abandon destroyed the session's objects, and the ring is the plugin's.
  @override
  void dispose({required bool quarantined}) => disposeTexture();
}
