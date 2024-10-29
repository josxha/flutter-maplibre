import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:maplibre/src/map_state.dart';
import 'package:maplibre/src/offline/offline_manager.dart';
import 'package:maplibre/src/platform_interface.dart';
import 'package:maplibre/src/web/widget_state.dart';

/// A web implementation of the MapLibrePlatform of the MapLibre plugin.
final class PlatformImpl extends PlatformInterface {
  /// This static method registers [PlatformImpl] when running on web.
  static void registerWith(Registrar registrar) =>
      PlatformInterface.instance = PlatformImpl();

  @override
  MapLibreMapState createWidgetState() => MapLibreMapStateWeb();

  @override
  Future<OfflineManager> createOfflineManager() =>
      throw Exception('The OfflineManager can not be used on web.');
}
