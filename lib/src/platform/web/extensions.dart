import 'dart:js_interop';

import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/web/interop/interop.dart' as interop;

/// Extension methods for the [Position] class. Not exported publicly.
extension PositionExt on Position {
  /// Convert a [Position] to an internal [interop.LngLat].
  interop.LngLat toLngLat() => interop.LngLat.fromPosition(this);
}

/// Extension methods for the [Position] class. Not exported publicly.
extension LngLatBoundsExt on LngLatBounds {
  /// Convert a [Position] to an internal [interop.LngLat].
  interop.LngLatBounds toJsLngLatBounds() => interop.LngLatBounds(
    interop.LngLat(lng: longitudeWest, lat: latitudeSouth),
    interop.LngLat(lng: longitudeEast, lat: latitudeNorth),
  );
}

/// Extension methods for the [Offset] class. Not exported publicly.
extension OffsetExt on Offset {
  /// Convert a [Offset] to an internal [interop.Point].
  interop.Point toJsPoint() => interop.Point(dx, dy);
}

/// Extension methods for the [interop.Point] class. Not exported publicly.
extension JsPointExt on interop.Point {
  /// Convert a [interop.Point] to an internal [Offset].
  Offset toOffset() => Offset(x.toDouble(), y.toDouble());
}

/// Extension methods for the [EdgeInsets] class. Not exported publicly.
extension EdgeInsetsExt on EdgeInsets {
  /// Convert a [EdgeInsets] to an internal [interop.PaddingOptions].
  interop.PaddingOptions toPaddingOptions() => interop.PaddingOptions(
    right: right,
    left: left,
    bottom: bottom,
    top: top,
  );
}

/// Internal extension to convert JSAny to Map\<String, dynamic\>
extension StringMap on JSAny? {
  /// Like [JSAny?.dartify], but for the special case of a JSON map.
  Map<String, Object?>? asStringMap() =>
      (dartify() as Map<Object?, Object?>?)?.map(
        (k, v) => MapEntry(k.toString(), v),
      ) ??
      {};
}
