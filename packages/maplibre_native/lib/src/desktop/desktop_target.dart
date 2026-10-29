import 'package:flutter/foundation.dart';
import 'package:maplibre_native/src/desktop/desktop_plugin.dart';
import 'package:maplibre_native/src/frame_target.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

/// VK_IMAGE_LAYOUT_GENERAL. The session leaves each frame in the general
/// layout that D3D11 and OpenGL read, and with the default initial layout of
/// VK_IMAGE_LAYOUT_UNDEFINED it takes a released slot back without a layout
/// transition.
const _vkImageLayoutGeneral = 1;

VulkanContextDescriptor? _vulkanContext;

/// The Vulkan device that the Windows or Linux plugin created on Flutter's
/// GPU, which every map borrows.
VulkanContextDescriptor _context() =>
    _vulkanContext ??= DesktopPlugin.vulkanContext();

/// Creates the target of a Windows or Linux map, which renders through Vulkan
/// on its session's core worker.
///
/// When the GPU shares memory between Vulkan and Flutter's graphics API
/// (D3D11 on Windows, OpenGL on Linux), the session renders into a ring of
/// shared images that Flutter composites without a CPU copy. Otherwise each
/// frame is read back as RGBA8 into a pixel buffer texture.
FrameTarget createDesktopTarget(LogicalExtent extent) {
  final context = _context();
  final (width, height) = physicalSize(extent);
  final (gpu, unavailable) = DesktopPlugin.createGpuTexture(
    width,
    height,
    gpuSlotCount,
  );
  if (gpu != null) return _VulkanTextureTarget(context, gpu);
  debugPrint(
    'maplibre_native: zero-copy textures are unavailable '
    '($unavailable), falling back to CPU readback.',
  );
  return _PixelBufferTarget(context, DesktopPlugin.createPixelTexture());
}

/// A ring of Vulkan images whose memory Flutter's graphics API shares. Each
/// frame is copied on the GPU into the texture Flutter shows.
final class _VulkanTextureTarget
    extends BorrowedRingTarget<VulkanBorrowedTexture> {
  _VulkanTextureTarget(this._context, GpuTexture texture)
    : _format = texture.format,
      super(texture.textureId, texture.slots);

  final VulkanContextDescriptor _context;
  final int _format;

  VulkanBorrowedTextureDescriptor _descriptor(LogicalExtent extent) {
    final (width, height) = physicalSize(extent);
    return VulkanBorrowedTextureDescriptor(
      extent: extent,
      physicalWidth: width,
      physicalHeight: height,
      context: _context,
      textures: slots,
      format: _format,
      finalLayout: _vkImageLayoutGeneral,
    );
  }

  @override
  NewRenderSession attachRing(
    MapHandle map,
    LogicalExtent extent,
    RenderSessionAttachOptions options,
  ) => map.attachVulkanBorrowedTexture(_descriptor(extent), options);

  @override
  List<VulkanBorrowedTexture> resizeRing(int width, int height) =>
      DesktopPlugin.resizeGpuTexture(textureId, width, height, gpuSlotCount);

  @override
  Future<void> setRing(RenderSessionHandle session, LogicalExtent extent) =>
      session.setVulkanBorrowedTextureTarget(_descriptor(extent));

  @override
  void releaseRetiredRings() => DesktopPlugin.releaseRetiredSlots(textureId);

  @override
  int slotOf(AcquiredFrameHandle frame) =>
      frame.withVulkanTexture((view) => view.slot);

  @override
  void presentSlot(int slot) =>
      DesktopPlugin.presentGpuTexture(textureId, slot);

  @override
  void disposeTexture() => DesktopPlugin.disposeTexture(textureId);
}

/// A session-owned Vulkan texture read back to the CPU into a pixel buffer
/// texture, where the GPU can't share memory with Flutter.
final class _PixelBufferTarget extends FrameTarget {
  _PixelBufferTarget(this._context, this.textureId);

  final VulkanContextDescriptor _context;

  @override
  final int textureId;

  @override
  bool get isZeroCopy => false;

  @override
  NewRenderSession attach(
    MapHandle map,
    LogicalExtent extent,
    Wake frameWake,
  ) => map.attachVulkanOwnedTexture(
    VulkanOwnedTextureDescriptor(extent: extent, context: _context),
    RenderSessionAttachOptions(
      driver: RenderDriverKind.coreWorker,
      frameWake: frameWake,
    ),
  );

  @override
  Future<void> resize(RenderSessionHandle session, LogicalExtent extent) =>
      session.resize(extent);

  @override
  Future<bool> present(RenderSessionHandle session) async {
    final image = await session.readTexture();
    DesktopPlugin.updatePixelTexture(
      textureId,
      width: image.info.width,
      height: image.info.height,
      stride: image.info.stride,
      pixels: image.data,
    );
    return true;
  }

  @override
  void dispose() => DesktopPlugin.disposeTexture(textureId);
}
