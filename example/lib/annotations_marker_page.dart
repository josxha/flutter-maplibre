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
  final _layer = MarkerAnnotationLayer(
    points: <Point>[
      Point(coordinates: Position(9.17, 47.68)),
      Point(coordinates: Position(9.17, 48)),
      Point(coordinates: Position(9, 48)),
      Point(coordinates: Position(9.5, 48)),
    ],
    textField: 'Marker',
    textAllowOverlap: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marker Annotations')),
      body: MapLibreMap(
        options: MapOptions(zoom: 7, center: Position(9.17, 47.68)),
        onEvent: (event) {
          if (event case MapEventClick()) {
            setState(() {
              _layer.list.add(Point(coordinates: event.point));
            });
          }
        },
        layers: [_layer],
      ),
    );
  }
}
