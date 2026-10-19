import 'dart:io';

import 'package:maplibre_native/src/map_state.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// MapLibre Native implementation of the federated MapLibre plugin, rendering
/// through the MapLibre Native C API.
class MapLibrePluginNative extends MapLibrePlatform {
  /// Registers [MapLibrePluginNative] as the MapLibre platform.
  static void registerWith() =>
      MapLibrePlatform.instance = MapLibrePluginNative();

  /// Whether maplibre_native can render on the current platform.
  ///
  /// The plugin registers on every native platform, but only Windows and
  /// Android have a texture integration so far.
  static bool get isPlatformSupported =>
      Platform.isWindows || Platform.isAndroid;

  @override
  MapLibreMapState createWidgetState() {
    if (!isPlatformSupported) {
      throw UnsupportedError(
        'maplibre_native does not render on ${Platform.operatingSystem} yet. '
        'Only Windows and Android are supported so far.',
      );
    }
    return MapLibreMapStateNative();
  }

  @override
  Future<OfflineManager> createOfflineManager() => throw UnsupportedError(
    'The OfflineManager is not supported by maplibre_native yet.',
  );

  @override
  PermissionManager createPermissionManager() => throw UnsupportedError(
    'The PermissionManager is not supported by maplibre_native.',
  );
}
