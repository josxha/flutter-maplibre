import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'shared/test_map.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  runTests();
}

const _point = Geographic(lon: 0, lat: 0);

final _square = Polygon.from(const [
  [
    Geographic(lon: -0.1, lat: -0.1),
    Geographic(lon: 0.1, lat: -0.1),
    Geographic(lon: 0.1, lat: 0.1),
    Geographic(lon: -0.1, lat: 0.1),
    Geographic(lon: -0.1, lat: -0.1),
  ],
]);

final _line = LineString.from(const [
  Geographic(lon: -0.1, lat: 0),
  Geographic(lon: 0.1, lat: 0),
]);

void runTests() {
  group('annotation layers', () {
    testWidgets('draws, updates and removes the layers of the widget', (
      tester,
    ) async {
      final options = offlineOptions(zoom: 10);
      final map = await pumpMap(
        tester,
        options: options,
        layers: [
          const CircleLayer(
            points: [Feature(geometry: Point(_point))],
            radius: .literal(10),
          ),
        ],
      );
      final circles = await map.waitForFeatures(
        map.center,
        (features) => features.length == 1,
      );
      expect(circles.single.geometry, isA<Point>());

      await tester.pumpWidget(
        MapApp(
          options: options,
          layers: [
            PolygonLayer(polygons: [Feature(geometry: _square)]),
            PolylineLayer(
              polylines: [Feature(geometry: _line)],
              width: const .literal(4),
            ),
          ],
        ),
      );
      await map.waitForFeatures(
        map.center,
        (features) =>
            features.any((f) => f.geometry is Polygon) &&
            features.any((f) => f.geometry is LineString),
      );

      await tester.pumpWidget(MapApp(options: options));
      await map.waitForFeatures(map.center, (features) => features.isEmpty);
      expect(map.style.layers.map((layer) => layer.id).toList(), [
        'background',
      ]);
    });

    testWidgets('drags a feature of a draggable layer, not the map', (
      tester,
    ) async {
      final options = offlineOptions(zoom: 10);
      final ends = <LayerFeatureEvent>[];
      final map = await pumpMap(
        tester,
        options: options,
        layers: [
          CircleLayer(
            points: const [Feature(geometry: Point(_point))],
            radius: const .literal(20),
            draggable: true,
            onDragEnd: ends.add,
          ),
        ],
      );
      await map.waitForFeatures(map.center, (features) => features.isNotEmpty);
      final before = map.controller.getCamera();

      final gesture = await tester.startGesture(map.toGlobal(map.center));
      await gesture.moveBy(const Offset(0, 20));
      // The map looks for the feature before the drag moves it.
      await map.pumpUntil(
        () => map.events.whereType<MapEventDragStart>().isNotEmpty,
        reason: () => 'the drag never started',
      );
      for (var i = 0; i < 8; i++) {
        await gesture.moveBy(const Offset(0, 10));
        await tester.pump(const Duration(milliseconds: 16));
      }
      // The layer moves the feature itself, without a rebuild.
      final target = map.center + const Offset(0, 100);
      await map.waitForFeatures(target, (features) => features.isNotEmpty);
      await map.waitForFeatures(map.center, (features) => features.isEmpty);

      await gesture.up();
      await map.pumpUntil(
        () => ends.isNotEmpty,
        reason: () => 'the drag never ended',
      );
      final end = ends.single;
      expect(end.index, 0);
      expect(end.screenPoint.dx, closeTo(target.dx, 1));
      expect(end.screenPoint.dy, closeTo(target.dy, 1));
      expect(end.point.lat, lessThan(_point.lat));
      final after = map.controller.getCamera();
      expect(after.center.lon, closeTo(before.center.lon, 1e-6));
      expect(after.center.lat, closeTo(before.center.lat, 1e-6));

      // The app didn't save the new place, so the feature goes back.
      await map.waitForFeatures(map.center, (features) => features.isNotEmpty);
      await map.waitForFeatures(target, (features) => features.isEmpty);
    });

    testWidgets('reports clicks and hovers on the features of a layer', (
      tester,
    ) async {
      final options = offlineOptions(zoom: 10);
      final events = <(String, LayerFeatureEvent)>[];
      final map = await pumpMap(
        tester,
        options: options,
        layers: [
          CircleLayer(
            points: const [
              Feature(geometry: Point(Geographic(lon: 0, lat: 50))),
              Feature(geometry: Point(_point)),
            ],
            radius: const .literal(20),
            onClick: (event) => events.add(('click', event)),
            onEnter: (event) => events.add(('enter', event)),
            onLeave: (event) => events.add(('leave', event)),
          ),
        ],
      );
      await map.waitForFeatures(map.center, (features) => features.isNotEmpty);

      await tester.tapAt(map.toGlobal(map.center + const Offset(5, 0)));
      await map.pumpUntil(
        () => events.isNotEmpty,
        reason: () => 'the layer click was never reported',
      );
      expect(events.single.$1, 'click');
      expect(events.single.$2.index, 1);
      events.clear();

      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      addTearDown(mouse.removePointer);
      await mouse.addPointer(
        location: map.toGlobal(map.center + const Offset(100, 0)),
      );
      await tester.pump();
      await mouse.moveTo(map.toGlobal(map.center));
      await map.pumpUntil(
        () => events.isNotEmpty,
        reason: () => 'entering the feature was never reported',
      );
      await mouse.moveTo(map.toGlobal(map.center + const Offset(100, 0)));
      await map.pumpUntil(
        () => events.length > 1,
        reason: () => 'leaving the feature was never reported',
      );
      expect(
        [for (final (kind, event) in events) '$kind ${event.index}'],
        ['enter 1', 'leave 1'],
      );
    });

    testWidgets('updates a changed layer in place and keeps the order', (
      tester,
    ) async {
      final options = offlineOptions(zoom: 10);
      const points = [Feature(geometry: Point(_point))];
      final map = await pumpMap(
        tester,
        options: options,
        layers: const [
          CircleLayer(points: points, radius: .literal(40)),
          CircleLayer(points: points),
        ],
      );
      final beside = map.center + const Offset(25, 0);
      await map.waitForFeatures(beside, (features) => features.length == 1);
      final bottom = map.style.layers['maplibre-layer-0'];

      await tester.pumpWidget(
        MapApp(
          options: options,
          layers: const [
            CircleLayer(points: points),
            CircleLayer(points: points),
          ],
        ),
      );
      await map.waitForFeatures(beside, (features) => features.isEmpty);
      expect(map.style.layers['maplibre-layer-0'], same(bottom));
      expect(map.style.layers.map((layer) => layer.id), [
        'background',
        'maplibre-layer-0',
        'maplibre-layer-1',
      ]);

      // Another kind of layer takes the place of the old one.
      await tester.pumpWidget(
        MapApp(
          options: options,
          layers: [
            PolylineLayer(
              polylines: [Feature(geometry: _line)],
              width: const .literal(4),
            ),
            const CircleLayer(points: points),
          ],
        ),
      );
      await map.waitForFeatures(
        map.center,
        (features) => features.any((f) => f.geometry is LineString),
      );
      expect(map.style.layers.map((layer) => layer.id), [
        'background',
        'maplibre-layer-0',
        'maplibre-layer-1',
      ]);
    });

    testWidgets('styles each feature by its properties', (tester) async {
      const left = Geographic(lon: -0.2, lat: 0);
      const right = Geographic(lon: 0.2, lat: 0);
      final map = await pumpMap(
        tester,
        options: offlineOptions(zoom: 10),
        layers: [
          CircleLayer(
            points: const [
              Feature(geometry: Point(left), properties: {'size': 40}),
              Feature(geometry: Point(right), properties: {'size': 5}),
            ],
            radius: Expression.get('size').asNumber(),
          ),
        ],
      );
      const beside = Offset(25, 0);
      await map.waitForFeatures(
        map.controller.toScreenLocation(left) + beside,
        (features) => features.length == 1,
      );
      await map.waitForFeatures(
        map.controller.toScreenLocation(right) + beside,
        (features) => features.isEmpty,
      );
    });

    testWidgets('draws a feature added to the same list in place', (
      tester,
    ) async {
      final options = offlineOptions(zoom: 10);
      // The example pages add a tapped point to their list and rebuild with
      // the same list instance.
      const first = Geographic(lon: 0.2, lat: 0);
      final points = [const Feature(geometry: Point(first))];
      final map = await pumpMap(
        tester,
        options: options,
        layers: [CircleLayer(points: points, radius: const .literal(10))],
      );
      await map.waitForFeatures(
        map.controller.toScreenLocation(first),
        (features) => features.length == 1,
      );
      expect(
        await map.controller.queryRenderedFeatures(.point(map.center)),
        isEmpty,
      );

      points.add(const Feature(geometry: Point(_point)));
      await tester.pumpWidget(
        MapApp(
          options: options,
          layers: [CircleLayer(points: points, radius: const .literal(10))],
        ),
      );
      await map.waitForFeatures(map.center, (features) => features.length == 1);
    });

    testWidgets('MarkerLayer draws an image of the style', (tester) async {
      final options = offlineOptions(zoom: 10);
      final map = await pumpMap(tester, options: options);
      final bytes = (await rootBundle.load('assets/images/marker.png')).buffer
          .asUint8List();
      await map.style.addImage('marker', bytes);
      await tester.pumpWidget(
        MapApp(
          options: options,
          layers: const [
            MarkerLayer(
              points: [Feature(geometry: Point(_point))],
              iconImage: .literal('marker'),
              iconAllowOverlap: .literal(true),
            ),
          ],
        ),
      );
      await map.waitForFeatures(map.center, (features) => features.length == 1);
    });
  });
}
