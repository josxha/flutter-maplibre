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
        options: MapOptions(initZoom: 7, initCenter: Position(9.17, 47.68)),
        onMapCreated: (controller) => _controller = controller,
        onStyleLoaded: _onStyleLoaded,
        onEvent: (event) async {
          if (event case MapEventClick()) {
            final screenPoint = await _controller.toScreenLocation(event.point);
            final features = await _controller.queryLayers(screenPoint);
            debugPrint(
              '${features.length} layers clicked\n'
              '${features.join('\n')}',
            );
            if (context.mounted) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      '${features.length} layers clicked: '
                      '${features.map((e) => e.layerId).join(', ')}',
                    ),
                  ),
                );
            }
          }
        },
      ),
    );
  }

  Future<void> _onStyleLoaded() async {
    final geojsonPolygon =
        await rootBundle.loadString('assets/geojson/lake-constance.json');
    await _controller.addSource(
      GeoJsonSource(id: 'LakeConstance-Source', data: geojsonPolygon),
    );
    await _controller.addLayer(
      const FillStyleLayer(
        id: 'LakeConstance-Layer',
        sourceId: 'LakeConstance-Source',
        paint: {'fill-color': '#429ef5'},
      ),
    );
  }
}
