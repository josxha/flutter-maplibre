part of 'interop.dart';

/// https://maplibre.org/maplibre-gl-js/docs/API/classes/Marker/
@JS()
extension type Marker._(JSObject _) implements JSObject {
  /// Create a new JS [Marker] object.
  external Marker([MarkerOptions? options]);

  /// Set the location of the [Marker].
  external Marker setLngLat(LngLat lngLat);

  /// Add the marker to a MapLibre map.
  external Marker addTo(JsMap map);
}

/// The anonymous option class for a [Marker].
///
/// https://maplibre.org/maplibre-gl-js/docs/API/classes/Marker/
@anonymous
@JS()
extension type MarkerOptions._(JSObject _) implements JSObject {
  /// Create a new JS [MarkerOptions] object.
  external factory MarkerOptions({String? color, bool? draggable});
}
