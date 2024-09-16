import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class GeoJsonPage extends StatefulWidget {
  const GeoJsonPage({super.key});

  static const location = '/geojson';

  @override
  State<GeoJsonPage> createState() => _GeoJsonPageState();
}

class _GeoJsonPageState extends State<GeoJsonPage> {
  late final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GeoJSON')),
      body: MapLibreMap(
        options: MapOptions(zoom: 7, center: Position(9.17, 47.68)),
        onMapCreated: (controller) => _controller = controller,
        onStyleLoaded: () async {
          if (kIsWeb) {
            // This kind of Marker is only supported on web
            final _ = await _controller.addMarker(
              Marker(point: Position(9, 47)),
            );
          }

          // show Polygon as fill layer
          final geojsonPolygon =
              await rootBundle.loadString('assets/geojson/lake-constance.json');
          await _controller.addSource(
            GeoJsonSource(id: 'LakeConstance', data: geojsonPolygon),
          );
          await _controller.addLayer(
            const FillLayer(
              id: 'geojson-fill',
              sourceId: 'LakeConstance',
              paint: {'fill-color': '#00F'},
            ),
          );

          // show LineString as line layer
          final geojsonLine =
              await rootBundle.loadString('assets/geojson/path.json');
          await _controller.addSource(
            GeoJsonSource(id: 'Path', data: geojsonLine),
          );
          await _controller.addLayer(
            const LineLayer(
              id: 'geojson-line',
              sourceId: 'Path',
              paint: {'line-color': '#F00'},
            ),
          );

          // show Point as circle layer
          final geojsonPoints =
              await rootBundle.loadString('assets/geojson/cities.json');
          await _controller.addSource(
            GeoJsonSource(id: 'Cities', data: geojsonPoints),
          );
          await _controller.addLayer(
            const CircleLayer(
              id: 'geojson-circle',
              sourceId: 'Cities',
              paint: {'circle-color': '#0F0', 'circle-radius': 20},
            ),
          );
        },
      ),
    );
  }
}
