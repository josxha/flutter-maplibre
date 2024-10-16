import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class SymbolFromWidgetPage extends StatefulWidget {
  const SymbolFromWidgetPage({super.key});

  static const location = '/symbol-from-widget';

  @override
  State<SymbolFromWidgetPage> createState() => _SymbolFromWidgetPageState();
}

class _SymbolFromWidgetPageState extends State<SymbolFromWidgetPage> {
  final _layer = MarkerAnnotationLayer(
    points: <Point>[
      Point(coordinates: Position(9.17, 47.68)),
      Point(coordinates: Position(9.17, 48)),
      Point(coordinates: Position(9, 48)),
      Point(coordinates: Position(9.5, 48)),
    ],
    textField: 'Marker',
    textAllowOverlap: true,
    iconImage: const Icon(Icons.location_on, color: Colors.red, size: 50),
    iconSize: 0.5,
    iconAnchor: IconAnchor.bottom,
    textOffset: const [0, 1],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Symbol from Widget')),
      body: MapLibreMap(
        options: MapOptions(initZoom: 7, initCenter: Position(9.17, 47.68)),
        onEvent: (event) async {
          switch (event) {
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
    );
  }
}