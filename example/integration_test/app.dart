import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // ignore: unused_field
  late final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MapLibre Demo',
      home: Scaffold(
        body: MapLibreMap(
          options: MapOptions(center: Position(0, 0)),
          onMapCreated: (controller) {
            debugPrint('onMapCreated');
            _controller = controller;
          },
          onStyleLoaded: () {
            debugPrint('onStyleLoaded');
          },
        ),
      ),
    );
  }
}
