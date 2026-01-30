import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_web/src/map_state.dart';

/// Web implementation of the federated MapLibre plugin.
final class MapLibrePlugin extends MapLibrePlatform {
  /// This static method registers [MapLibrePlugin] when running on web.
  static void registerWith(Registrar registrar) =>
      MapLibrePlatform.instance = MapLibrePlugin();

  @override
  MapLibreMapState createWidgetState() => MapLibreMapStateWeb();

  @override
  Future<OfflineManager> createOfflineManager() =>
      throw Exception('The OfflineManager can not be used on web.');

  @override
  PermissionManager createPermissionManager() {
    throw Exception('The PermissionManager can not be used on web.');
  }
}
