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
          if (kIsWeb) {
            final _ = await _controller.addMarker(
              Marker(point: Position(9, 48)),
            );
          }
          debugPrint('#2');
          final geojson =
              await rootBundle.loadString('assets/geojson/lake-constance.geojson');
          debugPrint('#3');
          await _controller.addSource(
            GeoJsonSource(id: 'LakeConstance', data: geojson),
          );
          debugPrint('#4');
          await _controller.addLayer(
            const FillLayer(id: 'LakeConstance', sourceId: 'LakeConstance'),
          );
          debugPrint('#5');
        },
      ),
    );
  }
}
