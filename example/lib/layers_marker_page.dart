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
  final _points = <Point>[
    Point(coordinates: Position(9.17, 47.68)),
    Point(coordinates: Position(9.17, 48)),
    Point(coordinates: Position(9, 48)),
    Point(coordinates: Position(9.5, 48)),
  ];

  bool _imageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marker Layers')),
      body: MapLibreMap(
        options: MapOptions(initZoom: 7, initCenter: Position(9.17, 47.68)),
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
                _points.add(Point(coordinates: event.point));
              });
            default:
              // ignore all other events
              break;
          }
        },
        layers: [
          MarkerLayer(
            markers: Layer.generateFeatureList(_points),
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
