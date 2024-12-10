import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class LayersCirclePage extends StatefulWidget {
  const LayersCirclePage({super.key});

  static const location = '/layers/circle';

  @override
  State<LayersCirclePage> createState() => _LayersCirclePageState();
}

class _LayersCirclePageState extends State<LayersCirclePage> {
  final _points = <Point>[
    Point(coordinates: Position(9.17, 47.68)),
    Point(coordinates: Position(9.17, 48)),
    Point(coordinates: Position(9, 48)),
    Point(coordinates: Position(9.5, 48)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Circle Layers')),
      body: MapLibreMap(
        options: MapOptions(initZoom: 7, initCenter: Position(9.17, 47.68)),
        onEvent: (event) {
          if (event case MapEventClick()) {
            setState(() {
              _points.add(Point(coordinates: event.point));
            });
          }
        },
        layers: [
          CircleLayer(
            circles: Layer.generateFeatureList(_points),
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
