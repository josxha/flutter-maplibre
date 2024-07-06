@JS('maplibregl')
library maplibre_gl;

import 'dart:js_interop';

@JS('Map')
extension type Map._(JSObject _) implements JSObject {
  external Map(MapOptions options);

  external MapOptions options;

  external void addControl(ScaleControl scaleControl);
}

@anonymous
@JS()
extension type MapOptions._(JSObject _) implements JSObject {
  external factory MapOptions({
    required String style,
    required JSObject container,
    double zoom = 0,
    LngLat? center,
  });

  external JSObject container;
  external String style;
  external double zoom;
  external LngLat? center;
}

@anonymous
@JS()
extension type LngLat._(JSObject _) implements JSObject {
  external factory LngLat({
    required num lng,
    required num lat,
  });

  external num lng;
  external num lat;
}

