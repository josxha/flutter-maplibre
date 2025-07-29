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
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animation')),
      body: MapLibreMap(
        options: MapOptions(
          initZoom: 14,
          initCenter: Position(-122.01971, 45.632472),
        ),
        onStyleLoaded: _onStyleLoaded,
      ),
    );
  }

  Future<void> _onStyleLoaded(StyleController style) async {
    final response = await get(
      Uri.parse('https://maplibre.org/maplibre-gl-js/docs/assets/hike.geojson'),
    );
    final geojsonLine = response.body;
    final geojson = FeatureCollection.fromJson(
      jsonDecode(geojsonLine) as Map<String, Object?>,
    );
    final lineString = geojson.features.first.geometry! as LineString;
    // TODO: setting the id is currently required as geotypes would set it to null, Feature.id documented at https://datatracker.ietf.org/doc/html/rfc7946#section-3.2
    geojson.features.first.id = 1;
    final allCoords = lineString.coordinates;

    // a LineString on MapLibre Native must have at least 2 Points
    lineString.coordinates = allCoords.sublist(0, 2);
    await style.addSource(
      GeoJsonSource(id: _sourceId, data: jsonEncode(geojson.toJson())),
    );
    await style.addLayer(
      const LineStyleLayer(
        id: 'geojson-line',
        sourceId: _sourceId,
        paint: {'line-color': '#F00', 'line-width': 3},
      ),
    );

    var index = 1;
    _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      index++;
      if (index > allCoords.length - 1) {
        debugPrint('line animation completed');
        timer.cancel();
        return;
      }
      lineString.coordinates = allCoords.sublist(0, index);
      style.updateGeoJsonSource(
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
