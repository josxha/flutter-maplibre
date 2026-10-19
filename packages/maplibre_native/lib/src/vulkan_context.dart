// ignore_for_file: avoid_private_typedef_functions

import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

// Only the Vulkan declarations needed to create a headless graphics device.

const _vkSuccess = 0;
const _vkStructureTypeApplicationInfo = 0;
const _vkStructureTypeInstanceCreateInfo = 1;
const _vkStructureTypeDeviceQueueCreateInfo = 2;
const _vkStructureTypeDeviceCreateInfo = 3;
const _vkQueueGraphicsBit = 0x1;
const int _vkApiVersion11 = (1 << 22) | (1 << 12);

/// Indices into VkPhysicalDeviceFeatures, which is 55 VkBool32 fields.
const _featureCount = 55;
const _featureWideLines = 15;
const _featureSamplerAnisotropy = 19;

final class _VkApplicationInfo extends Struct {
  @Int32()
  external int sType;
  external Pointer<Void> pNext;
  external Pointer<Utf8> pApplicationName;
  @Uint32()
  external int applicationVersion;
  external Pointer<Utf8> pEngineName;
  @Uint32()
  external int engineVersion;
  @Uint32()
  external int apiVersion;
}

final class _VkInstanceCreateInfo extends Struct {
  @Int32()
  external int sType;
  external Pointer<Void> pNext;
  @Uint32()
  external int flags;
  external Pointer<_VkApplicationInfo> pApplicationInfo;
  @Uint32()
  external int enabledLayerCount;
  external Pointer<Pointer<Utf8>> ppEnabledLayerNames;
  @Uint32()
  external int enabledExtensionCount;
  external Pointer<Pointer<Utf8>> ppEnabledExtensionNames;
}

final class _VkDeviceQueueCreateInfo extends Struct {
  @Int32()
  external int sType;
  external Pointer<Void> pNext;
  @Uint32()
  external int flags;
  @Uint32()
  external int queueFamilyIndex;
  @Uint32()
  external int queueCount;
  external Pointer<Float> pQueuePriorities;
}

final class _VkDeviceCreateInfo extends Struct {
  @Int32()
  external int sType;
  external Pointer<Void> pNext;
  @Uint32()
  external int flags;
  @Uint32()
  external int queueCreateInfoCount;
  external Pointer<_VkDeviceQueueCreateInfo> pQueueCreateInfos;
  @Uint32()
  external int enabledLayerCount;
  external Pointer<Pointer<Utf8>> ppEnabledLayerNames;
  @Uint32()
  external int enabledExtensionCount;
  external Pointer<Pointer<Utf8>> ppEnabledExtensionNames;
  external Pointer<Uint32> pEnabledFeatures;
}

final class _VkQueueFamilyProperties extends Struct {
  @Uint32()
  external int queueFlags;
  @Uint32()
  external int queueCount;
  @Uint32()
  external int timestampValidBits;
  @Uint32()
  external int minImageTransferGranularityWidth;
  @Uint32()
  external int minImageTransferGranularityHeight;
  @Uint32()
  external int minImageTransferGranularityDepth;
}

