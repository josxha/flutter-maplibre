import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class AnnotationsMarkerPage extends StatefulWidget {
  const AnnotationsMarkerPage({super.key});

  static const location = '/annotations/marker';

  @override
  State<AnnotationsMarkerPage> createState() => _AnnotationsMarkerPageState();
}

class _AnnotationsMarkerPageState extends State<AnnotationsMarkerPage> {
  final _layer = MarkerAnnotationLayer(
    points: <Point>[
      Point(coordinates: Position(9.17, 47.68)),
      Point(coordinates: Position(9.17, 48)),
      Point(coordinates: Position(9, 48)),
      Point(coordinates: Position(9.5, 48)),
    ],
    textField: 'Marker',
    textAllowOverlap: true,
    iconImage: 'marker',
    iconSize: 0.5,
    iconAnchor: IconAnchor.bottom,
    textOffset: const [0, 1],
  );

  late final MapController _controller;

  final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marker Annotations')),
      body: Stack(
        children: [
          MapLibreMap(
            options: MapOptions(zoom: 7, center: Position(9.17, 47.68)),
            onEvent: (event) async {
              switch (event) {
                case MapEventMapCreated():
                  _controller = event.mapController;
                case MapEventStyleLoaded():
                  // add marker image to map
                  /*final response =
                      await http.get(Uri.parse(LayersSymbolPage.imageUrl));
                  final bytes = response.bodyBytes;*/
                  final boundary = _globalKey.currentContext!
                      .findRenderObject()! as RenderRepaintBoundary;
                  final image = await boundary.toImage();
                  final byteData =
                      await image.toByteData(format: ImageByteFormat.png);
                  final pngBytes = byteData!.buffer.asUint8List();
                  await _controller.addImage('marker', pngBytes);
                case MapEventClick():
                  // add a new marker on click
                  setState(() {
                    _layer.list.add(Point(coordinates: event.point));
                  });
                default:
                  // ignore all other events
                  break;
              }
            },
            layers: [_layer],
          ),
          Positioned(
            left: -1000000000,
            child: RepaintBoundary(
              key: _globalKey,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
