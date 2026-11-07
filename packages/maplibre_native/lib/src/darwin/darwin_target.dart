import 'package:maplibre_native/src/darwin/darwin_plugin.dart';
import 'package:maplibre_native/src/frame_target.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

/// Creates the target of an iOS or macOS map, which renders on its session's
/// core worker through Metal into a ring of BGRA8 IOSurfaces that the C
/// library allocates. Flutter samples the surface of the frame on screen
/// directly, without a copy.
FrameTarget createDarwinTarget(LogicalExtent extent) =>
    _IoSurfaceRingTarget(DarwinPlugin.createGpuTexture());

/// Flutter samples the surface of the frame on screen directly, so frames
/// are held until their slots are free.
final class _IoSurfaceRingTarget extends LibraryRingTarget {
  _IoSurfaceRingTarget(super.textureId);

  @override
  bool get holdsFrames => true;

  @override
  RenderSessionHandle attach(
    MapHandle map,
    LogicalExtent extent,
    Wake frameWake,
  ) => map.attachIoSurfaceRing(
    IoSurfaceRingDescriptor(
      logicalSize: logicalSize(extent),
      bufferCount: gpuSlotCount,
    ),
    attachOptions(frameWake),
  );

  @override
  int presentFrame(AcquiredFrameHandle frame) => frame.withIoSurface((view) {
    DarwinPlugin.presentGpuTexture(
      textureId,
      ring: ring,
      slot: view.slot,
      surface: view.surface.address,
    );
    return view.slot;
  });

  @override
  bool slotInUse(int slot) => DarwinPlugin.slotInUse(textureId, slot);

  @override
  void disposeTexture() => DarwinPlugin.disposeTexture(textureId);
}
