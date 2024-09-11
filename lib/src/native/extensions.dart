import 'dart:ui';

import 'package:geotypes/geotypes.dart';
import 'package:maplibre/src/native/pigeon.g.dart';

/// Extension methods for the [Position] class. Not exported publicly.
extension PositionExt on Position {
  /// Convert a [Position] to an internal [LngLat].
  LngLat toLngLat() => LngLat(lng: lng.toDouble(), lat: lat.toDouble());
}
/// Extension methods for the [LngLat] class. Not exported publicly.
extension LngLatExt on LngLat {
  /// Convert an internal [LngLat] to a [Position].
  Position toPosition() => Position(lng, lat);
}
/// Extension methods for the [Offset] class. Not exported publicly.
extension OffsetExt on Offset {
  /// Convert an [Offset] to an internal [ScreenLocation].
  ScreenLocation toScreenLocation() => ScreenLocation(x: dx, y: dy);
}
