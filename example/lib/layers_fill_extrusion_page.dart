import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class LayersFillExtrusionPage extends StatefulWidget {
  const LayersFillExtrusionPage({super.key});

  static const location = '/layers/fill-extrusion';

  @override
  State<LayersFillExtrusionPage> createState() =>
      _LayersFillExtrusionPageState();
}

const _layerId = 'showcaseLayer';
const _sourceId = 'hills';

class _LayersFillExtrusionPageState extends State<LayersFillExtrusionPage> {
  late final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fill Extrusion Layer')),
      body: MapLibreMap(
        options: MapOptions(
          center: Position(11.39085, 47.27574),
          zoom: 10,
        ),
        onMapCreated: (controller) => _controller = controller,
        onStyleLoaded: _onStyleLoaded,
      ),
    );
  }

  Future<void> _onStyleLoaded() async {
    final geojsonPolygon =
        await rootBundle.loadString('assets/geojson/lake-constance.json');
    await _controller.addSource(
      GeoJsonSource(id: 'LakeConstance', data: geojsonPolygon),
    );
    await _controller.addLayer(
      const FillLayer(
        id: 'geojson-fill',
        sourceId: 'LakeConstance',
        paint: {'fill-color': '#429ef5'},
      ),
    );
  }
}

// TODO fill extrusion layer
// TODO line layer
