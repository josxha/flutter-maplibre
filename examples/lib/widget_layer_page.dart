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
  bool _cluster = false;

  static const _markers = [
    // A 3D marker
    Marker(
      size: Size.square(50),
      point: Geographic(lon: -10, lat: 0),
      child: Icon(Icons.location_on, color: Colors.red, size: 50),
      alignment: Alignment.bottomCenter,
    ),
    Marker(
      size: Size.square(50),
      point: Geographic(lon: -5, lat: 0),
      child: Icon(Icons.location_on, color: Colors.red, size: 50),
      alignment: Alignment.bottomCenter,
      rotate: true,
    ),
    Marker(
      size: Size.square(50),
      point: Geographic(lon: 0, lat: 0),
      child: Icon(Icons.location_on, color: Colors.red, size: 50),
      alignment: Alignment.bottomCenter,
      flat: true,
    ),
    Marker(
      size: Size.square(50),
      point: Geographic(lon: 5, lat: 0),
      child: Icon(Icons.location_on, color: Colors.red, size: 50),
      alignment: Alignment.bottomCenter,
      flat: true,
      rotate: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Layer'),
        actions: [
          IconButton(
            tooltip: _cluster ? 'Disable clustering' : 'Enable clustering',
            icon: Icon(_cluster ? Icons.scatter_plot : Icons.bubble_chart),
            onPressed: () => setState(() => _cluster = !_cluster),
          ),
        ],
      ),
      body: MapLibreMap(
        options: const MapOptions(
          initZoom: 3,
          initCenter: Geographic(lon: 0, lat: -10),
        ),
        children: [
          WidgetLayer(markers: _markers, cluster: _cluster),
          // display the UI widgets above the widget markers.
          const SourceAttribution(),
        ],
      ),
    );
  }
}
