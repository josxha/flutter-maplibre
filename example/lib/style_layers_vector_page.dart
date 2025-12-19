import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class StyleLayersVectorPage extends StatefulWidget {
  const StyleLayersVectorPage({super.key});

  static const location = '/style-layers/vector';

  @override
  State<StyleLayersVectorPage> createState() => _StyleLayersVectorPageState();
}

class _StyleLayersVectorPageState extends State<StyleLayersVectorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Symbol Style Layer')),
      body: MapLibreMap(
        options: const MapOptions(
          initZoom: 3,
          initCenter: Geographic(lon: 9.17, lat: 47.68),
        ),
        onStyleLoaded: (style) async {
          try {
            const sourceId = 'vector_source';

            const vectorSource = VectorSource(
              id: sourceId,
              url: 'https://demotiles.maplibre.org/tiles/tiles.json',
              // sourceLayer: 'centroids', // it doesn't work too
            );
            await style.addSource(vectorSource);

            const circleLayer = CircleStyleLayer(
              id: 'circle_layer',
              sourceId: sourceId,
              paint: {
                'circle-radius': 8,
                'circle-color': '#FF6B6B',
                'circle-opacity': 0.8,
                'circle-stroke-color': '#FFF',
                'circle-stroke-width': 2,
              },
            );
            await style.addLayer(circleLayer);
          } on Exception catch (error, stacktrace) {
            debugPrint(error.toString());
            debugPrintStack(stackTrace: stacktrace);
          }
        },
      ),
    );
  }
}
