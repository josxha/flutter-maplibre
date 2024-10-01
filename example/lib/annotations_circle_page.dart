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
  final _circles = <CircleAnnotation>[
    CircleAnnotation(point: Position(9.17, 47.68)),
    CircleAnnotation(point: Position(9.17, 48)),
    CircleAnnotation(point: Position(9, 48)),
    CircleAnnotation(point: Position(9.5, 48)),
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
              _circles.add(CircleAnnotation(point: event.point));
            });
          }
        },
        layers: [
          CircleAnnotationLayer(circles: _circles),
        ],
      ),
    );
  }
}