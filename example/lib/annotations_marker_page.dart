import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class AnnotationsMarkerPage extends StatefulWidget {
  const AnnotationsMarkerPage({super.key});

  static const location = '/annotations/marker';

  @override
  State<AnnotationsMarkerPage> createState() => _AnnotationsMarkerPageState();
}

class _AnnotationsMarkerPageState extends State<AnnotationsMarkerPage> {
  final _points = <Point>[
    Point(coordinates: Position(9.17, 47.68)),
    Point(coordinates: Position(9.17, 48)),
    Point(coordinates: Position(9, 48)),
    Point(coordinates: Position(9.5, 48)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marker Annotations')),
      body: MapLibreMap(
        options: MapOptions(zoom: 7, center: Position(9.17, 47.68)),
        onEvent: (event) async {
          switch (event) {
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
            iconImage: 'marker',
            iconSize: 0.08,
            iconAnchor: IconAnchor.bottom,
            textOffset: const [0, 1],
          ),
        ],
      ),
    );
  }
}
