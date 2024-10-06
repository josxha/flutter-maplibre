import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class AnnotationsMixedPage extends StatefulWidget {
  const AnnotationsMixedPage({super.key});

  static const location = '/annotations/mixed';

  @override
  State<AnnotationsMixedPage> createState() => _AnnotationsMixedPageState();
}

class _AnnotationsMixedPageState extends State<AnnotationsMixedPage> {
  final _random = Random.secure();
  final _circlePoints = <Point>[
    Point(coordinates: Position(9.17, 47.68)),
    Point(coordinates: Position(9.17, 48)),
    Point(coordinates: Position(9, 48)),
    Point(coordinates: Position(9.5, 48)),
  ];
  Color _circleColor = Colors.orange.withOpacity(0.5);
  PolylineAnnotationLayer? _polylineLayer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mixed Annotations')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 8,
              alignment: WrapAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _circleColor =
                          Color(_random.nextInt(0xFFFFFF) + 0x7F000000);
                    });
                  },
                  child: const Text(
                    'Change color',
                    textAlign: TextAlign.center,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      if (_polylineLayer == null) {
                        _polylineLayer = PolylineAnnotationLayer(
                          polylines: [
                            LineString(
                              coordinates: [
                                Position(9.17, 47.68),
                                Position(9.5, 48),
                                Position(9, 48),
                              ],
                            ),
                          ],
                        );
                      } else {
                        _polylineLayer = null;
                      }
                    });
                  },
                  child: const Text(
                    'Toggle 2nd layer',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: MapLibreMap(
              options: MapOptions(zoom: 7, center: Position(9.17, 47.68)),
              onEvent: (event) {
                if (event case MapEventClick()) {
                  setState(() {
                    _circlePoints.add(Point(coordinates: event.point));
                  });
                }
              },
              layers: [
                CircleAnnotationLayer(
                  points: _circlePoints,
                  color: _circleColor,
                  radius: 20,
                  strokeColor: Colors.red,
                  strokeWidth: 2,
                ),
                if (_polylineLayer case final AnnotationLayer layer) layer,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
