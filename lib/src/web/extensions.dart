import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/web/interop/interop.dart' as interop;

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
