@JS('maplibregl')
library maplibre_gl;

import 'dart:js_interop';

import 'package:maplibre/maplibre.dart';
import 'package:web/web.dart';

part 'camera.dart';
part 'controls.dart';
part 'events.dart';
part 'gesture_handlers.dart';
part 'map.dart';
part 'map_geojson_feature.dart';
part 'marker.dart';

/// A simple x/y [Point] class for JavaScript.
@anonymous
@JS()
extension type Point._(JSObject _) implements JSObject {
  /// Create a new JS [Point].
  external factory Point(num x, num y);

  external num x;
  external num y;
}

/// A coordinate object
@anonymous
@JS()
extension type LngLat._(JSObject _) implements JSObject {
  /// Create a new [LngLat] coordinates object.
  external factory LngLat({
    required num lng,
    required num lat,
  });

  /// Create a new JS [LngLat] object from a [Position].
  factory LngLat.fromPosition(Position p) => LngLat(lng: p.lng, lat: p.lat);

  external num lng;
  external num lat;

  /// Convert the JS [LngLat] object to a dart [Position] object.
  Position toPosition() => Position(lng, lat);
}

/// A [LngLatBounds] object represents a geographical bounding box,
/// defined by its southwest and northeast points in longitude and latitude.
@JS()
extension type LngLatBounds._(JSObject _) implements JSObject {
  /// Create a new JS [LngLatBounds] object.
  external LngLatBounds(LngLat? sw, LngLat? ne);

  /// Returns the west edge of the bounding box.
  external num getWest();

  /// Returns the south edge of the bounding box.
  external num getSouth();

  /// Returns the east edge of the bounding box.
  external num getEast();

  /// Returns the north edge of the bounding box.
  external num getNorth();
}

/// https://maplibre.org/maplibre-gl-js/docs/API/type-aliases/DistributiveOmit/
extension type DistributiveOmit<T, K>._(JSObject _) implements JSObject {

}
