import 'package:flutter/rendering.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/native/jni/jni.dart' as jni;
import 'package:maplibre/src/native/pigeon.g.dart' as pigeon;

/// Extension methods for the [Position] class. Not exported publicly.
extension PositionExt on Position {
  /// Convert a [Position] to an internal [pigeon.LngLat].
  pigeon.LngLat toLngLat() => pigeon.LngLat(
        lng: lng.toDouble(),
        lat: lat.toDouble(),
      );

  /// Convert a [Position] to an [jni.LatLng].
  jni.LatLng toLatLng() => jni.LatLng.new$1(lat.toDouble(), lng.toDouble());
}

/// Extension methods for the [pigeon.LngLat] class. Not exported publicly.
extension LngLatExt on pigeon.LngLat {
  /// Convert an internal [pigeon.LngLat] to a [Position].
  Position toPosition() => Position(lng, lat);
}

/// Extension methods for the [jni.LatLng] class. Not exported publicly.
extension JniLatLngExt on jni.LatLng {
  /// Convert an internal [jni.LatLng] to a [Position].
  Position toPosition({bool releaseOriginal = false}) {
    final position = Position(getLongitude(), getLatitude());
    if (releaseOriginal) release();
    return position;
  }
}

/// Extension methods for the [jni.PointF] class. Not exported publicly.
extension PointExt on jni.PointF {
  /// Convert an [jni.PointF] to a [Offset].
  Offset toOffset({bool releaseOriginal = false}) {
    final offset = Offset(x, y);
    if (releaseOriginal) release();
    return offset;
  }
}

/// Extension methods for the [Offset] class. Not exported publicly.
extension OffsetExt on Offset {
  /// Convert an [Offset] to an internal [pigeon.Offset].
  pigeon.Offset toOffset() => pigeon.Offset(x: dx, y: dy);

  /// Convert an [Offset] to an [jni.PointF].
  jni.PointF toPointF() => jni.PointF.new$1(dx, dy);
}

/// Extension methods for the [LngLatBounds] class. Not exported publicly.
extension LngLatBoundsExt on LngLatBounds {
  /// Convert an [LngLatBounds] to an internal [pigeon.LngLatBounds].
  pigeon.LngLatBounds toLngLatBounds() => pigeon.LngLatBounds(
        longitudeEast: longitudeEast,
        longitudeWest: longitudeWest,
        latitudeNorth: latitudeNorth,
        latitudeSouth: latitudeSouth,
      );

  /// Convert an [LngLatBounds] to an internal [jni.LatLngBounds].
  jni.LatLngBounds toLatLngBounds() => jni.LatLngBounds.from(
        latitudeNorth,
        longitudeEast,
        latitudeSouth,
        longitudeWest,
      );
}

/// Extension methods for the [EdgeInsets] class. Not exported publicly.
extension EdgeInsetsExt on EdgeInsets {
  /// Convert an [EdgeInsets] to an internal [pigeon.Padding].
  pigeon.Padding toPadding() => pigeon.Padding(
        top: top.toInt(),
        bottom: bottom.toInt(),
        left: left.toInt(),
        right: right.toInt(),
      );
}
