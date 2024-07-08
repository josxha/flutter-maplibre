part of 'interop.dart';

@JS()
extension type Marker._(IControl _) implements IControl {
  external Marker([MarkerOptions? options]);

  external Marker setLngLat(LngLat lngLat);
  external Marker addTo(Map map);
}

@anonymous
@JS()
extension type MarkerOptions._(JSObject _) implements JSObject {
  external factory MarkerOptions({
    String? color,
    bool? draggable,
  });
}