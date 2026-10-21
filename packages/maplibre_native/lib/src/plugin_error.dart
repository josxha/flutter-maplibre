import 'dart:ffi';

import 'package:ffi/ffi.dart';

/// Capacity of the error messages that the plugins' C APIs write.
const pluginErrorSize = 1024;

/// The message that a plugin wrote to [error].
String pluginErrorMessage(Pointer<Char> error) =>
    error.cast<Utf8>().toDartString();
