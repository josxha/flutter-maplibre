@JS('JSON')
library json;

import 'dart:js_interop';

@JS('parse')
external JSAny parse(String json);
