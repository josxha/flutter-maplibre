import 'dart:io';

import 'package:maplibre_native/src/map_state.dart';
import 'package:maplibre_native/src/offline_manager.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// MapLibre Native implementation of the federated MapLibre plugin, rendering
/// through the MapLibre Native C API.
class MapLibrePluginNative extends MapLibrePlatform {
  /// Registers [MapLibrePluginNative] as the MapLibre platform.
  static void registerWith() =>
      MapLibrePlatform.instance = MapLibrePluginNative();

  /// Whether maplibre_native can render on the current platform.
  static bool get isPlatformSupported =>
      Platform.isWindows ||
      Platform.isLinux ||
      Platform.isAndroid ||
      Platform.isIOS ||
      Platform.isMacOS;

  @override
  MapLibreMapState createWidgetState() {
    if (!isPlatformSupported) {
      throw UnsupportedError(
        'maplibre_native does not render on ${Platform.operatingSystem}.',
      );
    }
    return MapLibreMapStateNative();
  }

  @override
  Future<OfflineManager> createOfflineManager() async {
    if (!isPlatformSupported) {
      throw UnsupportedError(
        'maplibre_native does not run on ${Platform.operatingSystem}.',
      );
    }
    return OfflineManagerNative.create();
  }

  @override
  bool get offlineManagerIsSupported => isPlatformSupported;
}
