import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'shared/test_map.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  runTests();
}

void runTests() {
  group('camera', () {
    testWidgets('moveCamera jumps to the new camera', (tester) async {
      final map = await pumpMap(tester);
      await map.controller.moveCamera(
        center: const Geographic(lon: 1, lat: 2),
        zoom: 5,
        bearing: 10,
        pitch: 20,
      );
      final camera = map.controller.getCamera();
      expect(camera.center.lon, closeTo(1, 1e-6));
      expect(camera.center.lat, closeTo(2, 1e-6));
      expect(camera.zoom, closeTo(5, 1e-6));
      expect(camera.bearing, closeTo(10, 1e-6));
      expect(camera.pitch, closeTo(20, 1e-6));
    });

    testWidgets('moveCamera keeps the values it is not given', (tester) async {
      final map = await pumpMap(
        tester,
        options: offlineOptions(
          center: const Geographic(lon: 5, lat: 6),
          zoom: 3,
          bearing: 15,
        ),
      );
      await map.controller.moveCamera(zoom: 7);
      final camera = map.controller.getCamera();
      expect(camera.zoom, closeTo(7, 1e-6));
      expect(camera.center.lon, closeTo(5, 1e-6));
      expect(camera.center.lat, closeTo(6, 1e-6));
      expect(camera.bearing, closeTo(15, 1e-6));
    });

    testWidgets('moveCamera reports the camera events', (tester) async {
      final map = await pumpMap(tester);
      final since = map.events.length;
      await map.controller.moveCamera(zoom: 6);
      final moved = await map.waitForEvent<MapEventMoveCamera>(since: since);
      expect(moved.camera.zoom, closeTo(6, 1e-6));
      await map.waitForEvent<MapEventCameraIdle>(since: since);
      final start = map.events
          .skip(since)
          .whereType<MapEventStartMoveCamera>()
          .first;
      expect(start.reason, CameraChangeReason.developerAnimation);
    });

    testWidgets('the camera widgets see follows the frame on screen', (
      tester,
    ) async {
      final map = await pumpMap(tester);
      await map.controller.moveCamera(
        center: const Geographic(lon: 20, lat: 10),
      );
      final camera = await map.waitForCamera(
        (_) => (map.controller.camera?.center.lon ?? 0) > 19.99,
      );
      expect(map.controller.camera!.center.lon, closeTo(20, 1e-6));
      expect(camera.center.lat, closeTo(10, 1e-6));
    });

    testWidgets('animateCamera completes at the new camera', (tester) async {
      final map = await pumpMap(tester);
      final since = map.events.length;
      await map.pumpFuture(
        map.controller.animateCamera(
          center: const Geographic(lon: 30, lat: 20),
          zoom: 6,
          bearing: 45,
          pitch: 30,
          nativeDuration: const Duration(milliseconds: 300),
          webMaxDuration: const Duration(milliseconds: 300),
        ),
        reason: 'animateCamera',
      );
      final camera = map.controller.getCamera();
      expect(camera.center.lon, closeTo(30, 1e-4));
      expect(camera.center.lat, closeTo(20, 1e-4));
      expect(camera.zoom, closeTo(6, 1e-4));
      expect(camera.bearing, closeTo(45, 1e-4));
      expect(camera.pitch, closeTo(30, 1e-4));
      // An animation passes through cameras between the two ends, unless the
      // browser prefers reduced motion, as headless Chrome does.
      if (kIsWeb) return;
      final zooms = map.events
          .skip(since)
          .whereType<MapEventMoveCamera>()
          .map((event) => event.camera.zoom)
          .where((zoom) => zoom > 4.01 && zoom < 5.99);
      expect(zooms, isNotEmpty);
    });

    testWidgets('fitBounds shows the bounds', (tester) async {
      final map = await pumpMap(tester, options: offlineOptions(zoom: 1));
      const bounds = LngLatBounds(
        longitudeWest: 10,
        longitudeEast: 20,
        latitudeSouth: 40,
        latitudeNorth: 50,
      );
      await map.pumpFuture(
        map.controller.fitBounds(
          bounds: bounds,
          nativeDuration: const Duration(milliseconds: 100),
          webMaxDuration: const Duration(milliseconds: 100),
        ),
        reason: 'fitBounds',
      );
      await map.waitForLatestFrame();
      final region = map.controller.getVisibleRegion();
      expect(region.longitudeWest, lessThanOrEqualTo(10 + 1e-3));
      expect(region.longitudeEast, greaterThanOrEqualTo(20 - 1e-3));
      expect(region.latitudeSouth, lessThanOrEqualTo(40 + 1e-3));
      expect(region.latitudeNorth, greaterThanOrEqualTo(50 - 1e-3));
      // The bounds fill the map in at least one direction.
      final west = map.controller.toScreenLocation(
        const Geographic(lon: 10, lat: 45),
      );
      final north = map.controller.toScreenLocation(
        const Geographic(lon: 15, lat: 50),
      );
      expect(
        west.dx < 2 || north.dy < 2,
        isTrue,
        reason: 'west edge at $west, north edge at $north',
      );
    });

    testWidgets('padding moves the center of the camera', (tester) async {
      final map = await pumpMap(tester);
      await map.controller.moveCamera(
        center: const Geographic(lon: 0, lat: 0),
        padding: const EdgeInsets.only(top: 200),
      );
      await map.waitForLatestFrame();
      final center = map.controller.toScreenLocation(
        const Geographic(lon: 0, lat: 0),
      );
      expect(center.dx, closeTo(map.center.dx, 1));
      expect(center.dy, closeTo(map.center.dy + 100, 1));
    });

    testWidgets('fitBounds replaces padding from a previous camera move', (
      tester,
    ) async {
      final map = await pumpMap(tester);
      await map.controller.moveCamera(
        zoom: 4,
        padding: const EdgeInsets.only(bottom: 200),
      );
      await map.pumpFuture(
        map.controller.fitBounds(
          bounds: const LngLatBounds(
            longitudeWest: -10,
            longitudeEast: 10,
            latitudeSouth: -10,
            latitudeNorth: 10,
          ),
          nativeDuration: const Duration(milliseconds: 100),
          webMaxDuration: const Duration(milliseconds: 100),
        ),
        reason: 'fitBounds',
      );
      await map.waitForLatestFrame();
      final center = map.controller.toScreenLocation(
        const Geographic(lon: 0, lat: 0),
      );
      expect(center.dx, closeTo(map.center.dx, 1));
      expect(center.dy, closeTo(map.center.dy, 1));
    });

    testWidgets('a new camera move cancels a running animation', (
      tester,
    ) async {
      final map = await pumpMap(tester);
      final animation = map.controller
          .animateCamera(
            center: const Geographic(lon: 80, lat: 30),
            zoom: 6,
            nativeDuration: const Duration(seconds: 10),
            webSpeed: 0.1,
            webMaxDuration: const Duration(seconds: 10),
          )
          .then<Object?>((_) => null, onError: (Object error) => error);
      await tester.pump(const Duration(milliseconds: 300));
      await map.controller.moveCamera(
        center: const Geographic(lon: -20, lat: -10),
        zoom: 3,
      );
      final result = await map.pumpFuture(animation, reason: 'animation');
      // Web reports the cancellation, unless the animation already jumped to
      // its end because the browser prefers reduced motion.
      if (kIsWeb && result != null) {
        expect(
          result,
          isA<PlatformException>().having(
            (error) => error.code,
            'code',
            'CancellationException',
          ),
        );
      }
      await tester.pump(const Duration(milliseconds: 500));
      final camera = map.controller.getCamera();
      expect(camera.center.lon, closeTo(-20, 1e-4));
      expect(camera.zoom, closeTo(3, 1e-4));
    });
  });
}
