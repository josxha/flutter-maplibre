import 'package:maplibre_android/src/map_state.dart';
import 'package:maplibre_android/src/offline_manager.dart';
import 'package:maplibre_android/src/permission_manager.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Android implementation of the federated MapLibre plugin.
final class MapLibrePlugin extends MapLibrePlatform {
  /// This static method registers [MapLibrePlugin] when running on Android.
  static void registerWith() => MapLibrePlatform.instance = MapLibrePlugin();

  @override
  MapLibreMapState createWidgetState() => MapLibreMapStateAndroid();

  @override
  Future<OfflineManager> createOfflineManager() =>
      OfflineManagerAndroid.createInstance();

  @override
  PermissionManager createPermissionManager() => PermissionManagerAndroid();
}
