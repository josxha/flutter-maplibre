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

/// A simple x/y [Point] class for JavaScript.
@anonymous
@JS()
extension type Point._(JSObject _) implements JSObject {
  /// Create a new JS [Point].
  external factory Point(num x, num y);

  external num x;
  external num y;
}
