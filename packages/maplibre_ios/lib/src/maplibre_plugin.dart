import 'package:maplibre_ios/src/map_state.dart';
import 'package:maplibre_ios/src/maplibre_ffi.g.dart';
import 'package:maplibre_ios/src/offline_manager.dart';
import 'package:maplibre_ios/src/permission_manager.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:objective_c/objective_c.dart';

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

  @override
  Future<void> setRequestHeaders(
    String host,
    Map<String, String> headers,
  ) async {
    final dictionary = NSMutableDictionary.of({
      for (final entry in headers.entries)
        entry.key.toNSString(): entry.value.toNSString(),
    });
    HostScopedRequestHeaders.replaceWithHost(
      host.toNSString(),
      headers: dictionary,
    );
  }

  @override
  Future<void> clearRequestHeaders(String host) async {
    HostScopedRequestHeaders.clearWithHost(host.toNSString());
  }

  @override
  bool get offlineManagerIsSupported => true;

  @override
  bool get permissionManagerIsSupported => false;

  @override
  bool get userLocationIsSupported => true;
}
