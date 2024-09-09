import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform_interface.dart';
import 'package:maplibre/src/web/map_controller_web.dart';

/// A web implementation of the MapLibrePlatform of the MapLibre plugin.
final class PlatformWeb extends MapLibrePlatform {
  static void registerWith(Registrar registrar) {
    MapLibrePlatform.instance = PlatformWeb();
  }

  @override
  MapControllerInternal createMapController(MapLibreMap widget) =>
      MapControllerWeb(widget);
}
