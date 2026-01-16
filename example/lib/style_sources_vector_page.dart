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

            final fillLayer = FillStyleLayer(
              id: 'fill_layer',
              sourceId: sourceId,
              sourceLayerId: 'countries',
              color: const PropertyValue.value(Color(0xFF429ef5)),
              opacity: const PropertyValue.value(0.6),
            );

            await style.addLayer(fillLayer);

            final lineLayer = LineStyleLayer(
              id: 'line_layer',
              sourceId: sourceId,
              sourceLayerId: 'countries',
              color: const PropertyValue.value(Colors.blue),
              width: const PropertyValue.value(3),
            );

            await style.addLayer(lineLayer);

            final circleLayer = CircleStyleLayer(
              id: 'circle_layer',
              sourceId: sourceId,
              sourceLayerId: 'centroids',
              radius: const PropertyValue.value(18),
              opacity: const PropertyValue.value(0.5),
              strokeColor: const PropertyValue.value(Colors.white),
              strokeWidth: const PropertyValue.value(2),
            );
            await style.addLayer(circleLayer);

            final symbolLayer = SymbolStyleLayer(
              id: 'images_layer',
              sourceId: sourceId,
              sourceLayerId: 'centroids',
              iconImage: const PropertyValue.value('marker'),
              iconSize: const PropertyValue.value(0.18),
              iconAllowOverlap: const PropertyValue.value(true),
              iconAnchor: const PropertyValue.value(IconAnchor.bottom),
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
