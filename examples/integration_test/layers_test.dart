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
            radius: 10,
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
            PolylineLayer(polylines: [Feature(geometry: _line)], width: 4),
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
      expect(map.style.getLayerIds(), ['background']);
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
              iconImage: 'marker',
              iconAllowOverlap: true,
            ),
          ],
        ),
      );
      await map.waitForFeatures(map.center, (features) => features.length == 1);
    });
  });
}
