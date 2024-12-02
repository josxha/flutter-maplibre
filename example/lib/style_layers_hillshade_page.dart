import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class StyleLayersHillshadePage extends StatefulWidget {
  const StyleLayersHillshadePage({super.key});

  static const location = '/style-layers/hillshade';

  @override
  State<StyleLayersHillshadePage> createState() =>
      _StyleLayersHillshadePageState();
}

const _layerId = 'showcaseLayer';
const _sourceId = 'hills';

class _StyleLayersHillshadePageState extends State<StyleLayersHillshadePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hillshade Style Layer')),
      body: MapLibreMap(
        options:
            MapOptions(initCenter: Position(11.39085, 47.27574), initZoom: 10),
        onStyleLoaded: _onStyleLoaded,
      ),
    );
  }

  Future<void> _onStyleLoaded(StyleController style) async {
    const hillshade = RasterDemSource(
      id: _sourceId,
      url: 'https://demotiles.maplibre.org/terrain-tiles/tiles.json',
      tileSize: 256,
    );
    await style.addSource(hillshade);
    await style.addLayer(_hillshadeStyleLayer);
  }
}

const _hillshadeStyleLayer = HillshadeStyleLayer(
  id: _layerId,
  sourceId: _sourceId,
  paint: {'hillshade-shadow-color': '#473B24'},
);
