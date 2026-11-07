import 'package:maplibre_native/src/darwin/darwin_plugin.dart';
import 'package:maplibre_native/src/frame_target.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

/// Creates the target of an iOS or macOS map, which renders on its session's
/// core worker through Metal into a ring of IOSurface-backed BGRA8 textures.
/// Flutter samples the slot of the frame on screen directly, without a copy.
FrameTarget createDarwinTarget(LogicalExtent extent) {
  final (width, height) = physicalSize(extent);
  final texture = DarwinPlugin.createGpuTexture(width, height, gpuSlotCount);
  return _MetalTextureTarget(texture.textureId, texture.slots);
}

/// Flutter samples the slot of the frame on screen directly, so frames are
/// held until their slots are free.
final class _MetalTextureTarget
    extends BorrowedRingTarget<MetalBorrowedTexture> {
  _MetalTextureTarget(super.textureId, super.slots);

  @override
  bool get holdsFrames => true;

  @override
  RenderSessionHandle attachRing(
    MapHandle map,
    LogicalExtent extent,
    RenderSessionAttachOptions options,
  ) {
    final (width, height) = physicalSize(extent);
    return map.attachMetalBorrowedTexture(
      MetalBorrowedTextureDescriptor(
        logicalSize: logicalSize(extent),
        physicalWidth: width,
        physicalHeight: height,
        textures: slots,
      ),
      options,
    );
  }

  @override
  List<MetalBorrowedTexture> resizeRing(int width, int height) =>
      DarwinPlugin.resizeGpuTexture(textureId, width, height, gpuSlotCount);

  @override
  Future<void> setRing(RenderSessionHandle session, LogicalExtent extent) {
    final (width, height) = physicalSize(extent);
    return session.setMetalBorrowedTextureTarget(
      MetalBorrowedTextureReplacement(
        logicalSize: logicalSize(extent),
        physicalWidth: width,
        physicalHeight: height,
        textures: slots,
      ),
    );
  }

  @override
  void releaseRetiredRings() => DarwinPlugin.releaseRetiredSlots(textureId);

  @override
  int slotOf(AcquiredFrameHandle frame) =>
      frame.withMetalTexture((view) => view.slot);

  @override
  void presentSlot(int slot) => DarwinPlugin.presentGpuTexture(textureId, slot);

  @override
  bool slotInUse(int slot) => DarwinPlugin.slotInUse(textureId, slot);

  @override
  void disposeTexture() => DarwinPlugin.disposeTexture(textureId);
}
