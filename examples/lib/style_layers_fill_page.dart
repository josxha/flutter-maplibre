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
  static const _layerId = 'LakeConstance-Layer';

  late final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fill Style Layer')),
      body: MapLibreMap(
        options: const MapOptions(
          initCamera: InitialCamera.position(
            zoom: 7,
            center: Geographic(lon: 9.17, lat: 47.68),
          ),
        ),
        onMapCreated: (controller) => _controller = controller,
        onStyleLoaded: _onStyleLoaded,
        onEvent: (event) async {
          if (event case MapEventClick()) {
            final screenPoint = _controller.toScreenLocation(event.point);
            final features = await _controller.featuresAtPoint(
              screenPoint,
              layerIds: [_layerId],
            );
            if (context.mounted) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      features.isEmpty
                          ? 'Clicked outside of Lake Constance'
                          : 'Clicked on Lake Constance',
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
    await style.sources.add(
      GeoJsonSource.data(id: 'LakeConstance-Source', data: geojsonPolygon),
    );
    await style.layers.add(
      FillStyleLayer(
        id: _layerId,
        sourceId: 'LakeConstance-Source',
        color: const .literal(Color(0xFF429EF5)),
      ),
    );
  }
}
