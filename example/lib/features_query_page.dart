import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';

@immutable
class FeaturesQueryPage extends StatefulWidget {
  const FeaturesQueryPage({super.key});

  static const location = '/features/query';

  @override
  State<FeaturesQueryPage> createState() => _FeaturesQueryPageState();
}

class _FeaturesQueryPageState extends State<FeaturesQueryPage> {
  late final MapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Query Features')),
      body: MapLibreMap(
        options: const MapOptions(
          initZoom: 7,
          initCenter: Geographic(lon: 0.1, lat: 0.1),
        ),
        onMapCreated: (controller) => _controller = controller,
        onStyleLoaded: _onStyleLoaded,
        onEvent: (event) async {
          if (event is MapEventClick) {
            final screenPoint = _controller.toScreenLocation(event.point);
            final features = _controller.featuresAtPoint(
              screenPoint,
            );
            if (context.mounted) {
              _showFeatures(features);
            }
          } else if (event is MapEventLongClick) {
            final screenPoint = _controller.toScreenLocation(event.point);
            final features = _controller.featuresInRect(
              Rect.fromCircle(
                center: screenPoint,
                radius: 20,
              ),
            );
            _showFeatures(features);
          }
        },
      ),
    );
  }

  Future<void> _onStyleLoaded(StyleController style) async {
    final random = Random();
    final features = <Map<String, dynamic>>[];

    const centerLon = 0.1;
    const centerLat = 0.1;
    const spread = 0.50; // degrees

    // Add random points
    for (var i = 0; i < 5; i++) {
      features.add({
        'type': 'Feature',
        'id': 'point-$i',
        'geometry': {
          'type': 'Point',
          'coordinates': [
            centerLon + (random.nextDouble() - 0.5) * spread,
            centerLat + (random.nextDouble() - 0.5) * spread,
          ],
        },
        'properties': {'id': 'point-$i'},
      });
    }

    final geojson = {
      'type': 'FeatureCollection',
      'features': features,
    };

    await style.addSource(
      GeoJsonSource(id: 'points', data: jsonEncode(geojson)),
    );

    // Add random polygons
    for (var i = 0; i < 5; i++) {
      final polyCenterLon = centerLon + (random.nextDouble() - 0.5) * spread;
      final polyCenterLat = centerLat + (random.nextDouble() - 0.5) * spread;
      final size = random.nextDouble() * 0.5 + 0.1; // degrees
      final points = <List<double>>[];
      final numVertices = random.nextInt(4) + 3; // 3 to 6 vertices
      for (var j = 0; j < numVertices; j++) {
        final angle = 2 * pi * j / numVertices;
        points.add([
          polyCenterLon + size * cos(angle),
          polyCenterLat + size * sin(angle),
        ]);
      }
      points.add(points.first); // Close the ring

      features.add({
        'type': 'Feature',
        'id': 'polygon-$i',
        'geometry': {
          'type': 'Polygon',
          'coordinates': [points],
        },
        'properties': {'id': 'polygon-$i'},
      });
    }

    final geojson2 = {
      'type': 'FeatureCollection',
      'features': features,
    };

    await style.addSource(
      GeoJsonSource(id: 'polygons', data: jsonEncode(geojson2)),
    );

    await style.addLayer(
      const FillStyleLayer(
        id: 'polygons',
        sourceId: 'polygons',
        paint: {'fill-color': '#429ef5', 'fill-opacity': 0.6},
      ),
    );

    await style.addLayer(
      const CircleStyleLayer(
        id: 'points',
        sourceId: 'points',
        paint: {'circle-color': '#f54242', 'circle-radius': 8},
      ),
    );
  }

  void _showFeatures(List<RenderedFeature> features) {
    var text = '${features.length} layers clicked: ';

    // The Feature ID field is unpredictable on MapLibre web when the underlying
    // GeoJSON feature has an `id` field that is not a positive integer.
    // That's why we use the properties to store and retrieve the ID on web.
    if (kIsWeb) {
      text += features.map((e) => e.properties['id']).join(', ');
    } else {
      text += features.map((e) => e.id).join(', ');
    }
    debugPrint(text);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }
}