typedef _GetInstanceProcAddrNative = Pointer<Void> Function(
  Pointer<Void> instance,
  Pointer<Utf8> name,
);
typedef _GetInstanceProcAddr = Pointer<Void> Function(
  Pointer<Void> instance,
  Pointer<Utf8> name,
);
typedef _CreateInstanceNative = Int32 Function(
  Pointer<_VkInstanceCreateInfo>,
  Pointer<Void>,
  Pointer<Pointer<Void>>,
);
typedef _CreateInstance = int Function(
  Pointer<_VkInstanceCreateInfo>,
  Pointer<Void>,
  Pointer<Pointer<Void>>,
);
typedef _EnumeratePhysicalDevicesNative = Int32 Function(
  Pointer<Void>,
  Pointer<Uint32>,
  Pointer<Pointer<Void>>,
);
typedef _EnumeratePhysicalDevices = int Function(
  Pointer<Void>,
  Pointer<Uint32>,
  Pointer<Pointer<Void>>,
);
typedef _GetQueueFamilyPropertiesNative = Void Function(
  Pointer<Void>,
  Pointer<Uint32>,
  Pointer<_VkQueueFamilyProperties>,
);
typedef _GetQueueFamilyProperties = void Function(
  Pointer<Void>,
  Pointer<Uint32>,
  Pointer<_VkQueueFamilyProperties>,
);
typedef _GetFeaturesNative = Void Function(Pointer<Void>, Pointer<Uint32>);
typedef _GetFeatures = void Function(Pointer<Void>, Pointer<Uint32>);
typedef _CreateDeviceNative = Int32 Function(
  Pointer<Void>,
  Pointer<_VkDeviceCreateInfo>,
  Pointer<Void>,
  Pointer<Pointer<Void>>,
);
typedef _CreateDevice = int Function(
  Pointer<Void>,
  Pointer<_VkDeviceCreateInfo>,
  Pointer<Void>,
  Pointer<Pointer<Void>>,
);
typedef _GetDeviceQueueNative = Void Function(
  Pointer<Void>,
  Uint32,
  Uint32,
  Pointer<Pointer<Void>>,
);
typedef _GetDeviceQueue = void Function(
  Pointer<Void>,
  int,
  int,
  Pointer<Pointer<Void>>,
);

/// A process-wide Vulkan instance, device, and graphics queue that MapLibre
/// render sessions borrow.
///
/// Every session renders on its own core worker and submits to the queue from
/// that thread, so nothing else may submit to [descriptor]'s queue.
final class VulkanContext {
  VulkanContext._(this.descriptor);

  /// The context in the form a Vulkan render target takes it.
  final VulkanContextDescriptor descriptor;

  static VulkanContext? _shared;

  /// Returns the shared context, creating it on first use. It lives as long
  /// as the process.
  static VulkanContext get shared => _shared ??= _create();

