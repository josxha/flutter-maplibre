import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class StyleLayersFillPage extends StatefulWidget {
  const StyleLayersFillPage({super.key});

  static const location = '/style-layers/fill';

  @override
  State<StyleLayersFillPage> createState() => _StyleLayersFillPageState();
}

class _StyleLayersFillPageState extends State<StyleLayersFillPage> {
  late final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fill Style Layer')),
      body: MapLibreMap(
        acceptLicense: true,
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

  Future<void> _onStyleLoaded(StyleController style) async {
    final geojsonPolygon = await rootBundle.loadString(
      'assets/geojson/lake-constance.json',
    );
    await style.addSource(
      GeoJsonSource(id: 'LakeConstance-Source', data: geojsonPolygon),
    );
    await style.addLayer(
      const FillStyleLayer(
        id: 'LakeConstance-Layer',
        sourceId: 'LakeConstance-Source',
        paint: {'fill-color': '#429ef5'},
      ),
    );
  }
}
