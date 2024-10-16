import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class AnnotationsWidgetMarkerPage extends StatefulWidget {
  const AnnotationsWidgetMarkerPage({super.key});

  static const location = '/marker-from-widget';

  @override
  State<AnnotationsWidgetMarkerPage> createState() =>
      _AnnotationsWidgetMarkerPageState();
}

class _AnnotationsWidgetMarkerPageState
    extends State<AnnotationsWidgetMarkerPage> {
  final _points = <Point>[
    Point(coordinates: Position(9.17, 47.68)),
    Point(coordinates: Position(9.17, 48)),
    Point(coordinates: Position(9, 48)),
    Point(coordinates: Position(9.5, 48)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Marker Annotations')),
      body: MapLibreMap(
        options: MapOptions(initZoom: 7, initCenter: Position(9.17, 47.68)),
        onEvent: (event) async {
          switch (event) {
            case MapEventClick():
              // add a new marker on click
              setState(() {
                _points.add(Point(coordinates: event.point));
              });
            default:
              // ignore all other events
              break;
          }
        },
        layers: [
          MarkerAnnotationLayer(
            points: _points,
            textField: 'Marker',
            textAllowOverlap: true,
            iconImage: 'marker',
            iconSize: 0.08,
            iconAnchor: IconAnchor.bottom,
            textOffset: const [0, 1],
          ),
        ],
      ),
    );
  }
}
