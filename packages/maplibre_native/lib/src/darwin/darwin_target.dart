import 'package:maplibre_native/src/darwin/darwin_plugin.dart';
import 'package:maplibre_native/src/frame_target.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

/// Creates the target of an iOS or macOS map, which renders on its session's
/// core worker through Metal into a ring of BGRA8 textures. The plugin copies
/// each frame on the GPU into an IOSurface-backed pixel buffer, which Flutter
/// samples without a CPU copy.
FrameTarget createDarwinTarget(LogicalExtent extent) {
  final (width, height) = physicalSize(extent);
  final texture = DarwinPlugin.createGpuTexture(width, height, gpuSlotCount);
  return _MetalTextureTarget(texture.textureId, texture.slots);
}

final class _MetalTextureTarget
    extends BorrowedRingTarget<MetalBorrowedTexture> {
  _MetalTextureTarget(super.textureId, super.slots);

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

  @override
  void releaseRetiredRings() => DarwinPlugin.releaseRetiredSlots(textureId);

  @override
  int slotOf(AcquiredFrameHandle frame) =>
      frame.getMetalTexture().withView((view) => view.slot);

  /// Also waits for the copy.
  @override
  void presentSlot(int slot) => DarwinPlugin.presentGpuTexture(textureId, slot);

  @override
  void disposeTexture() => DarwinPlugin.disposeTexture(textureId);
}
