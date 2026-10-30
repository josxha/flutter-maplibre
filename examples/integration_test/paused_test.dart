import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'shared/test_map.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  runTests();
}

void runTests() {
  group('Paused rendering', () {
    /// Shows the map of [map] again, paused or not.
    Future<void> setPaused(TestMap map, {required bool paused}) async {
      await map.tester.pumpWidget(
        MapApp(
          options: offlineOptions(),
          onEvent: map.events.add,
          paused: paused,
        ),
      );
      await map.waitForEvent<MapEventRenderingChanged>(
        where: (event) => event.paused == paused,
      );
      expect(map.controller.isRenderingPaused, paused);
    }

    testWidgets('keeps the camera and shows changes on resume', (tester) async {
      final map = await pumpMap(tester);
      await setPaused(map, paused: true);

      // A frame demanded before the pause still renders the next update.
      await map.pumpFuture(
        map.controller.moveCamera(zoom: 5),
        reason: 'moving the camera of a paused map',
      );
      await tester.pump(const Duration(milliseconds: 500));

      await map.pumpFuture(
        map.controller.moveCamera(zoom: 7),
        reason: 'moving the camera of a paused map',
      );
      expect(map.controller.getCamera().zoom, closeTo(7, 1e-6));
      await tester.pump(const Duration(seconds: 1));
      expect(
        map.controller.camera!.zoom,
        isNot(closeTo(7, 1e-6)),
        reason: 'a paused map shows no new frame',
      );

      await setPaused(map, paused: false);
      await map.waitForFrame((camera) => (camera.zoom - 7).abs() < 1e-6);
      expect(map.style.layers.map((layer) => layer.id).toList(), [
        'background',
      ]);
    });

    testWidgets('ends a running camera animation at its target', (
      tester,
    ) async {
      final map = await pumpMap(tester);
      final animation = map.controller.animateCamera(
        zoom: 2,
        bearing: 40,
        nativeDuration: const Duration(seconds: 30),
      );
      await tester.pump(const Duration(milliseconds: 200));
      await setPaused(map, paused: true);
      await map.pumpFuture(
        animation,
        reason: 'the animation never ended',
        timeout: const Duration(seconds: 5),
      );
      final camera = map.controller.getCamera();
      expect(camera.zoom, closeTo(2, 1e-6));
      expect(camera.bearing, closeTo(40, 1e-6));
    });

    testWidgets('pauses while an IndexedStack hides the map', (tester) async {
      final events = <MapEvent>[];
      Widget app(int index) => MaterialApp(
        home: IndexedStack(
          index: index,
          children: [
            MapLibreMap(options: offlineOptions(), onEvent: events.add),
            const SizedBox(),
          ],
        ),
      );
      await tester.pumpWidget(app(0));
      await tester.pumpWidget(app(1));
      await tester.pump();
      expect(
        events.whereType<MapEventRenderingChanged>().map((e) => e.paused),
        [true],
      );
      await tester.pumpWidget(app(0));
      await tester.pump();
      expect(
        events.whereType<MapEventRenderingChanged>().map((e) => e.paused),
        [true, false],
      );
    });
  }, skip: kIsWeb);
}
