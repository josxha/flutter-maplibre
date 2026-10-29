import 'dart:io';

import 'package:maplibre_native/src/android/android_plugin.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';
import 'package:path_provider/path_provider.dart';

Future<String>? _databasePath;

/// The database that every map caches its resources in, and that the offline
/// manager keeps its regions in: `maplibre_native.db` in the app's support
/// directory.
Future<String> databasePath() async {
  final path = _databasePath ??= _createDatabasePath();
  try {
    return await path;
  } on Object {
    _databasePath = null;
    rethrow;
  }
}

Future<String> _createDatabasePath() async {
  final directory = await getApplicationSupportDirectory();
  await directory.create(recursive: true);
  return '${directory.path}${Platform.pathSeparator}maplibre_native.db';
}

/// Creates a runtime on the shared database. Runtimes on one database share
/// its resource cache and offline regions.
Future<RuntimeHandle> createRuntime() async {
  final path = await databasePath();
  // Android needs the C library initialized before its first use.
  if (Platform.isAndroid) AndroidPlugin.initialize();
  return RuntimeHandle.create(RuntimeOptions(cachePath: path));
}
