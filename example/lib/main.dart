import 'package:flutter/material.dart';
import 'package:geotypes/geotypes.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MapLibre Demo',
      home: MyHomePage(),
    );
  }
}

@immutable
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MapLibre Demo'),
      ),
      body: MapLibreMap(
        options: MapOptions(
          zoom: 6,
          center: Position(9, 47),
          controls: const [
            ScaleControl(),
          ],
        ),
        onMapCreated: (controller) {
          debugPrint('[MapLibreMap] onMapCreated');
        },
        onStyleLoadedCallback: () {
          debugPrint('[MapLibreMap] onStyleLoadedCallback');
        },
      ),
    );
  }
}
