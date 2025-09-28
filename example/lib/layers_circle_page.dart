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
  final _points = <Feature<Point>>[
    const Feature(geometry: Point(Geographic(lon: 9.17, lat: 47.68))),
    const Feature(geometry: Point(Geographic(lon: 9.17, lat: 48))),
    const Feature(geometry: Point(Geographic(lon: 9, lat: 48))),
    const Feature(geometry: Point(Geographic(lon: 9.5, lat: 48))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Circle Layers')),
      body: MapLibreMap(
        options: const MapOptions(
          initZoom: 7,
          initCenter: Geographic(lon: 9.17, lat: 47.68),
        ),
        onEvent: (event) {
          if (event case MapEventClick()) {
            setState(() {
              _points.add(Feature(geometry: Point(event.point)));
            });
          }
        },
        layers: [
          CircleLayer(
            points: _points,
            color: Colors.orange.withValues(alpha: 0.5),
            radius: 20,
            strokeColor: Colors.red,
            strokeWidth: 2,
          ),
        ],
      ),
    );
  }
}
