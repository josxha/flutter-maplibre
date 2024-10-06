import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class AnnotationsCirclePage extends StatefulWidget {
  const AnnotationsCirclePage({super.key});

  static const location = '/annotations/circle';

  @override
  State<AnnotationsCirclePage> createState() => _AnnotationsCirclePageState();
}

class _AnnotationsCirclePageState extends State<AnnotationsCirclePage> {
  final _points = <Point>[
    Point(coordinates: Position(9.17, 47.68)),
    Point(coordinates: Position(9.17, 48)),
    Point(coordinates: Position(9, 48)),
    Point(coordinates: Position(9.5, 48)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Circle Annotations')),
      body: MapLibreMap(
        options: MapOptions(zoom: 7, center: Position(9.17, 47.68)),
        onEvent: (event) {
          if (event case MapEventClick()) {
            setState(() {
              _points.add(Point(coordinates: event.point));
            });
          }
        },
        layers: [
          CircleAnnotationLayer(
            points: _points,
            color: Colors.orange.withOpacity(0.5),
            radius: 20,
            strokeColor: Colors.red,
            strokeWidth: 2,
          ),
        ],
      ),
    );
  }
}
