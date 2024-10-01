import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class AnnotationsPolylinePage extends StatefulWidget {
  const AnnotationsPolylinePage({super.key});

  static const location = '/annotations';

  @override
  State<AnnotationsPolylinePage> createState() => _AnnotationsPolylinePageState();
}

class _AnnotationsPolylinePageState extends State<AnnotationsPolylinePage> {
  final _polylines = <LineString>[
    LineString(coordinates: [Position(9.17, 47.68)]),
    LineString(coordinates: [Position(9.17, 48)]),
    LineString(coordinates: [Position(9, 48)]),
    LineString(coordinates: [Position(9.5, 48)]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Polyline Annotations')),
      body: MapLibreMap(
        options: MapOptions(zoom: 7, center: Position(9.17, 47.68)),
        onEvent: (event) {
          if (event case MapEventClick()) {
            setState(() {
              _polylines.add(LineString(coordinates: [event.point]));
            });
          }
        },
        layers: [
          PolylineAnnotationLayer(polylines: _polylines),
        ],
      ),
    );
  }
}
