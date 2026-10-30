import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class StyleLayersCirclePage extends StatefulWidget {
  const StyleLayersCirclePage({super.key});

  static const location = '/style-layers/circle';

  @override
  State<StyleLayersCirclePage> createState() => _StyleLayersCirclePageState();
}

const _layerId = 'showcaseLayer';
const _sourceId = 'earthquakes';

class _StyleLayersCirclePageState extends State<StyleLayersCirclePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Circle Style Layer')),
      body: MapLibreMap(
        options: const MapOptions(
          initCamera: InitialCamera.position(
            center: Geographic(lon: -152.9959, lat: 59.8150),
            zoom: 9,
          ),
        ),
        onStyleLoaded: _onStyleLoaded,
      ),
    );
  }

  Future<void> _onStyleLoaded(StyleController style) async {
    const earthquakes = GeoJsonSource.url(
      id: _sourceId,
      url:
          'https://maplibre.org/maplibre-gl-js/docs/assets/earthquakes.geojson',
    );
    await style.sources.add(earthquakes);
    await style.layers.add(_circleStyleLayer);
  }
}

final _circleStyleLayer = CircleStyleLayer(
  id: _layerId,
  sourceId: _sourceId,
  // Size circle radius by earthquake magnitude and zoom level
  radius: .interpolate(const .linear(), .zoom(), {
    7: .interpolate(const .linear(), .get('mag').asNumber(), {
      1: const .literal(1),
      6: const .literal(50),
    }),
  }),
  // Color circle by earthquake magnitude
  color: .interpolate(const .linear(), .get('mag').asNumber(), {
    1: const .literal(Color(0x002166AC)),
    2: const .literal(Color(0xFF67A9CF)),
    3: const .literal(Color(0xFFD1E5F0)),
    4: const .literal(Color(0xFFFDDBC7)),
    5: const .literal(Color(0xFFEF8A62)),
    6: const .literal(Color(0xFFB2182B)),
  }),
  strokeColor: const .literal(Color(0xFFFFFFFF)),
  strokeWidth: const .literal(1),
  // Transition from heatmap to circle layer by zoom level
  opacity: .interpolate(const .linear(), .zoom(), {
    7: const .literal(0),
    8: const .literal(1),
  }),
);
