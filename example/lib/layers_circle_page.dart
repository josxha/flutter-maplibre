// ignore_for_file: require_trailing_commas

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class LayersCirclePage extends StatefulWidget {
  const LayersCirclePage({super.key});

  static const location = '/layers/circle';

  @override
  State<LayersCirclePage> createState() => _LayersCirclePageState();
}

const _layerId = 'showcaseLayer';
const _sourceId = 'earthquakes';

class _LayersCirclePageState extends State<LayersCirclePage> {
  late final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Circle Layer')),
      body: MapLibreMap(
        options: MapOptions(
          center: Position(-152.9959, 59.8150),
          zoom: 9,
        ),
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
    await _controller.addLayer(_circleLayer);
  }
}

const _circleLayer = CircleLayer(
  id: _layerId,
  sourceId: _sourceId,
  paint: {
    // Size circle radius by earthquake magnitude and zoom level
    'circle-radius': [
      'interpolate',
      ['linear'],
      ['zoom'],
      7,
      [
        'interpolate',
        ['linear'],
        ['get', 'mag'],
        1,
        1,
        6,
        4
      ],
      16,
      [
        'interpolate',
        ['linear'],
        ['get', 'mag'],
        1,
        5,
        6,
        50
      ]
    ],
    // Color circle by earthquake magnitude
    'circle-color': [
      'interpolate',
      ['linear'],
      ['get', 'mag'],
      1,
      'rgba(33,102,172,0)',
      2,
      'rgb(103,169,207)',
      3,
      'rgb(209,229,240)',
      4,
      'rgb(253,219,199)',
      5,
      'rgb(239,138,98)',
      6,
      'rgb(178,24,43)'
    ],
    'circle-stroke-color': 'white',
    'circle-stroke-width': 1,
    // Transition from heatmap to circle layer by zoom level
    'circle-opacity': [
      'interpolate',
      ['linear'],
      ['zoom'],
      7,
      0,
      8,
      1
    ]
  },
);
