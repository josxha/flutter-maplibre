// ignore_for_file: prefer_single_quotes, require_trailing_commas

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class TestPage extends StatefulWidget {
  const TestPage({super.key});

  static const location = '/test';

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MapLibre Demo')),
      body: MapLibreMap(
        options: MapOptions(
          zoom: 4,
          center: Position(9, 48),
          controls: const [
            ScaleControl(),
            GeolocateControl(),
            FullscreenControl(),
            LogoControl(),
            NavigationControl(visualizePitch: true),
          ],
        ),
        onMapCreated: (controller) {
          debugPrint('[MapLibreMap] onMapCreated');
        },
        onStyleLoadedCallback: () async {
          debugPrint('[MapLibreMap] onStyleLoadedCallback');
        },
      ),
    );
  }
}
