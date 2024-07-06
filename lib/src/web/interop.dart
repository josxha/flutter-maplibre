@JS('maplibregl')
library maplibre_gl;

import 'dart:js_interop';

@JS('Map')
extension type Map._(JSObject _) implements JSObject {
  external Map(MapOptions options);

  external MapOptions options;
}

@anonymous
@JS()
extension type MapOptions._(JSObject _) implements JSObject {
  external factory MapOptions({
    JSObject container,
    String style,
    double zoom,
  });

  external JSObject container;
  external String style;
  external double zoom;
}
