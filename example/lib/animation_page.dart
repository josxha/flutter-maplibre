import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  static const location = '/animation';

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

const _sourceId = 'AnimatedPath';

class _AnimationPageState extends State<AnimationPage> {
  late final MapController _controller;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animation')),
      body: MapLibreMap(
        options: MapOptions(zoom: 14, center: Position(-122.01971, 45.632472)),
        onMapCreated: (controller) => _controller = controller,
        onStyleLoaded: _onStyleLoaded,
      ),
    );
  }

  Future<void> _onStyleLoaded() async {
    final response = await get(
      Uri.parse('https://maplibre.org/maplibre-gl-js/docs/assets/hike.geojson'),
    );
    final geojsonLine = response.body;
    final geojson = FeatureCollection.fromJson(
      jsonDecode(geojsonLine) as Map<String, Object?>,
    );
    final lineString = geojson.features.first.geometry! as LineString;
    final allCoords = lineString.coordinates;

    lineString.coordinates = List.empty();
    await _controller.addSource(
      GeoJsonSource(id: _sourceId, data: jsonEncode(geojson.toJson())),
    );
    await _controller.addLayer(
      const LineLayer(
        id: 'geojson-line',
        sourceId: _sourceId,
        paint: {'line-color': '#F00', 'line-width': 3},
      ),
    );

    var index = 1;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (index > allCoords.length) {
        timer.cancel();
        return;
      }
      lineString.coordinates = allCoords.sublist(0, index++);
      _controller.updateGeoJsonSource(
        id: _sourceId,
        data: jsonEncode(geojson.toJson()),
      );
      debugPrint(
        '[$index] update line: '
        '${allCoords[index].lng}, ${allCoords[index].lat}',
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
