import 'package:jni/jni.dart';
import 'package:maplibre_android/src/jni.g.dart' as jni;
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

  @override
  Future<void> setRequestHeaders(
    String host,
    Map<String, String> headers,
  ) async {
    using((arena) {
      final jHost = host.toJString()..releasedBy(arena);
      final jHeaders = <JString, JString>{
        for (final entry in headers.entries)
          (entry.key.toJString()..releasedBy(arena)): (entry.value.toJString()
            ..releasedBy(arena)),
      }.toJMap()..releasedBy(arena);
      jni.HostScopedRequestHeaders.replace(jHost, jHeaders);
    });
  }

  @override
  Future<void> clearRequestHeaders(String host) async {
    using((arena) {
      jni.HostScopedRequestHeaders.clear(host.toJString()..releasedBy(arena));
    });
  }

  @override
  bool get offlineManagerIsSupported => true;

  @override
  bool get permissionManagerIsSupported => true;

  @override
  bool get userLocationIsSupported => true;
}
