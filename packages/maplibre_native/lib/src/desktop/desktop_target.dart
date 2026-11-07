import 'dart:io';

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

/// The device of every map that reads its frames back, which lives as long
/// as the process.
OffscreenDeviceHandle? _offscreenDevice;

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
  return _PixelBufferTarget(DesktopPlugin.createPixelTexture());
}

/// A ring of Vulkan images whose memory Flutter's graphics API shares. On
/// Windows each frame is copied on the GPU into the texture Flutter shows; on
/// Linux Flutter samples the slot itself, so frames are held until their
/// slots are free.
final class _VulkanTextureTarget
    extends BorrowedRingTarget<VulkanBorrowedTexture> {
  _VulkanTextureTarget(this._context, GpuTexture texture)
    : _format = texture.format,
      super(texture.textureId, texture.slots);

  final VulkanContextDescriptor _context;
  final int _format;

  @override
  bool get holdsFrames => Platform.isLinux;

  @override
  RenderSessionHandle attachRing(
    MapHandle map,
    LogicalExtent extent,
    RenderSessionAttachOptions options,
  ) {
    final (width, height) = physicalSize(extent);
    return map.attachVulkanBorrowedTexture(
      VulkanBorrowedTextureDescriptor(
        logicalSize: logicalSize(extent),
        physicalWidth: width,
        physicalHeight: height,
        context: _context,
        textures: slots,
        format: _format,
        finalLayout: _vkImageLayoutGeneral,
      ),
      options,
    );
  }

  @override
  List<VulkanBorrowedTexture> resizeRing(int width, int height) =>
      DesktopPlugin.resizeGpuTexture(textureId, width, height, gpuSlotCount);

  @override
  Future<void> setRing(RenderSessionHandle session, LogicalExtent extent) {
    final (width, height) = physicalSize(extent);
    return session.setVulkanBorrowedTextureTarget(
      VulkanBorrowedTextureReplacement(
        logicalSize: logicalSize(extent),
        physicalWidth: width,
        physicalHeight: height,
        textures: slots,
      ),
    );
  }

  @override
  void releaseRetiredRings() => DesktopPlugin.releaseRetiredSlots(textureId);

  @override
  int slotOf(AcquiredFrameHandle frame) =>
      frame.withVulkanTexture((view) => view.slot);

  @override
  void presentSlot(int slot) =>
      DesktopPlugin.presentGpuTexture(textureId, slot);

  @override
  bool slotInUse(int slot) => DesktopPlugin.slotInUse(textureId, slot);

  @override
  void disposeTexture() => DesktopPlugin.disposeTexture(textureId);
}

/// An offscreen session whose frames are read back to the CPU into a pixel
/// buffer texture, where the GPU can't share memory with Flutter.
final class _PixelBufferTarget extends FrameTarget {
  _PixelBufferTarget(this.textureId);

  @override
  final int textureId;

  @override
  bool get isZeroCopy => false;

  @override
  RenderSessionHandle attach(
    MapHandle map,
    LogicalExtent extent,
    Wake frameWake,
  ) => map.attachOffscreen(
    OffscreenDescriptor(logicalSize: logicalSize(extent)),
    RenderSessionAttachOptions(
      driver: RenderDriverKind.coreWorker,
      frameWake: frameWake,
    ),
    device: _offscreenDevice ??= OffscreenDeviceHandle.create(),
  );

  @override
  Future<void> resize(RenderSessionHandle session, LogicalExtent extent) =>
      session.resize(logicalSize(extent));

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
