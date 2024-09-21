import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class LayersLinePage extends StatefulWidget {
  const LayersLinePage({super.key});

  static const location = '/layers/line';

  @override
  State<LayersLinePage> createState() => _LayersLinePageState();
}

class _LayersLinePageState extends State<LayersLinePage> {
  late final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Line Layer')),
      body: MapLibreMap(
        options: MapOptions(zoom: 7, center: Position(9.17, 47.68)),
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
      const LineLayer(
        id: 'geojson-line',
        sourceId: 'Path',
        paint: {'line-color': '#F00', 'line-width': 3},
      ),
    );
  }
}

// TODO fill extrusion layer
// TODO line layer