  static VulkanContext _create() {
    final loader = DynamicLibrary.open('vulkan-1.dll');
    final getInstanceProcAddrPointer = loader
        .lookup<NativeFunction<_GetInstanceProcAddrNative>>(
          'vkGetInstanceProcAddr',
        );
    final getInstanceProcAddr = getInstanceProcAddrPointer
        .asFunction<_GetInstanceProcAddr>();

    return using((arena) {
      Pointer<Void> proc(Pointer<Void> instance, String name) {
        final address = getInstanceProcAddr(
          instance,
          name.toNativeUtf8(allocator: arena),
        );
        if (address == nullptr) {
          throw StateError('The Vulkan loader lacks $name.');
        }
        return address;
      }

      final application = arena<_VkApplicationInfo>()
        ..ref.sType = _vkStructureTypeApplicationInfo
        ..ref.pApplicationName = 'maplibre_native'.toNativeUtf8(
          allocator: arena,
        )
        ..ref.apiVersion = _vkApiVersion11;
      final instanceInfo = arena<_VkInstanceCreateInfo>()
        ..ref.sType = _vkStructureTypeInstanceCreateInfo
        ..ref.pApplicationInfo = application;
      final instanceOut = arena<Pointer<Void>>();
      final createInstance = proc(nullptr, 'vkCreateInstance')
          .cast<NativeFunction<_CreateInstanceNative>>()
          .asFunction<_CreateInstance>();
      _check(
        createInstance(instanceInfo, nullptr, instanceOut),
        'vkCreateInstance',
      );
      final instance = instanceOut.value;

      final enumerateDevices = proc(instance, 'vkEnumeratePhysicalDevices')
          .cast<NativeFunction<_EnumeratePhysicalDevicesNative>>()
          .asFunction<_EnumeratePhysicalDevices>();
      final getQueueFamilies =
          proc(instance, 'vkGetPhysicalDeviceQueueFamilyProperties')
              .cast<NativeFunction<_GetQueueFamilyPropertiesNative>>()
              .asFunction<_GetQueueFamilyProperties>();
      final getFeatures = proc(
        instance,
        'vkGetPhysicalDeviceFeatures',
      ).cast<NativeFunction<_GetFeaturesNative>>().asFunction<_GetFeatures>();
      final createDevice = proc(
        instance,
        'vkCreateDevice',
      ).cast<NativeFunction<_CreateDeviceNative>>().asFunction<_CreateDevice>();
      final getDeviceQueue = proc(instance, 'vkGetDeviceQueue')
          .cast<NativeFunction<_GetDeviceQueueNative>>()
          .asFunction<_GetDeviceQueue>();
      final getDeviceProcAddr = proc(instance, 'vkGetDeviceProcAddr');

      final deviceCount = arena<Uint32>();
      _check(
        enumerateDevices(instance, deviceCount, nullptr),
        'vkEnumeratePhysicalDevices',
      );
      if (deviceCount.value == 0) {
        throw StateError('No Vulkan physical device is available.');
      }
      final devices = arena<Pointer<Void>>(deviceCount.value);
      _check(
        enumerateDevices(instance, deviceCount, devices),
        'vkEnumeratePhysicalDevices',
      );

      // Takes the first device and queue family that accept a graphics
      // device, as the C API's own test fixture does.
      for (var d = 0; d < deviceCount.value; d++) {
        final physicalDevice = devices[d];
        final familyCount = arena<Uint32>();
        getQueueFamilies(physicalDevice, familyCount, nullptr);
        final families = arena<_VkQueueFamilyProperties>(familyCount.value);
        getQueueFamilies(physicalDevice, familyCount, families);

        final supported = arena<Uint32>(_featureCount);
        getFeatures(physicalDevice, supported);
        final features = arena<Uint32>(_featureCount);
        features[_featureWideLines] = supported[_featureWideLines];
        features[_featureSamplerAnisotropy] =
            supported[_featureSamplerAnisotropy];

        for (var q = 0; q < familyCount.value; q++) {
          final family = families[q];
          if (family.queueFlags & _vkQueueGraphicsBit == 0 ||
              family.queueCount == 0) {
            continue;
          }
          final priority = arena<Float>()..value = 1;
          final queueInfo = arena<_VkDeviceQueueCreateInfo>()
            ..ref.sType = _vkStructureTypeDeviceQueueCreateInfo
            ..ref.queueFamilyIndex = q
            ..ref.queueCount = 1
            ..ref.pQueuePriorities = priority;
          final deviceInfo = arena<_VkDeviceCreateInfo>()
            ..ref.sType = _vkStructureTypeDeviceCreateInfo
            ..ref.queueCreateInfoCount = 1
            ..ref.pQueueCreateInfos = queueInfo
            ..ref.pEnabledFeatures = features;
          final deviceOut = arena<Pointer<Void>>();
          if (createDevice(physicalDevice, deviceInfo, nullptr, deviceOut) !=
              _vkSuccess) {
            continue;
          }
          final queueOut = arena<Pointer<Void>>();
          getDeviceQueue(deviceOut.value, q, 0, queueOut);

          NativePointer pointer(Pointer<Void> value) =>
              NativePointer(value.address);
          return VulkanContext._(
            VulkanContextDescriptor(
              instance: pointer(instance),
              physicalDevice: pointer(physicalDevice),
              device: pointer(deviceOut.value),
              graphicsQueue: pointer(queueOut.value),
              graphicsQueueFamilyIndex: q,
              getInstanceProcAddr: pointer(
                getInstanceProcAddrPointer.cast<Void>(),
              ),
              getDeviceProcAddr: pointer(getDeviceProcAddr),
            ),
          );
        }
      }
      throw StateError('No Vulkan physical device accepted a graphics device.');
    });
  }

  static void _check(int result, String call) {
    if (result != _vkSuccess) {
      throw StateError('$call failed with VkResult $result.');
    }
  }
}
