import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class LayersMarkerPage extends StatefulWidget {
  const LayersMarkerPage({super.key});

  static const location = '/layers/marker';

  @override
  State<LayersMarkerPage> createState() => _LayersMarkerPageState();
}

class _LayersMarkerPageState extends State<LayersMarkerPage> {
  final _points = <Feature<Point>>[
    const Feature(
      geometry: Point(Geographic(lon: 9.17, lat: 47.68)),
      properties: {'name': 'Marker 1'},
    ),
    const Feature(
      geometry: Point(Geographic(lon: 9.17, lat: 48)),
      properties: {'name': 'Marker 2'},
    ),
    const Feature(
      geometry: Point(Geographic(lon: 9, lat: 48)),
      properties: {'name': 'Marker 3'},
    ),
    const Feature(
      geometry: Point(Geographic(lon: 9.5, lat: 48)),
      properties: {'name': 'Marker 4'},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marker Layers')),
      body: MapLibreMap(
        options: const MapOptions(
          initCamera: CameraUpdate.position(
            zoom: 7,
            center: Geographic(lon: 9.17, lat: 47.68),
          ),
        ),
        onClick: (event) {
          // add a new marker on click
          setState(() {
            _points.add(Feature(geometry: Point(event.point)));
          });
        },
        layers: [
          MarkerLayer(
            points: _points,
            textField: const .literal('{name}'),
            textAllowOverlap: const .literal(true),
            iconAllowOverlap: const .literal(true),
            // The map adds the image, 48 logical pixels large, to every
            // style that loads.
            icon: const .iconData(Icons.location_on, color: Colors.red),
            iconAnchor: const .literal(IconAnchor.bottom),
            textOffset: const .literal(Offset(0, 1)),
          ),
        ],
      ),
    );
  }
}
