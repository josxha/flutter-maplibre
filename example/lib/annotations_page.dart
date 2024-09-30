import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class AnnotationsPage extends StatefulWidget {
  const AnnotationsPage({super.key});

  static const location = '/annotations';

  @override
  State<AnnotationsPage> createState() => _AnnotationsPageState();
}

class _AnnotationsPageState extends State<AnnotationsPage> {
  late final MapController _controller;
  final _markers = <Marker>[
    Marker(point: Position(9.17, 47.68)),
    Marker(point: Position(9.17, 48)),
    Marker(point: Position(9, 48)),
    Marker(point: Position(9.5, 48)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Annotations')),
      body: MapLibreMap(
        options: MapOptions(zoom: 7, center: Position(9.17, 47.68)),
        onMapCreated: (controller) => _controller = controller,
        onEvent: (event) {
          if (event case MapEventClick()) {
            setState(() {
              _markers.add(Marker(point: event.point));
            });
          }
        },
        layers: [
          MarkerAnnotationLayer(markers: _markers),
        ],
      ),
    );
  }
}
