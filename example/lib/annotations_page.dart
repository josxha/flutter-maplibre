import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Annotations')),
      body: MapLibreMap(
        options: MapOptions(zoom: 7, center: Position(9.17, 47.68)),
        onMapCreated: (controller) => _controller = controller,
        onStyleLoaded: () async {
          if (kIsWeb) {
            // This kind of Marker is only supported on web
            final _ = await _controller.addMarker(
              Marker(point: Position(9, 47)),
            );
          }
        },
      ),
    );
  }
}
