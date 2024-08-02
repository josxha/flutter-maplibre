// ignore_for_file: prefer_single_quotes, require_trailing_commas

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class ControlsPage extends StatefulWidget {
  const ControlsPage({super.key});

  static const location = '/';

  @override
  State<ControlsPage> createState() => _ControlsPageState();
}

class _ControlsPageState extends State<ControlsPage> {
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
