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
        acceptLicense: true,
        options: MapOptions(initZoom: 7, initCenter: Position(9.17, 47.68)),
        onStyleLoaded: _onStyleLoaded,
      ),
    );
  }

  Future<void> _onStyleLoaded(StyleController style) async {
    final geojsonLine = await rootBundle.loadString('assets/geojson/path.json');
    await style.addSource(
      GeoJsonSource(id: 'Path', data: geojsonLine),
    );
    await style.addLayer(
      const LineStyleLayer(
        id: 'geojson-line',
        sourceId: 'Path',
        paint: {'line-color': '#F00', 'line-width': 3},
      ),
    );
  }
}
