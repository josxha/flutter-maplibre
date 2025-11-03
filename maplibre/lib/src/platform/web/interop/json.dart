@JS('JSON')
library;

import 'dart:js_interop';

/// Parse a String to a JavaScript object to avoid the not as efficient JSON
/// parsing in Dart.
@JS('parse')
external JSAny parse(String json);
