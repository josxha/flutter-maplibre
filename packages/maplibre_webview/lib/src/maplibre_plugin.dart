import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_webview/src/map_state.dart';

/// WebView implementation of the federated MapLibre plugin.
final class MapLibrePlugin extends PlatformInterface {
  /// This static method registers [MapLibrePlugin] when running in a webview.
  static void registerWith() => PlatformInterface.instance = MapLibrePlugin();

  @override
  MapLibreMapState createWidgetState() => MapLibreMapStateWebView();

  @override
  Future<OfflineManager> createOfflineManager() =>
      throw Exception('The OfflineManager can not be used on webview.');

  @override
  PermissionManager createPermissionManager() {
    throw Exception('The PermissionManager can not be used on webview.');
  }
}
