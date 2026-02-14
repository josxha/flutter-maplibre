import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/ui/map_scalebar.dart';

import 'app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  test();
}

void test() {
  group('MapScalebar', () {
    testWidgets('show and update', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        children: const [MapScalebar()],
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Check if the scalebar is visible.
      final customPaintFinder = find.descendant(
        of: find.byType(MapScalebar),
        matching: find.byType(CustomPaint),
      );
      expect(customPaintFinder, findsOneWidget);

      final zoomLevels = [4.0, 8.0, 12.0, 16.0];
      final widths = <double>[];

      for (final zoom in zoomLevels) {
        await ctrl.moveCamera(zoom: zoom);
        await tester.pumpAndSettle(const Duration(seconds: 2));

        final size = tester.getSize(customPaintFinder);
        widths.add(size.width);

        final scaleBarPainter =
            (customPaintFinder.evaluate().first.widget as CustomPaint).painter!
                as ScaleBarPainter;

        expect(size.width, closeTo(scaleBarPainter.width, 0.01));
        final scalebarCenter = tester.getCenter(customPaintFinder);
        final scalebarLat = ctrl.toLngLat(scalebarCenter).lat;
        final metersPerPixel = ctrl.getMetersPerPixelAtLatitude(scalebarLat);
        final expected = scaleBarPainter.meters / metersPerPixel;
        expect(size.width, closeTo(expected, 1));
      }

      // Ensure that the width of the scalebar is different for each zoom level.
      expect(widths.length, equals(widths.toSet().length));
    });
  });
}
