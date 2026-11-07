import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:maplibre_native/src/desktop/desktop_plugin.dart';
import 'package:maplibre_native/src/frame_target.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

/// VK_IMAGE_LAYOUT_GENERAL. The session leaves each frame in the general
/// layout that OpenGL reads, and with the default initial layout of
/// VK_IMAGE_LAYOUT_UNDEFINED it takes a released slot back without a layout
/// transition.
const _vkImageLayoutGeneral = 1;

/// The Vulkan device on Flutter's GPU that every map renders with, which
/// lives as long as the process, or why there is none.
final (VulkanDeviceHandle?, String?) _gpuDevice = _createGpuDevice();

/// The device of every map that reads its frames back, which lives as long
/// as the process.
OffscreenDeviceHandle? _offscreenDevice;

(VulkanDeviceHandle?, String?) _createGpuDevice() {
  final (id, unavailable) = DesktopPlugin.gpuId();
  if (id == null) return (null, unavailable);
  try {
    return (
      VulkanDeviceHandle.create(
        options: Platform.isWindows
            ? VulkanDeviceOptions(deviceLuid: id)
            : VulkanDeviceOptions(deviceUuid: id),
      ),
      null,
    );
  } on MaplibreException catch (error) {
    return (null, "no Vulkan device on Flutter's GPU: $error");
  }
}

/// Creates the target of a Windows or Linux map, which renders through Vulkan
/// on its session's core worker, on the GPU that Flutter renders on.
///
/// The session renders into a ring of images that Flutter's graphics API
/// shares, without a CPU copy: DXGI shared textures that the C library
/// allocates on Windows, and images whose memory OpenGL imports, which the
/// plugin allocates, on Linux. Where the GPU can't share them, each frame is
/// read back as RGBA8 into a pixel buffer texture.
FrameTarget createDesktopTarget(LogicalExtent extent) {
  final (target, unavailable) = _zeroCopyTarget(extent);
  if (target != null) return target;
  debugPrint(
    'maplibre_native: zero-copy textures are unavailable '
    '($unavailable), falling back to CPU readback.',
  );
  return _PixelBufferTarget(DesktopPlugin.createPixelTexture());
}

(FrameTarget?, String?) _zeroCopyTarget(LogicalExtent extent) {
  final (device, unavailable) = _gpuDevice;
  if (device == null) return (null, unavailable);
  if (Platform.isWindows) {
    final (id, unavailable) = DesktopPlugin.createSharedTexture();
    if (id == null) return (null, unavailable);
    return (_DxgiRingTarget(id, device), null);
  }
  final context = device.getContext().context;
  final (width, height) = physicalSize(extent);
  final (texture, error) = DesktopPlugin.createGpuTexture(
    context,
    width,
    height,
    gpuSlotCount,
  );
  if (texture == null) return (null, error);
  return (_GlRingTarget(context, texture), null);
}

/// A ring of DXGI shared textures that the C library allocates. Each frame
/// is copied on the GPU into the texture Flutter shows before it is
/// released.
final class _DxgiRingTarget extends LibraryRingTarget {
  _DxgiRingTarget(super.textureId, this._device);

  final VulkanDeviceHandle _device;

  @override
  bool get holdsFrames => false;

  @override
  RenderSessionHandle attach(
    MapHandle map,
    LogicalExtent extent,
    Wake frameWake,
  ) => map.attachDxgiSharedTextureRing(
    DxgiSharedTextureRingDescriptor(
      logicalSize: logicalSize(extent),
      textureCount: gpuSlotCount,
    ),
    attachOptions(frameWake),
    device: _device,
  );

  @override
  int presentFrame(AcquiredFrameHandle frame) =>
      frame.withDxgiSharedTexture((view) {
        DesktopPlugin.presentSharedTexture(
          textureId,
          ring: ring,
          slot: view.slot,
          handle: view.handle.address,
        );
        return view.slot;
      });

  @override
  void disposeTexture() => DesktopPlugin.disposeTexture(textureId);
}

/// A ring of Vulkan images that the plugin allocates and whose memory
/// Flutter's OpenGL context samples, so frames are held until their slots
/// are free.
final class _GlRingTarget extends BorrowedRingTarget<VulkanBorrowedTexture> {
  _GlRingTarget(this._context, GpuTexture texture)
    : _format = texture.format,
      super(texture.textureId, texture.slots);

  final VulkanContextDescriptor _context;
  final int _format;

  @override
  bool get holdsFrames => true;

  @override
  RenderSessionHandle attach(
    MapHandle map,
    LogicalExtent extent,
    Wake frameWake,
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
      attachOptions(frameWake),
    );
  }

  @override
  List<VulkanBorrowedTexture> replaceRing(int width, int height) =>
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
  int presentFrame(AcquiredFrameHandle frame) {
    final slot = frame.withVulkanTexture((view) => view.slot);
    DesktopPlugin.presentGpuTexture(textureId, slot);
    return slot;
  }

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
