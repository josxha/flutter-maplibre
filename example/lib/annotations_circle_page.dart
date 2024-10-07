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
  late final MapController _controller;
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
        onMapCreated: (controller) => _controller = controller,
        onEvent: (event) async {
          if (event case MapEventClick()) {
            final screenPoint = await _controller.toScreenLocation(event.point);
            final features =
                await _controller.queryRenderedFeatures(screenPoint);
            debugPrint(features.join('\n'));
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
