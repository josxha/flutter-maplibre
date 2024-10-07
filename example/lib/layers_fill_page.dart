import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class LayersFillPage extends StatefulWidget {
  const LayersFillPage({super.key});

  static const location = '/layers/fill';

  @override
  State<LayersFillPage> createState() => _LayersFillPageState();
}

class _LayersFillPageState extends State<LayersFillPage> {
  late final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fill Layer')),
      body: MapLibreMap(
        options: MapOptions(zoom: 7, center: Position(9.17, 47.68)),
        onMapCreated: (controller) => _controller = controller,
        onStyleLoaded: _onStyleLoaded,
        onEvent: (event) async {
          if (event case MapEventClick()) {
            final screenPoint = await _controller.toScreenLocation(event.point);
            final features =
                await _controller.queryRenderedFeatures(screenPoint);
            debugPrint(
              '${features.length} features clicked: ${features.first}',
            );
          }
        },
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
