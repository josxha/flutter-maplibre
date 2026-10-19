import 'package:maplibre_native/src/map_state.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// MapLibre Native implementation of the federated MapLibre plugin, rendering
/// through the MapLibre Native C API.
class MapLibrePluginNative extends MapLibrePlatform {
  /// Registers [MapLibrePluginNative] as the MapLibre platform.
  static void registerWith() =>
      MapLibrePlatform.instance = MapLibrePluginNative();

  @override
  MapLibreMapState createWidgetState() => MapLibreMapStateNative();

  @override
  Future<OfflineManager> createOfflineManager() => throw UnsupportedError(
    'The OfflineManager is not supported by maplibre_native yet.',
  );

  @override
  PermissionManager createPermissionManager() => throw UnsupportedError(
    'The PermissionManager is not supported by maplibre_native.',
  );
}
