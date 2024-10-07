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
  final _polygons = <Polygon>[
    Polygon(
      coordinates: [
        [
          Position(9.17, 47.68),
          Position(9.5, 48),
          Position(9, 48),
        ],
      ],
    ),
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
              _polygons.first.coordinates.first.add(event.point);
            });
          }
        },
        layers: [
          PolygonAnnotationLayer(
            polygons: _polygons,
            color: Colors.lightBlueAccent.withOpacity(0.6),
            outlineColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
