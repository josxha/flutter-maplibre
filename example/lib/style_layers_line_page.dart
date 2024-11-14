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
  late final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Line Style Layer')),
      body: MapLibreMap(
        options: MapOptions(initZoom: 7, initCenter: Position(9.17, 47.68)),
        onMapCreated: (controller) => _controller = controller,
        onStyleLoaded: _onStyleLoaded,
      ),
    );
  }

  Future<void> _onStyleLoaded() async {
    final geojsonLine = await rootBundle.loadString('assets/geojson/path.json');
    await _controller.addSource(
      GeoJsonSource(id: 'Path', data: geojsonLine),
    );
    await _controller.addLayer(
      const LineStyleLayer(
        id: 'geojson-line',
        sourceId: 'Path',
        paint: {'line-color': '#F00', 'line-width': 3},
      ),
    );
  }
}
