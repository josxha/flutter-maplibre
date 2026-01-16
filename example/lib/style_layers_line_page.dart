import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class StyleLayersLinePage extends StatefulWidget {
  const StyleLayersLinePage({super.key});

  static const location = '/style-layers/line';

  @override
  State<StyleLayersLinePage> createState() => _StyleLayersLinePageState();
}

class _StyleLayersLinePageState extends State<StyleLayersLinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Line Style Layer')),
      body: MapLibreMap(
        options: const MapOptions(
          initZoom: 7,
          initCenter: Geographic(lon: 9.17, lat: 47.68),
        ),
        onStyleLoaded: _onStyleLoaded,
      ),
    );
  }

  Future<void> _onStyleLoaded(StyleController style) async {
    final geojsonLine = await rootBundle.loadString('assets/geojson/path.json');
    await style.addSource(GeoJsonSource(id: 'Path', data: geojsonLine));
    await style.addLayer(
      LineStyleLayer(
        id: 'geojson-line',
        sourceId: 'Path',
        color: const PropertyValue.value(Colors.red),
        width: const PropertyValue.value(3),
      ),
    );
  }
}
