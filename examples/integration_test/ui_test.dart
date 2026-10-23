import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/ui/map_scalebar.dart';

import 'shared/test_map.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  runTests();
}

void runTests() {
  group('widgets over the map', () {
    testWidgets('WidgetLayer keeps a marker on its location', (tester) async {
      const point = Geographic(lon: 2, lat: 1);
      const key = Key('marker');
      final map = await pumpMap(
        tester,
        children: [
          WidgetLayer(
            markers: [
              Marker(
                point: point,
                size: const Size.square(20),
                child: Container(key: key, color: Colors.red),
              ),
            ],
          ),
        ],
      );
      Future<void> expectOnPoint() async {
        await tester.pump(const Duration(milliseconds: 100));
        final expected = map.toGlobal(map.controller.toScreenLocation(point));
        final actual = tester.getCenter(find.byKey(key));
        expect(actual.dx, closeTo(expected.dx, 1));
        expect(actual.dy, closeTo(expected.dy, 1));
      }

      await expectOnPoint();
      await map.controller.moveCamera(
        center: const Geographic(lon: 3, lat: 2),
        zoom: 6,
      );
      await map.waitForCamera((camera) => camera.zoom > 5.9);
      await map.pumpUntil(
        () => (map.controller.camera?.zoom ?? 0) > 5.9,
        reason: () => 'the frame of the new camera never showed',
      );
      await expectOnPoint();
    });

    testWidgets('MapScalebar matches the scale of the map', (tester) async {
      final map = await pumpMap(tester, children: const [MapScalebar()]);
      final scalebar = find.descendant(
        of: find.byType(MapScalebar),
        matching: find.byType(CustomPaint),
      );
      expect(scalebar, findsOneWidget);

      final widths = <double>{};
      for (final zoom in [4.0, 8.0, 12.0, 16.0]) {
        await map.controller.moveCamera(zoom: zoom);
        await map.pumpUntil(
          () => (map.controller.camera?.zoom ?? 0) == zoom,
          reason: () => 'zoom $zoom never showed',
        );
        await tester.pump();
        final painter =
            (scalebar.evaluate().single.widget as CustomPaint).painter!
                as ScaleBarPainter;
        final size = tester.getSize(scalebar);
        expect(size.width, closeTo(painter.width, 0.01));
        final center = tester.getCenter(scalebar) - map.toGlobal(Offset.zero);
        final lat = map.controller.toLngLat(center).lat;
        final metersPerPixel = map.controller.getMetersPerPixelAtLatitude(lat);
        // The bar takes its latitude at a corner of its area, the test at its
        // center, which differ by a little on a tall screen.
        expect(size.width, closeTo(painter.meters / metersPerPixel, 2));
        widths.add(size.width);
      }
      expect(widths, hasLength(4));
    });
  });
}
