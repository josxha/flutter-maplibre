import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'shared/test_map.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  runTests();
}

/// At zoom 4 the world is 8192 logical pixels wide, so every screen corner
/// lies on the same world copy however wide the window is.
MapOptions _options() =>
    offlineOptions(center: const Geographic(lon: 1, lat: 2));

void runTests() {
  group('projection', () {
    testWidgets('the center of the camera is the center of the map', (
      tester,
    ) async {
      final map = await pumpMap(tester, options: _options());
      final center = map.controller.toScreenLocation(
        const Geographic(lon: 1, lat: 2),
      );
      expect(center.dx, closeTo(map.center.dx, 0.5));
      expect(center.dy, closeTo(map.center.dy, 0.5));
      // The native map has whole logical pixels, so its center can be half a
      // pixel, 0.022 degrees at zoom 4, away from the center of the widget.
      final lngLat = map.controller.toLngLat(map.center);
      expect(lngLat.lon, closeTo(1, 0.03));
      expect(lngLat.lat, closeTo(2, 0.03));
    });

    testWidgets('the corners of the map are the visible region', (
      tester,
    ) async {
      final map = await pumpMap(tester, options: _options());
      final size = map.size;
      final region = map.controller.getVisibleRegion();
      final corners = {
        Offset.zero: Geographic(
          lon: region.longitudeWest,
          lat: region.latitudeNorth,
        ),
        Offset(size.width, 0): Geographic(
          lon: region.longitudeEast,
          lat: region.latitudeNorth,
        ),
        Offset(0, size.height): Geographic(
          lon: region.longitudeWest,
          lat: region.latitudeSouth,
        ),
        Offset(size.width, size.height): Geographic(
          lon: region.longitudeEast,
          lat: region.latitudeSouth,
        ),
      };
      for (final MapEntry(key: screen, value: lngLat) in corners.entries) {
        final offset = map.controller.toScreenLocation(lngLat);
        expect(offset.dx, closeTo(screen.dx, 1), reason: '$lngLat');
        expect(offset.dy, closeTo(screen.dy, 1), reason: '$lngLat');
        final back = map.controller.toLngLat(screen);
        expect(back.lon, closeTo(lngLat.lon, 1e-4), reason: '$screen');
        expect(back.lat, closeTo(lngLat.lat, 1e-4), reason: '$screen');
      }

      final offsets = map.controller.toScreenLocations(corners.values.toList());
      final lngLats = map.controller.toLngLats(corners.keys.toList());
      for (final (i, MapEntry(key: screen, value: lngLat))
          in corners.entries.indexed) {
        expect(offsets[i].dx, closeTo(screen.dx, 1));
        expect(offsets[i].dy, closeTo(screen.dy, 1));
        expect(lngLats[i].lon, closeTo(lngLat.lon, 1e-4));
        expect(lngLats[i].lat, closeTo(lngLat.lat, 1e-4));
      }
    });

    testWidgets('screen locations round-trip on a rotated, tilted map', (
      tester,
    ) async {
      final map = await pumpMap(
        tester,
        options: offlineOptions(
          center: const Geographic(lon: 8, lat: 47),
          zoom: 6,
          bearing: 40,
          pitch: 30,
        ),
      );
      final points = [
        map.center,
        map.center + const Offset(-120, 80),
        map.center + const Offset(150, -60),
      ];
      final lngLats = map.controller.toLngLats(points);
      final back = map.controller.toScreenLocations(lngLats);
      for (var i = 0; i < points.length; i++) {
        expect(back[i].dx, closeTo(points[i].dx, 0.5));
        expect(back[i].dy, closeTo(points[i].dy, 0.5));
      }
      // Without tilt, east is turned 40 degrees counterclockwise on screen.
      await map.controller.moveCamera(pitch: 0);
      await map.waitForLatestFrame();
      final east = map.controller.toScreenLocation(
        const Geographic(lon: 9, lat: 47),
      );
      final angle = atan2(east.dy - map.center.dy, east.dx - map.center.dx);
      expect(angle * 180 / pi, closeTo(-40, 2));
    });

    testWidgets('getMetersPerPixelAtLatitude matches the projection', (
      tester,
    ) async {
      final map = await pumpMap(
        tester,
        options: offlineOptions(
          center: const Geographic(lon: 111.6513, lat: 35.1983),
          zoom: 14,
        ),
      );
      final y = map.size.height / 4;
      final left = map.controller.toLngLat(Offset(0, y));
      final right = map.controller.toLngLat(Offset(100, y));
      final metersPerPixel = map.controller.getMetersPerPixelAtLatitude(
        left.lat,
      );
      final meters =
          6378137 *
          (right.lon - left.lon).abs() *
          pi /
          180 *
          cos(left.lat * pi / 180);
      expect(metersPerPixel * 100, closeTo(meters, meters * 0.01));
      // The scale halves with every zoom level.
      await map.controller.moveCamera(zoom: 15);
      await map.waitForLatestFrame();
      expect(
        map.controller.getMetersPerPixelAtLatitude(left.lat),
        closeTo(metersPerPixel / 2, metersPerPixel * 0.001),
      );
    });

    testWidgets('getVisibleRegion surrounds the center', (tester) async {
      final map = await pumpMap(tester, options: offlineOptions(zoom: 10));
      final region = map.controller.getVisibleRegion();
      expect(region.longitudeWest, inExclusiveRange(-10, 0));
      expect(region.longitudeEast, inExclusiveRange(0, 10));
      expect(region.latitudeSouth, inExclusiveRange(-10, 0));
      expect(region.latitudeNorth, inExclusiveRange(0, 10));
      // A zoom level out doubles the visible longitudes.
      final width = region.longitudeEast - region.longitudeWest;
      await map.controller.moveCamera(zoom: 9);
      await map.waitForLatestFrame();
      final wider = map.controller.getVisibleRegion();
      expect(
        wider.longitudeEast - wider.longitudeWest,
        closeTo(width * 2, width * 0.01),
      );
    });
  });
}
