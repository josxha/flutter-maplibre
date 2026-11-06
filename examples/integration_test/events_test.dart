import 'dart:async';
import 'dart:io';

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
      // A browser fails at once on the discard port, where nothing listens.
      // MapLibre Native retries a refused connection, but not a 404.
      var url = 'http://127.0.0.1:9/style.json';
      if (!kIsWeb) {
        final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        addTearDown(() => server.close(force: true));
        server.listen((request) {
          request.response.statusCode = HttpStatus.notFound;
          unawaited(request.response.close());
        });
        url = 'http://127.0.0.1:${server.port}/style.json';
      }
      await map.setOptions(MapOptions(style: MapStyle.url(url)));
      final error = await map.waitForEvent<MapEventError>(since: since);
      expect(error.message, isNotEmpty);
    });

    testWidgets('report an image that the style lacks', (tester) async {
      final map = await pumpMap(tester);
      final since = map.events.length;
      await map.style.sources.add(
        const GeoJsonSource.data(
          id: 'points',
          data: .json({
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

    testWidgets('report a change of the projection', (tester) async {
      final map = await pumpMap(tester, options: offlineOptions(zoom: 1));
      final since = map.events.length;
      map.style.setProjection(const .literal(.verticalPerspective));
      final changed = await map.waitForEvent<MapEventProjectionChanged>(
        since: since,
      );
      expect(changed.projection, MapProjection.verticalPerspective);
    }, skip: !kIsWeb);

    testWidgets('report a source whose data changed', (tester) async {
      final map = await pumpMap(tester);
      GeoJsonData collection(List<Object> coordinates) => .json({
        'type': 'FeatureCollection',
        'features': [
          for (final point in coordinates)
            {
              'type': 'Feature',
              'geometry': {'type': 'Point', 'coordinates': point},
            },
        ],
      });
      final beforeAdd = map.events.length;
      await map.style.sources.add(
        GeoJsonSource.data(id: 'changing', data: collection([])),
      );
      // Native maps don't report the added source, web maps do. Once the map
      // is idle, the event of the added source has arrived where there is one.
      await map.waitForEvent<MapEventIdle>(since: beforeAdd);
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
