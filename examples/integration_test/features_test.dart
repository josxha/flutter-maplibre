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
  await map.style.sources.add(
    GeoJsonSource.data(
      id: 'point_source',
      data: featureCollection(const [
        Feature(geometry: Point(_center), id: 1, properties: {'kind': 'point'}),
      ]),
    ),
  );
  await map.style.sources.add(
    GeoJsonSource.data(
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
  await map.style.sources.add(
    GeoJsonSource.data(
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
  await map.style.layers.add(
    FillStyleLayer(
      id: 'polygon_layer',
      sourceId: 'polygon_source',
      color: const .literal(Color(0xFF00FF00)),
    ),
  );
  await map.style.layers.add(
    LineStyleLayer(
      id: 'line_layer',
      sourceId: 'line_source',
      color: const .literal(Color(0xFF0000FF)),
      width: const .literal(5),
    ),
  );
  await map.style.layers.add(
    CircleStyleLayer(
      id: 'point_layer',
      sourceId: 'point_source',
      radius: const .literal(5),
      color: const .literal(Color(0xFFFF0000)),
    ),
  );
  await map.waitForFeatures(map.center, (features) => features.length == 2);
}

Set<String?> _kinds(List<RenderedFeature> features) =>
    features.map((feature) => feature.properties['kind'] as String?).toSet();

void runTests() {
  group('feature queries', () {
    testWidgets('a point query finds what is drawn at a point', (tester) async {
      final map = await pumpMap(
        tester,
        options: offlineOptions(center: _center, zoom: 10),
      );
      await _addFixture(map);

      expect(
        await map.controller.queryRenderedFeatures(const .point(Offset.zero)),
        isEmpty,
      );

      final features = await map.controller.queryRenderedFeatures(
        .point(map.center),
      );
      expect(_kinds(features), {'point', 'polygon'});
      final point = features.singleWhere((f) => f.sourceId == 'point_source');
      expect(idOf(point), '1');
      expect(point.sourceLayer, isNull);
      expect(point.properties['kind'], 'point');
      expect(point.geometry, isA<Point>());
      final geometry = point.geometry! as Point;
      expect(geometry.position.x, closeTo(_center.lon, 1e-4));
      expect(geometry.position.y, closeTo(_center.lat, 1e-4));
      final polygon = features.singleWhere(
        (f) => f.sourceId == 'polygon_source',
      );
      expect(idOf(polygon), '3');
    });

    testWidgets('a point query filters by layer', (tester) async {
      final map = await pumpMap(
        tester,
        options: offlineOptions(center: _center, zoom: 10),
      );
      await _addFixture(map);
      var features = await map.controller.queryRenderedFeatures(
        .point(map.center),
        layerIds: ['polygon_layer'],
      );
      expect(_kinds(features), {'polygon'});

      // A second layer on the same source reports the feature again.
      await map.style.layers.add(
        CircleStyleLayer(
          id: 'point_layer_2',
          sourceId: 'point_source',
          radius: const .literal(5),
        ),
      );
      features = await map.waitForFeatures(
        map.center,
        (features) => features.length == 3,
      );
      features = await map.controller.queryRenderedFeatures(
        .point(map.center),
        layerIds: ['point_layer', 'point_layer_2'],
      );
      expect(features, hasLength(2));
      expect(_kinds(features), {'point'});

      expect(
        await map.controller.queryRenderedFeatures(
          .point(map.center),
          layerIds: [],
        ),
        isEmpty,
      );
    });

    testWidgets('a rect query finds what is drawn in a rectangle', (
      tester,
    ) async {
      final map = await pumpMap(
        tester,
        options: offlineOptions(center: _center, zoom: 10),
      );
      await _addFixture(map);

      expect(
        await map.controller.queryRenderedFeatures(
          const .rect(Rect.fromLTWH(0, 0, 10, 10)),
        ),
        isEmpty,
      );
      var features = await map.controller.queryRenderedFeatures(
        .rect(Rect.fromCenter(center: map.center, width: 2, height: 2)),
      );
      expect(_kinds(features), {'point', 'polygon'});

      final lineStart = map.controller.toScreenLocation(
        const Geographic(lon: 0.095, lat: 0.11),
      );
      features = await map.controller.queryRenderedFeatures(
        .rect(Rect.fromCenter(center: lineStart, width: 4, height: 4)),
        layerIds: ['line_layer'],
      );
      expect(_kinds(features), {'line'});

      final everything = Offset.zero & map.size;
      features = await map.controller.queryRenderedFeatures(.rect(everything));
      expect(_kinds(features), {'point', 'line', 'polygon'});
      features = await map.controller.queryRenderedFeatures(
        .rect(everything),
        layerIds: ['point_layer', 'line_layer'],
      );
      expect(_kinds(features), {'point', 'line'});
      expect(
        await map.controller.queryRenderedFeatures(
          .rect(everything),
          layerIds: [],
        ),
        isEmpty,
      );
    });

    testWidgets('a viewport query finds everything in the map', (tester) async {
      final map = await pumpMap(
        tester,
        options: offlineOptions(center: _center, zoom: 10),
      );
      await _addFixture(map);
      final features = await map.controller.queryRenderedFeatures(
        const .viewport(),
      );
      expect(_kinds(features), {'point', 'line', 'polygon'});
      expect(
        features.singleWhere((f) => f.sourceId == 'line_source').geometry,
        isA<LineString>(),
      );
      expect(
        features.singleWhere((f) => f.sourceId == 'polygon_source').geometry,
        isA<Polygon>(),
      );
    });

    testWidgets('a query filters with an expression', (tester) async {
      final map = await pumpMap(
        tester,
        options: offlineOptions(center: _center, zoom: 10),
      );
      await _addFixture(map);
      var features = await map.controller.queryRenderedFeatures(
        const .viewport(),
        filter: .equal(.get('kind'), const .literal('line')),
      );
      expect(_kinds(features), {'line'});

      features = await map.controller.queryRenderedFeatures(
        .point(map.center),
        filter: .notEqual(.get('kind'), const .literal('point')),
      );
      expect(_kinds(features), {'polygon'});

      expect(
        await map.controller.queryRenderedFeatures(
          const .viewport(),
          layerIds: ['point_layer'],
          filter: .equal(.get('kind'), const .literal('line')),
        ),
        isEmpty,
      );
    });

    testWidgets('querySourceFeatures finds the features of a source', (
      tester,
    ) async {
      final map = await pumpMap(
        tester,
        options: offlineOptions(center: _center, zoom: 10),
      );
      await _addFixture(map);
      await map.style.sources.add(
        GeoJsonSource.data(
          id: 'points',
          data: featureCollection(const [
            Feature(geometry: Point(_center), id: 4, properties: {'kind': 'a'}),
            Feature(
              geometry: Point(Geographic(lon: 0.105, lat: 0.1)),
              id: 5,
              properties: {'kind': 'b'},
            ),
          ]),
        ),
      );
      // A source loads tiles only while a visible layer uses it.
      await map.style.layers.add(
        CircleStyleLayer(id: 'points_layer', sourceId: 'points'),
      );
      await map.waitForFeatures(
        map.center,
        (features) => features.any((f) => f.sourceId == 'points'),
      );

      final polygons = await map.controller.querySourceFeatures(
        'polygon_source',
      );
      expect(polygons, isNotEmpty);
      expect(polygons.first.properties['kind'], 'polygon');
      expect(polygons.first.geometry, isA<Polygon>());
      expect(polygons.first.sourceLayer, isNull);

      final points = await map.controller.querySourceFeatures('points');
      expect(points.map((f) => f.properties['kind']).toSet(), {'a', 'b'});
      final filtered = await map.controller.querySourceFeatures(
        'points',
        filter: .equal(.get('kind'), const .literal('b')),
      );
      expect(filtered, isNotEmpty);
      expect(filtered.map((f) => f.properties['kind']).toSet(), {'b'});
      expect(filtered.first.geometry, isA<Point>());

      expect(await map.controller.querySourceFeatures('missing'), isEmpty);
    });

    testWidgets('a clustered source reports its clusters', (tester) async {
      final map = await pumpMap(
        tester,
        options: offlineOptions(center: _center, zoom: 10),
      );
      await map.style.sources.add(
        GeoJsonSource.data(
          id: 'clustered',
          data: featureCollection([
            for (var i = 0; i < 3; i++)
              Feature(
                geometry: Point(Geographic(lon: 0.1 + i * 0.001, lat: 0.1)),
                id: 10 + i,
                properties: {'mag': i + 1},
              ),
          ]),
          cluster: GeoJsonCluster(
            properties: {
              'sum': ClusterProperty(
                reduce: .sum([
                  Expression.accumulated().asNumber(),
                  Expression.get('sum').asNumber(),
                ]),
                map: .get('mag'),
              ),
            },
          ),
        ),
      );
      await map.style.layers.add(
        CircleStyleLayer(id: 'clusters', sourceId: 'clustered'),
      );
      final features = await map.waitForFeatures(
        map.center,
        (features) => features.any((f) => f.properties['cluster'] == true),
        layerIds: ['clusters'],
      );
      final cluster = features.firstWhere(
        (f) => f.properties['cluster'] == true,
      );
      expect(cluster.properties['point_count'], 3);
      expect(cluster.properties['sum'], 6);
      final clusterId = (cluster.properties['cluster_id']! as num).toInt();

      final leaves = await map.controller.getClusterLeaves(
        'clustered',
        clusterId,
      );
      expect(leaves.map((f) => f.properties['mag']).toSet(), {1, 2, 3});
      expect(leaves.first.geometry, isA<Point>());
      final page = await map.controller.getClusterLeaves(
        'clustered',
        clusterId,
        limit: 2,
        offset: 2,
      );
      expect(page, hasLength(1));

      final children = await map.controller.getClusterChildren(
        'clustered',
        clusterId,
      );
      expect(children, isNotEmpty);
      final zoom = await map.controller.getClusterExpansionZoom(
        'clustered',
        clusterId,
      );
      expect(zoom, greaterThan(10));
    });

    testWidgets('reports the source layer of vector tiles (network)', (
      tester,
    ) async {
      final map = await pumpMap(
        tester,
        options: const MapOptions(
          initCamera: CameraUpdate.position(
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
      final countries = await map.controller.querySourceFeatures(
        'maplibre',
        sourceLayer: 'countries',
      );
      expect(countries, isNotEmpty);
      expect(countries.map((f) => f.sourceLayer), everyElement('countries'));
    });
  });
}
