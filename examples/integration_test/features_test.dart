import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'shared/test_map.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  runTests();
}

const _center = Geographic(lon: 0.1, lat: 0.1);

/// Adds a point at the center, a line along the top edge of a square around
/// it and the square itself, each in its own source and layer.
Future<void> _addFixture(TestMap map) async {
  await map.style.addSource(
    GeoJsonSource(
      id: 'point_source',
      data: featureCollection(const [
        Feature(geometry: Point(_center), id: 1, properties: {'kind': 'point'}),
      ]),
    ),
  );
  await map.style.addSource(
    GeoJsonSource(
      id: 'line_source',
      data: featureCollection([
        Feature(
          geometry: LineString.from(const [
            Geographic(lon: 0.09, lat: 0.11),
            Geographic(lon: 0.11, lat: 0.11),
          ]),
          id: 2,
          properties: const {'kind': 'line'},
        ),
      ]),
    ),
  );
  await map.style.addSource(
    GeoJsonSource(
      id: 'polygon_source',
      data: featureCollection([
        Feature(
          geometry: Polygon.from(const [
            [
              Geographic(lon: 0.09, lat: 0.09),
              Geographic(lon: 0.11, lat: 0.09),
              Geographic(lon: 0.11, lat: 0.11),
              Geographic(lon: 0.09, lat: 0.11),
              Geographic(lon: 0.09, lat: 0.09),
            ],
          ]),
          id: 3,
          properties: const {'kind': 'polygon'},
        ),
      ]),
    ),
  );
  await map.style.addLayer(
    const FillStyleLayer(
      id: 'polygon_layer',
      sourceId: 'polygon_source',
      paint: {'fill-color': '#00FF00'},
    ),
  );
  await map.style.addLayer(
    const LineStyleLayer(
      id: 'line_layer',
      sourceId: 'line_source',
      paint: {'line-color': '#0000FF', 'line-width': 5},
    ),
  );
  await map.style.addLayer(
    const CircleStyleLayer(
      id: 'point_layer',
      sourceId: 'point_source',
      paint: {'circle-radius': 5, 'circle-color': '#FF0000'},
    ),
  );
  await map.waitForFeatures(map.center, (features) => features.length == 2);
}

Set<String?> _kinds(List<RenderedFeature> features) =>
    features.map((feature) => feature.properties['kind'] as String?).toSet();

void runTests() {
  group('feature queries', () {
    testWidgets('featuresAtPoint finds what is drawn at a point', (
      tester,
    ) async {
      final map = await pumpMap(
        tester,
        options: offlineOptions(center: _center, zoom: 10),
      );
      await _addFixture(map);

      expect(await map.controller.featuresAtPoint(Offset.zero), isEmpty);

      final features = await map.controller.featuresAtPoint(map.center);
      expect(_kinds(features), {'point', 'polygon'});
      final point = features.singleWhere((f) => f.sourceId == 'point_source');
      expect(idOf(point), '1');
      expect(point.sourceLayer, isNull);
      expect(point.properties['kind'], 'point');
      final polygon = features.singleWhere(
        (f) => f.sourceId == 'polygon_source',
      );
      expect(idOf(polygon), '3');
    });

    testWidgets('featuresAtPoint filters by layer', (tester) async {
      final map = await pumpMap(
        tester,
        options: offlineOptions(center: _center, zoom: 10),
      );
      await _addFixture(map);
      var features = await map.controller.featuresAtPoint(
        map.center,
        layerIds: ['polygon_layer'],
      );
      expect(_kinds(features), {'polygon'});

      // A second layer on the same source reports the feature again.
      await map.style.addLayer(
        const CircleStyleLayer(
          id: 'point_layer_2',
          sourceId: 'point_source',
          paint: {'circle-radius': 5},
        ),
      );
      features = await map.waitForFeatures(
        map.center,
        (features) => features.length == 3,
      );
      features = await map.controller.featuresAtPoint(
        map.center,
        layerIds: ['point_layer', 'point_layer_2'],
      );
      expect(features, hasLength(2));
      expect(_kinds(features), {'point'});

      expect(
        await map.controller.featuresAtPoint(map.center, layerIds: []),
        isEmpty,
      );
    });

    testWidgets('featuresInRect finds what is drawn in a rectangle', (
      tester,
    ) async {
      final map = await pumpMap(
        tester,
        options: offlineOptions(center: _center, zoom: 10),
      );
      await _addFixture(map);

      expect(
        await map.controller.featuresInRect(const Rect.fromLTWH(0, 0, 10, 10)),
        isEmpty,
      );
      var features = await map.controller.featuresInRect(
        Rect.fromCenter(center: map.center, width: 2, height: 2),
      );
      expect(_kinds(features), {'point', 'polygon'});

      final lineStart = map.controller.toScreenLocation(
        const Geographic(lon: 0.095, lat: 0.11),
      );
      features = await map.controller.featuresInRect(
        Rect.fromCenter(center: lineStart, width: 4, height: 4),
        layerIds: ['line_layer'],
      );
      expect(_kinds(features), {'line'});

      final everything = Offset.zero & map.size;
      features = await map.controller.featuresInRect(everything);
      expect(_kinds(features), {'point', 'line', 'polygon'});
      features = await map.controller.featuresInRect(
        everything,
        layerIds: ['point_layer', 'line_layer'],
      );
      expect(_kinds(features), {'point', 'line'});
      expect(
        await map.controller.featuresInRect(everything, layerIds: []),
        isEmpty,
      );
    });

    testWidgets('reports the source layer of vector tiles (network)', (
      tester,
    ) async {
      final map = await pumpMap(
        tester,
        options: const MapOptions(
          initCamera: InitialCamera.position(
            center: Geographic(lon: 10, lat: 50),
            zoom: 4,
          ),
        ),
      );
      final features = await map.waitForFeatures(
        map.center,
        (features) => features.isNotEmpty,
        layerIds: ['countries-fill'],
        timeout: const Duration(seconds: 30),
      );
      expect(
        features.map((f) => (f.sourceId, f.sourceLayer)),
        everyElement(('maplibre', 'countries')),
      );
    });
  });
}
