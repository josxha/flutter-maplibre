import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform_interface.dart';
import 'package:maplibre/src/web/widget_state.dart';

/// A web implementation of the MapLibrePlatform of the MapLibre plugin.
final class PlatformWeb extends PlatformInterface {
  /// This static method registers [PlatformWeb] when running on web.
  static void registerWith(Registrar registrar) =>
      PlatformInterface.instance = PlatformWeb();

  @override
  State<MapLibreMap> createWidgetState() => MapLibreMapStateWeb();
}
