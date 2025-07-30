@JS('pmtiles')
library;

import 'dart:js_interop';

/// PMTiles custom protocol
@JS()
extension type Protocol._(JSObject _) implements JSObject {
  /// Create a new JS [Protocol].
  external factory Protocol();

  external JSAny tile;
}
