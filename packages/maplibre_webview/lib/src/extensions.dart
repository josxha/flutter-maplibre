import 'dart:math';

import 'package:flutter/painting.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// 2*pi
const double twoPi = pi * 2;

/// MapLibre tile size in pixels.
const double tileSize = 512;

/// Extensions for [Geographic].
extension GeographicExt on Geographic {
  /// Projects this [Geographic] coordinate into WebMercator world space
  /// in the range `[0, tileSize]`.
  ///
  /// This matches MapLibre / Mapbox internal projection math.
  Offset projectWebMercator() {
    final x = tileSize * (lon + 180.0) / 360.0;

    final sinLat = sin(lat.toRadians());
    final y =
        tileSize * (0.5 - log((1.0 + sinLat) / (1.0 - sinLat)) / (4.0 * pi));

    return Offset(x, y);
  }
}

/// Extensions for [Offset].
extension OffsetExt on Offset {
  /// Unprojects a WebMercator world coordinate (in `[0, tileSize]`)
  /// back into geographic coordinates.
  Geographic unprojectWebMercator() {
    final lon = dx / tileSize * 360.0 - 180.0;

    final y = twoPi * (0.5 - dy / tileSize);
    final lat = atan(_sinh(y)).toDegrees();

    return Geographic(lon: lon, lat: lat);
  }
}

/// Extensions for [MapCamera].
extension MapCameraExt on MapCamera {
  /// Calculates the WebMercator world size (in pixels) at the current zoom
  /// level.
  double get worldScale => pow(2.0, zoom) * tileSize;

  /// Center of the map in world coordinates.
  Offset get centerWorld => center.projectWebMercator() * worldScale;
}

double _sinh(double x) {
  final e = exp(x);
  return (e - 1.0 / e) / 2.0;
}
