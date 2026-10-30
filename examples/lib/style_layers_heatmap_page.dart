import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class StyleLayersHeatmapPage extends StatefulWidget {
  const StyleLayersHeatmapPage({super.key});

  static const location = '/style-layers/heatmap';

  @override
  State<StyleLayersHeatmapPage> createState() => _StyleLayersHeatmapPageState();
}

const _layerId = 'showcaseLayer';
const _sourceId = 'earthquakes';

class _StyleLayersHeatmapPageState extends State<StyleLayersHeatmapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Heatmap Style Layer')),
      body: MapLibreMap(
        options: const MapOptions(
          initCamera: InitialCamera.position(
            center: Geographic(lon: -120, lat: 50),
            zoom: 2,
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
    await style.layers.add(_heatmapStyleLayer);
  }
}

final _heatmapStyleLayer = HeatmapStyleLayer(
  id: _layerId,
  sourceId: _sourceId,
  // Increase the heatmap weight based on frequency and property magnitude
  weight: .interpolate(const .linear(), .get('mag').asNumber(), {
    0: const .literal(0),
    6: const .literal(1),
  }),
  // Increase the heatmap color weight weight by zoom level
  // intensity is a multiplier on top of weight
  intensity: .interpolate(const .linear(), .zoom(), {
    0: const .literal(1),
    9: const .literal(3),
  }),
  // Color ramp for heatmap.  Domain is 0 (low) to 1 (high).
  // Begin color ramp at 0-stop with a 0-transparency color
  // to create a blur-like effect.
  color: .interpolate(const .linear(), .heatmapDensity(), {
    0: const .literal(Color(0x002166AC)),
    0.2: const .literal(Color(0xFF67A9CF)),
    0.4: const .literal(Color(0xFFD1E5F0)),
    0.6: const .literal(Color(0xFFFDDBC7)),
    0.8: const .literal(Color(0xFFEF8A62)),
    1: const .literal(Color(0xFFB2182B)),
  }),
  // Adjust the heatmap radius by zoom level
  radius: .interpolate(const .linear(), .zoom(), {
    0: const .literal(2),
    9: const .literal(20),
  }),
  // Transition from heatmap to circle layer by zoom level
  opacity: .interpolate(const .linear(), .zoom(), {
    7: const .literal(1),
    9: const .literal(0),
  }),
);
