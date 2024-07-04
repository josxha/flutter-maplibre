import 'package:flutter/widgets.dart';
import 'package:maplibre/src/maplibre_platform_interface.dart';

class MapLibreMap extends StatefulWidget {
  const MapLibreMap({
    this.style = 'https://demotiles.maplibre.org/style.json',
    super.key,
  });

  final String style;

  @override
  State<MapLibreMap> createState() => _MapLibreMapState();
}

class _MapLibreMapState extends State<MapLibreMap> {
  @override
  Widget build(BuildContext context) {
    return MapLibrePlatform.instance.buildWidget();
  }
}
