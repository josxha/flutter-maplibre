import 'dart:convert';

import 'package:flutter/foundation.dart';
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
  late final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Annotations')),
      body: MapLibreMap(
        options: MapOptions(zoom: 7, center: Position(9, 48)),
        onMapCreated: (controller) => _controller = controller,
        onStyleLoaded: () async {
          final _ = await _controller.addMarker(
            Marker(point: Position(9, 48)),
          );
          // TODO remove delay
          await Future<void>.delayed(const Duration(seconds: 2));
          final geojsonRaw =
              await rootBundle.loadString('/geojson/lake-constance.geojson');
          // offload the parsing of the GeoJSON to another thread with `compute`
          final geojson = await compute<String, Map<String, Object?>>(
            (message) => jsonDecode(geojsonRaw) as Map<String, Object?>,
            geojsonRaw,
          );
          await _controller.addGeoJson(id: 'LakeConstance', geoJson: geojson);
          //await _controller.addLayer(id: 'LakeConstance', type: 'geojson', source: 'LakeConstance');
        },
      ),
    );
  }
}
