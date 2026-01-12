import 'dart:async';

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
        options: const MapOptions(
          initZoom: 14,
          initCenter: Geographic(lon: -122.01971, lat: 45.632472),
        ),
        onStyleLoaded: _onStyleLoaded,
      ),
    );
  }

  Future<void> _onStyleLoaded(StyleController style) async {
    final response = await get(
      Uri.parse('https://maplibre.org/maplibre-gl-js/docs/assets/hike.geojson'),
    );
    final origCollection = FeatureCollection.parse(response.body);
    final lineString = origCollection.features.first.geometry! as LineString;
    final allCoords = lineString.chain.positions.toList(growable: false);

    // A LineString on MapLibre Native must have at least 2 Points. Initialize
    // the animation with 2 coordinates.
    final chain = allCoords.sublist(0, 2);
    final collection = FeatureCollection([
      Feature(geometry: LineString.from(chain)),
    ]);
    await style.addSource(
      GeoJsonSource(id: _sourceId, data: collection.toText()),
    );
    await style.addLayer(
      LineStyleLayer(
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
      // Add more and more points to the LineString.
      final chain = allCoords.sublist(0, index);
      final collection = FeatureCollection([
        Feature(geometry: LineString.from(chain)),
      ]);
      style.updateGeoJsonSource(id: _sourceId, data: collection.toText());
      debugPrint(
        '[$index] update line: '
        '${allCoords[index].x}, ${allCoords[index].y}',
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
