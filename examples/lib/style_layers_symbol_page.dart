import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maplibre/maplibre.dart';

@immutable
class StyleLayersSymbolPage extends StatefulWidget {
  const StyleLayersSymbolPage({super.key});

  static const location = '/style-layers/symbol';
  static const imageUrl =
      'https://upload.wikimedia.org/wikipedia/commons/f/f2/678111-map-marker-512.png';

  @override
  State<StyleLayersSymbolPage> createState() => _StyleLayersSymbolPageState();
}

class _StyleLayersSymbolPageState extends State<StyleLayersSymbolPage> {
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
            // load the image data
            final response = await http.get(
              Uri.parse(StyleLayersSymbolPage.imageUrl),
            );
            final bytes = response.bodyBytes;

            // add the image to the map
            await style.addImage('marker', bytes);

            // add some points as GeoJSON source to the map
            final geoJson = FeatureCollection(
              const [
                Feature(
                  geometry: Point(Geographic(lon: 7.448871, lat: 46.947792)),
                  properties: {'name': 'Bern'},
                ),
                Feature(
                  geometry: Point(Geographic(lon: -0.110273, lat: 51.549851)),
                  properties: {'name': 'London'},
                ),
                Feature(
                  geometry: Point(Geographic(lon: 13.352826, lat: 52.572783)),
                  properties: {'name': 'Berlin'},
                ),
                Feature(
                  geometry: Point(Geographic(lon: 12.483543, lat: 41.940751)),
                  properties: {'name': 'Rome'},
                ),
              ]
            ).toText();
            await style.addSource(
              GeoJsonSource(id: 'points', data: geoJson),
            );

            // display the image on the map
            await style.addLayer(
              SymbolStyleLayer(
                id: 'images',
                sourceId: 'points',
                // see https://maplibre.org/maplibre-style-spec/layers/#symbol
                iconImage: const PropertyValue.value('marker'),
                iconSize: const PropertyValue.value(0.2),
                iconAllowOverlap: const PropertyValue.value(true),
                iconAnchor: const PropertyValue.value(IconAnchor.bottom),
                textField: const PropertyValue.value('{name}'),
                textOffset: const PropertyValue.value(Offset(0, 1)),
              ),
            );
          } on Exception catch (error, stacktrace) {
            debugPrint(error.toString());
            debugPrintStack(stackTrace: stacktrace);
          }
        },
      ),
    );
  }
}
