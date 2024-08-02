import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class AnnotationsPage extends StatefulWidget {
  const AnnotationsPage({super.key});

  static const location = '/annotations';

  @override
  State<AnnotationsPage> createState() => _AnnotationsPageState();
}

class _AnnotationsPageState extends State<AnnotationsPage> {
  late MapController _controller;

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
        onMapCreated: (controller) => _controller = controller,
        onStyleLoadedCallback: () async {
          // final marker = await _controller.addMarker(Marker(point: Position(9, 48)),);
          // TODO remove delay
          await Future<void>.delayed(const Duration(seconds: 5));
          final geojsonRaw =
          await rootBundle.loadString('/geojson/lake-constance.geojson');
          final geojson = jsonDecode(geojsonRaw) as Map<String, Object?>;
          await _controller.addGeoJson(id: 'LakeConstance', geoJson: geojson);
        },
      ),
    );
  }
}
