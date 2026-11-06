import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'shared/test_map.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  runTests();
}

void runTests() {
  group('Events', () {
    testWidgets('report loading start before loading end', (tester) async {
      final map = await pumpMap(tester);
      final started = await map.waitForEvent<MapEventLoadingStarted>();
      final finished = await map.waitForEvent<MapEventLoadingFinished>();
      expect(
        map.events.indexOf(finished),
        greaterThan(map.events.indexOf(started)),
      );
    });

    testWidgets('report a style that fails to load', (tester) async {
      final map = await pumpMap(tester);
      final since = map.events.length;
      // Nothing listens on the discard port, so the request fails at once.
      await map.setOptions(
        const MapOptions(style: MapStyle.url('http://127.0.0.1:9/style.json')),
      );
      final error = await map.waitForEvent<MapEventError>(since: since);
      expect(error.message, isNotEmpty);
    });

    testWidgets('report an image that the style lacks', (tester) async {
      final map = await pumpMap(tester);
      final since = map.events.length;
      await map.style.sources.add(
        GeoJsonSource.data(
          id: 'points',
          data: jsonEncode({
            'type': 'Feature',
            'geometry': {
              'type': 'Point',
              'coordinates': [0, 0],
            },
          }),
        ),
      );
      await map.style.layers.add(
        SymbolStyleLayer(
          id: 'icons',
          sourceId: 'points',
          iconImage: const .literal('missing-icon'),
        ),
      );
      final missing = await map.waitForEvent<MapEventStyleImageMissing>(
        since: since,
      );
      expect(missing.id, 'missing-icon');
    });

    testWidgets('report a source whose data changed', (tester) async {
      final map = await pumpMap(tester);
      String collection(List<Object> coordinates) => jsonEncode({
        'type': 'FeatureCollection',
        'features': [
          for (final point in coordinates)
            {
              'type': 'Feature',
              'geometry': {'type': 'Point', 'coordinates': point},
            },
        ],
      });
      await map.style.sources.add(
        GeoJsonSource.data(id: 'changing', data: collection([])),
      );
      await tester.pump(const Duration(milliseconds: 500));
      final since = map.events.length;
      await map.style.sources.updateGeoJsonData(
        'changing',
        collection([
          [1, 1],
        ]),
      );
      await map.waitForEvent<MapEventSourceChanged>(
        since: since,
        where: (event) => event.sourceId == 'changing',
      );
    });

    testWidgets('report rendered frames while a callback listens', (
      tester,
    ) async {
      final frames = <MapEventRenderFrame>[];
      await tester.pumpWidget(
        MapApp(options: offlineOptions(), onRenderFrame: frames.add),
      );
      final deadline = DateTime.now().add(defaultTimeout);
      while (frames.isEmpty && DateTime.now().isBefore(deadline)) {
        await tester.pump(const Duration(milliseconds: 50));
      }
      expect(frames, isNotEmpty);
      if (!kIsWeb) {
        expect(frames.last.stats, isNotNull);
        expect(frames.last.fullyRendered, isNotNull);
      }
    });
  });
}
