import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/style_layers_symbol_page.dart';

@immutable
class LayersMarkerPage extends StatefulWidget {
  const LayersMarkerPage({super.key});

  static const location = '/layers/marker';

  @override
  State<LayersMarkerPage> createState() => _LayersMarkerPageState();
}

class _LayersMarkerPageState extends State<LayersMarkerPage> {
  final _points = <Feature<Point>>[
    const Feature(geometry: Point(Geographic(lon: 9.17, lat: 47.68))),
    const Feature(geometry: Point(Geographic(lon: 9.17, lat: 48))),
    const Feature(geometry: Point(Geographic(lon: 9, lat: 48))),
    const Feature(geometry: Point(Geographic(lon: 9.5, lat: 48))),
  ];

  bool _imageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marker Layers')),
      body: MapLibreMap(
        options: const MapOptions(
          initZoom: 7,
          initCenter: Geographic(lon: 9.17, lat: 47.68),
        ),
        onEvent: (event) async {
          switch (event) {
            case MapEventStyleLoaded():
              // add marker image to map
              final response = await http.get(
                Uri.parse(StyleLayersSymbolPage.imageUrl),
              );
              final bytes = response.bodyBytes;
              await event.style.addImage('marker', bytes);
              setState(() {
                _imageLoaded = true;
              });
            case MapEventClick():
              // add a new marker on click
              setState(() {
                _points.add(Feature(geometry: Point(event.point)));
              });
            default:
              // ignore all other events
              break;
          }
        },
        layers: [
          MarkerLayer(
            points: _points,
            textField: 'Marker',
            textAllowOverlap: true,
            iconImage: _imageLoaded ? 'marker' : null,
            iconSize: 0.08,
            iconAnchor: IconAnchor.bottom,
            textOffset: const [0, 1],
          ),
        ],
      ),
    );
  }
}
