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
      expect(circles.single.geometry?['type'], 'Point');

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
        (features) => features
            .map((f) => f.geometry?['type'])
            .toSet()
            .containsAll(['Polygon', 'LineString']),
      );

      await tester.pumpWidget(MapApp(options: options));
      await map.waitForFeatures(map.center, (features) => features.isEmpty);
      expect(map.style.layers.map((layer) => layer.id).toList(), [
        'background',
      ]);
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
        (features) => features.any((f) => f.geometry?['type'] == 'LineString'),
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
      expect(await map.controller.featuresAtPoint(map.center), isEmpty);

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
