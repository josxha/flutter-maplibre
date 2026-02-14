import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  // required if using maplibre is embedded in a WebView (windows, macOS)
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({
    this.options = defaultOptions,
    this.onMapCreated,
    this.onStyleLoaded,
    this.onEvent,
    this.children = const [],
    super.key,
  });

  static const defaultOptions = MapOptions(
    initCenter: Geographic(lon: 0, lat: 0),
  );

  final MapOptions options;
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
          options: options,
          onMapCreated: onMapCreated,
          onStyleLoaded: onStyleLoaded,
          onEvent: onEvent,
          children: children,
        ),
      ),
    );
  }
}
