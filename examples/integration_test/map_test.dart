import 'dart:async';

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
  group('MapLibreMap', () {
    testWidgets('reports creation and the loaded style in order', (
      tester,
    ) async {
      final map = await pumpMap(tester);
      final created = map.events.indexWhere((e) => e is MapEventMapCreated);
      final loaded = map.events.indexWhere((e) => e is MapEventStyleLoaded);
      expect(created, isNonNegative);
      expect(loaded, greaterThan(created));
      await tester.pump(const Duration(seconds: 1));
      expect(map.events.whereType<MapEventStyleLoaded>(), hasLength(1));
      expect(map.style.getLayerIds(), ['background']);
    });

    testWidgets('renders into a texture on native platforms', (tester) async {
      await pumpMap(tester);
      expect(
        find.descendant(
          of: find.byType(MapLibreMap),
          matching: find.byType(Texture),
        ),
        kIsWeb ? findsNothing : findsOneWidget,
      );
    }, skip: kIsWeb);

    testWidgets('starts at the camera of its options', (tester) async {
      final map = await pumpMap(
        tester,
        options: offlineOptions(
          center: const Geographic(lon: 12, lat: 34),
          zoom: 5,
          bearing: 30,
          pitch: 20,
        ),
      );
      final camera = map.controller.getCamera();
      expect(camera.center.lon, closeTo(12, 1e-6));
      expect(camera.center.lat, closeTo(34, 1e-6));
      expect(camera.zoom, closeTo(5, 1e-6));
      expect(camera.bearing, closeTo(30, 1e-6));
      expect(camera.pitch, closeTo(20, 1e-6));
      expect(map.controller.camera, isNotNull);
    });

    testWidgets('exposes its options', (tester) async {
      final options = offlineOptions(minZoom: 1, maxZoom: 12);
      final map = await pumpMap(tester, options: options);
      expect(map.controller.options, options);
    });

    testWidgets('applies new options without recreating the map', (
      tester,
    ) async {
      final map = await pumpMap(tester, options: offlineOptions(zoom: 3));
      final updated = offlineOptions(zoom: 3, maxZoom: 5);
      await tester.pumpWidget(MapApp(options: updated));
      await tester.pump();

      expect(map.controller.options, updated);
      await map.controller.moveCamera(zoom: 10);
      final camera = await map.waitForCamera((camera) => camera.zoom > 4);
      expect(camera.zoom, closeTo(5, 1e-6));
    });

    testWidgets('clamps the camera to the zoom and pitch limits', (
      tester,
    ) async {
      final map = await pumpMap(
        tester,
        options: MapOptions(
          initStyle: offlineStyle,
          initCenter: const Geographic(lon: 0, lat: 0),
          initZoom: 3,
          minZoom: 2,
          maxZoom: 6,
          maxPitch: 30,
        ),
      );
      await map.controller.moveCamera(zoom: 10, pitch: 60);
      var camera = await map.waitForCamera((camera) => camera.zoom > 3);
      expect(camera.zoom, closeTo(6, 1e-6));
      expect(camera.pitch, closeTo(30, 1e-6));

      await map.controller.moveCamera(zoom: 0);
      camera = await map.waitForCamera((camera) => camera.zoom < 6);
      expect(camera.zoom, closeTo(2, 1e-6));
    });

    testWidgets('loads a style set at runtime', (tester) async {
      final map = await pumpMap(tester);
      final since = map.events.length;
      map.controller.setStyle(
        '{"version":8,"sources":{},"layers":[{"id":"other",'
        '"type":"background","paint":{"background-color":"#000000"}}]}',
      );
      await map.waitForEvent<MapEventStyleLoaded>(since: since);
      expect(map.controller.style?.getLayerIds(), ['other']);
    });

    testWidgets('can be removed and shown again', (tester) async {
      await pumpMap(tester);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 100));
      final map = await pumpMap(tester);
      expect(map.style.getLayerIds(), ['background']);
    });

    testWidgets('shows two maps with independent cameras', (tester) async {
      final controllers = [
        Completer<MapController>(),
        Completer<MapController>(),
      ];
      final styles = [Completer<void>(), Completer<void>()];
      await tester.pumpWidget(
        MaterialApp(
          home: Row(
            children: [
              for (final (i, lon) in [(0, -40.0), (1, 40.0)])
                Expanded(
                  child: MapLibreMap(
                    options: offlineOptions(
                      center: Geographic(lon: lon, lat: 0),
                    ),
                    onMapCreated: controllers[i].complete,
                    onStyleLoaded: (_) => styles[i].complete(),
                  ),
                ),
            ],
          ),
        ),
      );
      final left = await controllers[0].future;
      final right = await controllers[1].future;
      await Future.wait(styles.map((style) => style.future));

      expect(left.getCamera().center.lon, closeTo(-40, 1e-6));
      expect(right.getCamera().center.lon, closeTo(40, 1e-6));
      await left.moveCamera(zoom: 6);
      await tester.pump(const Duration(milliseconds: 200));
      expect(left.getCamera().zoom, closeTo(6, 1e-6));
      expect(right.getCamera().zoom, closeTo(4, 1e-6));
    });
  });
}
