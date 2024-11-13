// ignore_for_file: require_trailing_commas

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/styled_map_page.dart';

@immutable
class LayersFillExtrusionPage extends StatefulWidget {
  const LayersFillExtrusionPage({super.key});

  static const location = '/layers/fill-extrusion';

  @override
  State<LayersFillExtrusionPage> createState() =>
      _LayersFillExtrusionPageState();
}

const _sourceId = 'floorplan';

class _LayersFillExtrusionPageState extends State<LayersFillExtrusionPage> {
  late final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fill Extrusion Layer')),
      body: MapLibreMap(
        options: MapOptions(
          initCenter: Position(-87.61694, 41.86625),
          initZoom: 15.99,
          initPitch: 40,
          initBearing: 20,
          initStyle: StyledMapPage.styleUrl,
        ),
        onMapCreated: (controller) => _controller = controller,
        onStyleLoaded: _onStyleLoaded,
      ),
    );
  }

  Future<void> _onStyleLoaded() async {
    await _controller.addSource(
      const GeoJsonSource(
        id: _sourceId,
        data:
            'https://maplibre.org/maplibre-gl-js/docs/assets/indoor-3d-map.geojson',
      ),
    );
    await _controller.addLayer(_fillExtrusionStyleLayer);
  }
}

const _fillExtrusionStyleLayer = FillExtrusionStyleLayer(
  id: 'room-extrusion',
  sourceId: _sourceId,
  paint: {
    // See the MapLibre Style Specification for details on data expressions.
    // https://maplibre.org/maplibre-style-spec/expressions/

    // Get the fill-extrusion-color from the source 'color' property.
    'fill-extrusion-color': ['get', 'color'],

    // Get fill-extrusion-height from the source 'height' property.
    'fill-extrusion-height': ['get', 'height'],

    // Get fill-extrusion-base from the source 'base_height' property.
    'fill-extrusion-base': ['get', 'base_height'],

    // Make extrusions slightly opaque for see through indoor walls.
    'fill-extrusion-opacity': 0.5
  },
);
