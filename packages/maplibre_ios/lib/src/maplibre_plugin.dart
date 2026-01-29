import 'package:maplibre_ios/src/map_state.dart';
import 'package:maplibre_ios/src/offline_manager.dart';
import 'package:maplibre_ios/src/permission_manager.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// iOS implementation of the federated MapLibre plugin.
final class MapLibrePlugin extends MapLibrePlatform {
  /// This static method registers [MapLibrePlugin] when running on iOS.
  static void registerWith() => MapLibrePlatform.instance = MapLibrePlugin();

  @override
  MapLibreMapState createWidgetState() => MapLibreMapStateIos();

  @override
  Future<OfflineManager> createOfflineManager() =>
      OfflineManagerIos.createInstance();

  @override
  PermissionManager createPermissionManager() => const PermissionManagerIos();
}
