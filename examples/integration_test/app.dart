import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({
    this.options,
    this.onMapCreated,
    this.onStyleLoaded,
    this.onEvent,
    this.children = const [],
    super.key,
  });

  final MapOptions? options;
  final MapCreatedCallback? onMapCreated;
  final MapEventCallback? onEvent;
  final StyleLoadedCallback? onStyleLoaded;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MapLibre Demo',
      home: Scaffold(
        body: MapLibreMap(
          options:
              options ??
              const MapOptions(initCenter: Geographic(lon: 0, lat: 0)),
          onMapCreated: onMapCreated,
          onStyleLoaded: onStyleLoaded,
          onEvent: onEvent,
          children: children,
        ),
      ),
    );
  }
}
