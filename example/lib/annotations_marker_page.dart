import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/layers_symbol_page.dart';
import 'dart:math';

@immutable
class AnnotationsMarkerPage extends StatefulWidget {
  const AnnotationsMarkerPage({super.key});

  static const location = '/annotations/marker';

  @override
  State<AnnotationsMarkerPage> createState() => _AnnotationsMarkerPageState();
}

class _AnnotationsMarkerPageState extends State<AnnotationsMarkerPage> {
  final _points = <Point>[];
  late final MapController _controller;
  bool _imageLoaded = false;

  @override
  void initState() {
    super.initState();
    _generateRandomPoints();
  }

  void _generateRandomPoints() {
    final random = Random();
    for (int i = 0; i < 1000; i++) {
      final lat = -90.0 +
          random.nextDouble() * 180.0; // Latitude between -90.0 and 90.0
      final lon = -180.0 +
          random.nextDouble() * 360.0; // Longitude between -180.0 and 180.0
      _points.add(Point(coordinates: Position(lon, lat)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marker Annotations')),
      body: MapLibreMap(
        options: MapOptions(initZoom: 2, initCenter: Position(0.0, 0.0)),
        onEvent: (event) async {
          switch (event) {
            case MapEventMapCreated():
              _controller = event.mapController;
            case MapEventStyleLoaded():
              // add marker image to map
              final response =
                  await http.get(Uri.parse(LayersSymbolPage.imageUrl));
              final bytes = response.bodyBytes;
              await _controller.addImage('marker', bytes);
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
          MarkerAnnotationLayer(
            points: _points,
            textField: 'Marker',
            textAllowOverlap: true,
            iconAllowOverlap: true,
            iconIgnorePlacement: true,
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
