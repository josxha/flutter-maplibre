import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class AnnotationsPolygonPage extends StatefulWidget {
  const AnnotationsPolygonPage({super.key});

  static const location = '/annotations/polygon';

  @override
  State<AnnotationsPolygonPage> createState() => _AnnotationsPolygonPageState();
}

class _AnnotationsPolygonPageState extends State<AnnotationsPolygonPage> {
  final _polygon = <PolygonAnnotation>[
    PolygonAnnotation(points: [Position(9.17, 47.68)]),
    PolygonAnnotation(points: [Position(9.17, 48)]),
    PolygonAnnotation(points: [Position(9, 48)]),
    PolygonAnnotation(points: [Position(9.5, 48)]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Polygon Annotations')),
      body: MapLibreMap(
        options: MapOptions(zoom: 7, center: Position(9.17, 47.68)),
        onEvent: (event) {
          if (event case MapEventClick()) {
            setState(() {
              _polygon.add(PolygonAnnotation(points: [event.point]));
            });
          }
        },
        layers: [
          PolygonAnnotationLayer(polygons: _polygon),
        ],
      ),
    );
  }
}