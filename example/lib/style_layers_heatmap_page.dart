// ignore_for_file: require_trailing_commas

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
  late final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Heatmap Style Layer')),
      body: MapLibreMap(
        options: MapOptions(initCenter: Position(-120, 50), initZoom: 2),
        onMapCreated: (controller) => _controller = controller,
        onStyleLoaded: _onStyleLoaded,
      ),
    );
  }

  Future<void> _onStyleLoaded() async {
    const earthquakes = GeoJsonSource(
      id: _sourceId,
      data:
          'https://maplibre.org/maplibre-gl-js/docs/assets/earthquakes.geojson',
    );
    await _controller.addSource(earthquakes);
    await _controller.addLayer(_heatmapStyleLayer);
  }
}

const _heatmapStyleLayer = HeatmapStyleLayer(
  id: _layerId,
  sourceId: _sourceId,
  paint: {
    // Increase the heatmap weight based on frequency and property magnitude
    'heatmap-weight': [
      'interpolate',
      ['linear'],
      ['get', 'mag'],
      0,
      0,
      6,
      1
    ],
    // Increase the heatmap color weight weight by zoom level
    // heatmap-intensity is a multiplier on top of heatmap-weight
    'heatmap-intensity': [
      'interpolate',
      ['linear'],
      ['zoom'],
      0,
      1,
      9,
      3
    ],
    // Color ramp for heatmap.  Domain is 0 (low) to 1 (high).
    // Begin color ramp at 0-stop with a 0-transparency color
    // to create a blur-like effect.
    'heatmap-color': [
      'interpolate',
      ['linear'],
      ['heatmap-density'],
      0,
      'rgba(33,102,172,0)',
      0.2,
      'rgb(103,169,207)',
      0.4,
      'rgb(209,229,240)',
      0.6,
      'rgb(253,219,199)',
      0.8,
      'rgb(239,138,98)',
      1,
      'rgb(178,24,43)'
    ],
    // Adjust the heatmap radius by zoom level
    'heatmap-radius': [
      'interpolate',
      ['linear'],
      ['zoom'],
      0,
      2,
      9,
      20
    ],
    // Transition from heatmap to circle layer by zoom level
    'heatmap-opacity': [
      'interpolate',
      ['linear'],
      ['zoom'],
      7,
      1,
      9,
      0
    ]
  },
);
