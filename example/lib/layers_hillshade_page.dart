// ignore_for_file: prefer_single_quotes, require_trailing_commas

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class LayersHillshadePage extends StatefulWidget {
  const LayersHillshadePage({super.key});

  static const location = '/layers/hillshade';

  @override
  State<LayersHillshadePage> createState() => _LayersHillshadePageState();
}

const _layerId = 'showcaseLayer';
const _sourceId = 'hills';

class _LayersHillshadePageState extends State<LayersHillshadePage> {
  late final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hillshade Layer')),
      body: MapLibreMap(
        options: MapOptions(
          center: Position(11.39085, 47.27574),
          zoom: 10,
          onClick: (point) => debugPrint('${point.lng}, ${point.lat}'),
        ),
        onMapCreated: (controller) => _controller = controller,
        onStyleLoaded: _onStyleLoaded,
      ),
    );
  }

  Future<void> _onStyleLoaded() async {
    const hillshade = RasterDemSource(
      id: _sourceId,
      url: 'https://demotiles.maplibre.org/terrain-tiles/tiles.json',
      tileSize: 256,
    );
    await _controller.addSource(hillshade);
    await _controller.addLayer(_hillshadeLayer);
  }
}

// TODO fill layer
// TODO fill extrusion layer
// TODO line layer

const _hillshadeLayer = HillshadeLayer(
  id: _layerId,
  sourceId: _sourceId,
  paint: {'hillshade-shadow-color': '#473B24'},
);
