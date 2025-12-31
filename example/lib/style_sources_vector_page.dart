import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/style_layers_symbol_page.dart';

@immutable
class StyleSourcesVectorPage extends StatefulWidget {
  const StyleSourcesVectorPage({super.key});

  static const location = '/style-sources/vector';

  @override
  State<StyleSourcesVectorPage> createState() => _StyleSourcesVectorPageState();
}

class _StyleSourcesVectorPageState extends State<StyleSourcesVectorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vector Source')),
      body: MapLibreMap(
        options: const MapOptions(
          initZoom: 2,
          initCenter: Geographic(lon: 9.17, lat: 47.68),
        ),
        onStyleLoaded: (style) async {
          try {
            const sourceId = 'vector_source';

            final response = await http.get(
              Uri.parse(StyleLayersSymbolPage.imageUrl),
            );
            final bytes = response.bodyBytes;

            // add the image to the map
            await style.addImage('marker', bytes);

            const vectorSource = VectorSource(
              id: sourceId,
              url: 'https://demotiles.maplibre.org/tiles/tiles.json',
            );
            await style.addSource(vectorSource);

            const fillLayer = FillStyleLayer(
              id: 'fill_layer',
              sourceId: sourceId,
              sourceLayerId: 'countries',
              paint: {'fill-color': '#429ef5', 'fill-opacity': 0.6},
            );

            await style.addLayer(fillLayer);

            const lineLayer = LineStyleLayer(
              id: 'line_layer',
              sourceId: sourceId,
              sourceLayerId: 'countries',
              paint: {'line-color': '#00F', 'line-width': 3},
            );

            await style.addLayer(lineLayer);

            const circleLayer = CircleStyleLayer(
              id: 'circle_layer',
              sourceId: sourceId,
              sourceLayerId: 'centroids',
              paint: {
                'circle-radius': 18,
                'circle-color': '#000000',
                'circle-opacity': 0.5,
                'circle-stroke-color': '#FFF',
                'circle-stroke-width': 2,
              },
            );
            await style.addLayer(circleLayer);

            const symbolLayer = SymbolStyleLayer(
              id: 'images_layer',
              sourceId: sourceId,
              sourceLayerId: 'centroids',
              layout: {
                'icon-image': 'marker',
                'icon-size': 0.18,
                'icon-allow-overlap': true,
                'icon-anchor': 'bottom',
              },
            );
            await style.addLayer(symbolLayer);
          } on Exception catch (error, stacktrace) {
            debugPrint(error.toString());
            debugPrintStack(stackTrace: stacktrace);
          }
        },
      ),
    );
  }
}
