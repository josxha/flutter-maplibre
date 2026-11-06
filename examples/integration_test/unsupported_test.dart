import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'shared/test_map.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  runTests();
}

/// Features that neither implementation offers yet. These tests document that
/// they fail clearly, and are to be replaced once a platform supports them.
void runTests() {
  group('unsupported features', () {
    test('OfflineManager on web', () async {
      await expectLater(
        OfflineManager.createInstance(),
        throwsA(isA<UnsupportedError>()),
      );
    }, skip: !kIsWeb);

    testWidgets('the globe projection on native keeps Mercator', (
      tester,
    ) async {
      final map = await pumpMap(
        tester,
        options: offlineOptions(center: const Geographic(lon: 1, lat: 2)),
      );
      final before = map.controller.toScreenLocation(
        const Geographic(lon: 30, lat: 40),
      );
      map.style.setProjection(const .literal(.globe));
      await map.controller.moveCamera(const CameraUpdate.position(zoom: 4));
      await map.waitForLatestFrame();
      final after = map.controller.toScreenLocation(
        const Geographic(lon: 30, lat: 40),
      );
      expect(after.dx, closeTo(before.dx, 0.5));
      expect(after.dy, closeTo(before.dy, 0.5));

      map.style.setProjection(
        .interpolate(const .linear(), .zoom(), {
          2: const .literal(.verticalPerspective),
          6: const .literal(.mercator),
        }),
      );
      await map.waitForLatestFrame();
      final interpolated = map.controller.toScreenLocation(
        const Geographic(lon: 30, lat: 40),
      );
      expect(interpolated.dx, closeTo(before.dx, 0.5));
      expect(interpolated.dy, closeTo(before.dy, 0.5));
    }, skip: kIsWeb);

    testWidgets('video sources on native', (tester) async {
      final map = await pumpMap(tester);
      await expectLater(
        map.style.sources.add(
          const VideoSource.urls(
            id: 'video',
            urls: ['https://example.com/video.mp4'],
            coordinates: LngLatQuad(
              bottomLeft: Geographic(lon: -10, lat: -10),
              bottomRight: Geographic(lon: 10, lat: -10),
              topLeft: Geographic(lon: -10, lat: 10),
              topRight: Geographic(lon: 10, lat: 10),
            ),
          ),
        ),
        throwsA(isA<UnsupportedError>()),
      );
    }, skip: kIsWeb);
  });
}
