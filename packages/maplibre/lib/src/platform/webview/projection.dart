import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/webview/extensions.dart';

/// Pure helpers to project/unproject using the same math as the webview state.
class WebViewProjection {
  const WebViewProjection._();

  static double _wrapDelta(double dx, double worldSize) {
    var wrapped = (dx + worldSize / 2) % worldSize;
    if (wrapped < 0) wrapped += worldSize;
    return wrapped - worldSize / 2;
  }

  /// Converts geographic coordinates to screen space (CSS / logical pixels).
  static Offset toScreenLocation(
    MapCamera camera,
    Size mapSize,
    Geographic lngLat,
  ) {
    final scale = pow(2.0, camera.zoom) as double;
    final centerWorld = camera.center.projectWebMercator() * scale;
    final worldSizePx = tileSize * scale;

    // World-space delta from center, wrapped to nearest world
    var p = lngLat.projectWebMercator() * scale - centerWorld;
    p = Offset(_wrapDelta(p.dx, worldSizePx), p.dy);

    // Apply bearing rotation (screen coords rotate opposite)
    final bearingRad = -camera.bearing.toRadians();
    final cosB = cos(bearingRad);
    final sinB = sin(bearingRad);
    p = Offset(p.dx * cosB - p.dy * sinB, p.dx * sinB + p.dy * cosB);

    // Apply pitch (vertical compression)
    final pitchRad = camera.pitch.toRadians();
    p = Offset(p.dx, p.dy * cos(pitchRad));

    // Translate origin back to top-left
    return Offset(mapSize.width / 2 + p.dx, mapSize.height / 2 + p.dy);
  }

  /// Converts screen space (CSS / logical pixels) back to geographic coords.
  static Geographic toLngLat(
    MapCamera camera,
    Size mapSize,
    Offset screenPoint,
  ) {
    final scale = pow(2.0, camera.zoom) as double;
    final centerWorld = camera.center.projectWebMercator() * scale;
    final worldSizePx = tileSize * scale;

    // MapLibre GL JS reports CSS pixels; Flutter logical pixels match in platform views.
    var p = Offset(
      screenPoint.dx - mapSize.width / 2,
      screenPoint.dy - mapSize.height / 2,
    );

    // Undo pitch (vertical stretch)
    final pitchRad = camera.pitch.toRadians();
    p = Offset(p.dx, p.dy / cos(pitchRad));

    // Undo bearing rotation
    final bearingRad = camera.bearing.toRadians();
    final cosB = cos(bearingRad);
    final sinB = sin(bearingRad);
    p = Offset(p.dx * cosB - p.dy * sinB, p.dx * sinB + p.dy * cosB);

    // Back to world space and unproject
    final world = centerWorld + Offset(_wrapDelta(p.dx, worldSizePx), p.dy);
    return (world / scale).unprojectWebMercator();
  }
}
