import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
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
        const CameraUpdate.position(
          center: Geographic(lon: 1, lat: 2),
          zoom: 5,
          bearing: 10,
          pitch: 20,
        ),
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
      await map.controller.moveCamera(const CameraUpdate.position(zoom: 7));
      final camera = map.controller.getCamera();
      expect(camera.zoom, closeTo(7, 1e-6));
      expect(camera.center.lon, closeTo(5, 1e-6));
      expect(camera.center.lat, closeTo(6, 1e-6));
      expect(camera.bearing, closeTo(15, 1e-6));
    });

    testWidgets('moveCamera reports the camera events', (tester) async {
      final map = await pumpMap(tester);
      final since = map.events.length;
      await map.controller.moveCamera(const CameraUpdate.position(zoom: 6));
      final moved = await map.waitForEvent<MapEventCameraMove>(since: since);
      expect(moved.camera.zoom, closeTo(6, 1e-6));
      expect(moved.reason, CameraChangeReason.programmatic);
      final end = await map.waitForEvent<MapEventCameraMoveEnd>(since: since);
      expect(end.camera.zoom, closeTo(6, 1e-6));
      expect(end.reason, CameraChangeReason.programmatic);
      final start = map.events
          .skip(since)
          .whereType<MapEventCameraMoveStart>()
          .first;
      expect(start.reason, CameraChangeReason.programmatic);
    });

    testWidgets('the camera widgets see follows the frame on screen', (
      tester,
    ) async {
      final map = await pumpMap(tester);
      await map.controller.moveCamera(
        const CameraUpdate.position(center: Geographic(lon: 20, lat: 10)),
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
      final result = await map.pumpFuture(
        map.controller.animateCamera(
          const CameraUpdate.position(
            center: Geographic(lon: 30, lat: 20),
            zoom: 6,
            bearing: 45,
            pitch: 30,
          ),
          // Long enough that a slow CI runner reads the camera mid-way.
          animation: const CameraAnimation.fly(duration: Duration(seconds: 1)),
        ),
        reason: 'animateCamera',
      );
      expect(result, CameraAnimationResult.completed);
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
          .whereType<MapEventCameraMove>()
          .map((event) => event.camera.zoom)
          .where((zoom) => zoom > 4.01 && zoom < 5.99);
      expect(zooms, isNotEmpty);
    });

    testWidgets('animateCamera eases to the new camera', (tester) async {
      final map = await pumpMap(tester);
      final result = await map.pumpFuture(
        map.controller.animateCamera(
          const CameraUpdate.position(zoom: 6, bearing: 30, roll: 10),
          animation: const CameraAnimation.ease(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeOut,
          ),
        ),
        reason: 'animateCamera',
      );
      expect(result, CameraAnimationResult.completed);
      final camera = map.controller.getCamera();
      expect(camera.zoom, closeTo(6, 1e-4));
      expect(camera.bearing, closeTo(30, 1e-4));
      expect(camera.roll, closeTo(10, 1e-4));
    });

    testWidgets('fitting bounds shows the bounds', (tester) async {
      final map = await pumpMap(tester, options: offlineOptions(zoom: 1));
      const bounds = GeoBox(west: 10, east: 20, south: 40, north: 50);
      await map.pumpFuture(
        map.controller.animateCamera(
          const CameraUpdate.bounds(bounds),
          animation: const CameraAnimation.ease(
            duration: Duration(milliseconds: 100),
          ),
        ),
        reason: 'fit bounds',
      );
      await map.waitForLatestFrame();
      final region = map.controller.getVisibleBounds();
      expect(region.west, lessThanOrEqualTo(10 + 1e-3));
      expect(region.east, greaterThanOrEqualTo(20 - 1e-3));
      expect(region.south, lessThanOrEqualTo(40 + 1e-3));
      expect(region.north, greaterThanOrEqualTo(50 - 1e-3));
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
        const CameraUpdate.position(
          center: Geographic(lon: 0, lat: 0),
          padding: EdgeInsets.only(top: 200),
        ),
      );
      // Padding is not part of MapCamera, so waitForLatestFrame can't tell a
      // frame with it from the earlier frame at the same center.
      Offset center() =>
          map.controller.toScreenLocation(const Geographic(lon: 0, lat: 0));
      await map.pumpUntil(
        () => (center().dy - map.center.dy - 100).abs() < 1,
        reason: () => 'center at ${center()}, map center at ${map.center}',
      );
      expect(center().dx, closeTo(map.center.dx, 1));
    });

    testWidgets('fitting points shows every point', (tester) async {
      final map = await pumpMap(tester, options: offlineOptions(zoom: 1));
      await map.controller.moveCamera(
        const CameraUpdate.points([
          Geographic(lon: -30, lat: 10),
          Geographic(lon: 0, lat: -20),
          Geographic(lon: 30, lat: 25),
        ]),
      );
      await map.waitForLatestFrame();
      final bounds = map.controller.getVisibleBounds();
      expect(bounds.west, lessThanOrEqualTo(-30 + 1e-3));
      expect(bounds.east, greaterThanOrEqualTo(30 - 1e-3));
      expect(bounds.south, lessThanOrEqualTo(-20 + 1e-3));
      expect(bounds.north, greaterThanOrEqualTo(25 - 1e-3));
    });

    testWidgets('fitting a geometry respects maxZoom', (tester) async {
      final map = await pumpMap(tester, options: offlineOptions(zoom: 1));
      await map.controller.moveCamera(
        CameraUpdate.geometry(
          LineString.from(const [
            Geographic(lon: 8, lat: 47),
            Geographic(lon: 8.001, lat: 47.001),
          ]),
          maxZoom: 10,
        ),
      );
      final camera = map.controller.getCamera();
      expect(camera.zoom, closeTo(10, 1e-6));
      expect(camera.center.lon, closeTo(8.0005, 1e-3));
      expect(camera.center.lat, closeTo(47.0005, 1e-3));
    });

    testWidgets('cameraFor computes a camera without moving the map', (
      tester,
    ) async {
      final map = await pumpMap(tester, options: offlineOptions(zoom: 1));
      final before = map.controller.getCamera();
      final camera = await map.controller.cameraFor(
        const CameraUpdate.bounds(
          GeoBox(west: 10, east: 20, south: 40, north: 50),
        ),
      );
      expect(camera.zoom, greaterThan(before.zoom + 1));
      expect(camera.center.lon, closeTo(15, 0.5));
      expect(map.controller.getCamera(), before);
      await map.controller.moveCamera(camera.toCameraUpdate());
      final moved = map.controller.getCamera();
      expect(moved.zoom, closeTo(camera.zoom, 1e-6));
      expect(moved.center.lon, closeTo(camera.center.lon, 1e-6));
      expect(moved.center.lat, closeTo(camera.center.lat, 1e-6));
    });

    testWidgets('fitting bounds replaces padding from a previous camera move', (
      tester,
    ) async {
      final map = await pumpMap(tester);
      await map.controller.moveCamera(
        const CameraUpdate.position(
          zoom: 4,
          padding: EdgeInsets.only(bottom: 200),
        ),
      );
      await map.pumpFuture(
        map.controller.animateCamera(
          const CameraUpdate.bounds(
            GeoBox(west: -10, east: 10, south: -10, north: 10),
          ),
          animation: const CameraAnimation.ease(
            duration: Duration(milliseconds: 100),
          ),
        ),
        reason: 'fit bounds',
      );
      await map.waitForLatestFrame();
      final center = map.controller.toScreenLocation(
        const Geographic(lon: 0, lat: 0),
      );
      expect(center.dx, closeTo(map.center.dx, 1));
      expect(center.dy, closeTo(map.center.dy, 1));
    });

    testWidgets('stopCamera cancels a running animation', (tester) async {
      final map = await pumpMap(tester);
      final animation = map.controller.animateCamera(
        const CameraUpdate.position(zoom: 8),
        animation: const CameraAnimation.ease(duration: Duration(seconds: 10)),
      );
      await tester.pump(const Duration(milliseconds: 300));
      await map.controller.stopCamera();
      final result = await map.pumpFuture(animation, reason: 'animation');
      final zoom = map.controller.getCamera().zoom;
      // On web, the animation already jumped to its end if the browser
      // prefers reduced motion, as headless Chrome does.
      if (kIsWeb && result == CameraAnimationResult.completed) {
        expect(zoom, closeTo(8, 1e-6));
      } else {
        expect(result, CameraAnimationResult.cancelled);
        expect(zoom, lessThan(7));
      }
    });

    testWidgets('a new camera move cancels a running animation', (
      tester,
    ) async {
      final map = await pumpMap(tester);
      final animation = map.controller.animateCamera(
        const CameraUpdate.position(
          center: Geographic(lon: 80, lat: 30),
          zoom: 6,
        ),
        animation: const CameraAnimation.fly(duration: Duration(seconds: 10)),
      );
      await tester.pump(const Duration(milliseconds: 300));
      await map.controller.moveCamera(
        const CameraUpdate.position(
          center: Geographic(lon: -20, lat: -10),
          zoom: 3,
        ),
      );
      final result = await map.pumpFuture(animation, reason: 'animation');
      // On web, the animation already jumped to its end if the browser
      // prefers reduced motion, as headless Chrome does.
      expect(
        result,
        kIsWeb
            ? isIn(CameraAnimationResult.values)
            : CameraAnimationResult.cancelled,
      );
      final camera = map.controller.getCamera();
      expect(camera.zoom, closeTo(3, 1e-6));
      expect(camera.center.lon, closeTo(-20, 1e-6));
    });
  });
}
