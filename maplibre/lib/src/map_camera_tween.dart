import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:maplibre/maplibre.dart';

/// A tween for smoothly interpolating between two [MapCamera] states.
class MapCameraTween extends Tween<MapCamera> {
  /// Creates a [MapCameraTween] with the given [begin] and [end] camera states.
  MapCameraTween({required MapCamera begin, required MapCamera end})
    : super(begin: begin, end: end);

  @override
  MapCamera lerp(double t) {
    return MapCamera(
      center: begin!.center.intermediatePointTo(end!.center, fraction: t),
      zoom: lerpDouble(begin!.zoom, end!.zoom, t)!,
      bearing: lerpDouble(begin!.bearing, end!.bearing, t)!,
      pitch: lerpDouble(begin!.pitch, end!.pitch, t)!,
    );
  }
}
