import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/utils/map_styles.dart';

@immutable
class StyleLayersSymbolVectorSourcePage extends StatefulWidget {
  const StyleLayersSymbolVectorSourcePage({super.key});

  static const location = '/style-layers/symbol-vector-source';

  @override
  State<StyleLayersSymbolVectorSourcePage> createState() =>
      _StyleLayersSymbolVectorSourcePageState();
}

class _StyleLayersSymbolVectorSourcePageState
    extends State<StyleLayersSymbolVectorSourcePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Symbol Style Layer (Vector Source)')),
      body: MapLibreMap(
        options: MapOptions(
          initZoom: 3,
          initCenter: const Geographic(lon: 9.17, lat: 47.68),
          initStyle: MapStyles.countries.uri,
        ),
        onStyleLoaded: (style) async {
          // add the vector source
          const sourceId = 'vector_source';
          const vectorSource = VectorSource(
            id: sourceId,
            url: 'https://demotiles.maplibre.org/tiles/tiles.json',
          );
          await style.addSource(vectorSource);

          // display the image on the map
          await style.addLayer(
            const SymbolStyleLayer(
              id: 'centroid-labels',
              sourceId: sourceId,
              sourceLayerId: 'centroids',
              layout: {
                'icon-allow-overlap': true,
                'text-field': '{NAME}',
              },
            ),
          );
        },
      ),
    );
  }
}
