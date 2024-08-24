@JS('maplibregl')
library maplibre_gl;

import 'dart:js_interop';

import 'package:maplibre/maplibre.dart';
import 'package:web/web.dart';

part 'annotations.dart';
part 'camera.dart';
part 'controls.dart';
part 'events.dart';
part 'map.dart';

@anonymous
@JS()
extension type Point._(JSObject _) implements JSObject {
  external factory Point(num x, num y);

  external num x;
  external num y;
}
