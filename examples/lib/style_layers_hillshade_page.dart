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

class _StyleLayersHillshadePageState extends State<StyleLayersHillshadePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hillshade Style Layer')),
      body: MapLibreMap(
        options: const MapOptions(
          initCenter: Geographic(lon: 11.39085, lat: 47.27574),
          initZoom: 10,
        ),
        onStyleLoaded: _onStyleLoaded,
      ),
    );
  }

  Future<void> _onStyleLoaded(StyleController style) async {
    const sourceId = 'hills';
    const hillshade = RasterDemSource(
      id: sourceId,
      url: 'https://demotiles.maplibre.org/terrain-tiles/tiles.json',
      tileSize: 256,
    );
    await style.addSource(hillshade);
    final hillshadeLayer = HillshadeStyleLayer(
      id: 'showcaseLayer',
      sourceId: sourceId,
      shadowColor: const PropertyValue.value(Color(0xFF473B24)),
    );

    await style.addLayer(hillshadeLayer);
  }
}
