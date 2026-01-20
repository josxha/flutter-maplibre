import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/webview/projection.dart';

void main() {
  group('WebViewProjection round-trip', () {
    const camera = MapCamera(
      center: Geographic(lon: 8.5, lat: 47.3),
      zoom: 5.5,
      bearing: 25,
      pitch: 40,
    );
    const mapSize = Size(1280, 720);

    test('center projects to screen center', () {
      final screen = WebViewProjection.toScreenLocation(
        camera,
        mapSize,
        camera.center,
      );
      expect(screen.dx, closeTo(mapSize.width / 2, 1e-6));
      expect(screen.dy, closeTo(mapSize.height / 2, 1e-6));
    });

    test('round-trip screen -> geo -> screen', () {
      const points = [
        Geographic(lon: 8.5, lat: 47.3), // center
        Geographic(lon: 9, lat: 47.3),
        Geographic(lon: 8.5, lat: 47.8),
        Geographic(lon: -73.9857, lat: 40.7484), // NYC
        Geographic(lon: 139.6917, lat: 35.6895), // Tokyo
      ];

      for (final geo in points) {
        final screen = WebViewProjection.toScreenLocation(camera, mapSize, geo);
        final back = WebViewProjection.toLngLat(camera, mapSize, screen);
        expect(back.lon, closeTo(geo.lon, 1e-6), reason: 'lon mismatch for $geo');
        expect(back.lat, closeTo(geo.lat, 1e-6), reason: 'lat mismatch for $geo');
      }
    });
  });
}
