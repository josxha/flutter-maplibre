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
        acceptLicense: true,
        options: MapOptions(initZoom: 3, initCenter: Position(9.17, 47.68)),
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
            await style.addSource(
              const GeoJsonSource(id: 'points', data: _geoJsonString),
            );

            // display the image on the map
            await style.addLayer(
              const SymbolStyleLayer(
                id: 'images',
                sourceId: 'points',
                layout: {
                  // see https://maplibre.org/maplibre-style-spec/layers/#symbol
                  'icon-image': 'marker',
                  'icon-size': 0.08,
                  'icon-allow-overlap': true,
                  'icon-anchor': 'bottom',
                },
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

const _geoJsonString = '''
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "coordinates": [
          8.532443386754125,
          47.381666653596795
        ],
        "type": "Point"
      }
    },
    {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "coordinates": [
          -0.11027386926130589,
          51.5498511494217
        ],
        "type": "Point"
      }
    },
    {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "coordinates": [
          13.352826080643723,
          52.57278382732386
        ],
        "type": "Point"
      }
    },
    {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "coordinates": [
          12.483543026945483,
          41.94075185567311
        ],
        "type": "Point"
      }
    }
  ]
}''';
