@JS('JSON')
library;

import 'dart:js_interop';

/// Parse a String to a JavaScript object to avoid the not as efficient JSON
/// parsing in Dart.
@JS('parse')
external JSAny parse(String json);

/// Convert a JavaScript object to a JSON string, for values that Dart reads
/// as plain JSON.
@JS('stringify')
external String stringify(JSAny value);
