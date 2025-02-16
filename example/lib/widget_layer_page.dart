import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class WidgetLayerPage extends StatefulWidget {
  const WidgetLayerPage({super.key});

  static const location = '/widget-layer';

  @override
  State<WidgetLayerPage> createState() => _WidgetLayerPageState();
}

class _WidgetLayerPageState extends State<WidgetLayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Layer')),
      body: MapLibreMap(
        acceptLicense: true,
        options: MapOptions(
          initZoom: 3,
          initCenter: Position(0, 0),
        ),
        children: [
          WidgetLayer(
            markers: [
              // A 3D marker
              Marker(
                size: const Size.square(50),
                point: Position(-10, 0),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 50,
                ),
                alignment: Alignment.bottomCenter,
              ),
              Marker(
                size: const Size.square(50),
                point: Position(-5, 0),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 50,
                ),
                alignment: Alignment.bottomCenter,
                rotate: true,
              ),
              Marker(
                size: const Size.square(50),
                point: Position(0, 0),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 50,
                ),
                alignment: Alignment.bottomCenter,
                flat: true,
              ),
              Marker(
                size: const Size.square(50),
                point: Position(5, 0),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 50,
                ),
                alignment: Alignment.bottomCenter,
                flat: true,
                rotate: true,
              ),
            ],
          ),
          // display the UI widgets above the widget markers.
          const SourceAttribution(),
        ],
      ),
    );
  }
}
