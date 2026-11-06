import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:maplibre_native/src/android/android_plugin.dart';
import 'package:maplibre_native/src/extensions.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart'
    show MapLibreNetwork;
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
///
/// The runtime requests its resources with the settings of
/// [MapLibreNetwork], also after they change.
Future<RuntimeHandle> createRuntime() async {
  final path = await databasePath();
  // Android needs the C library initialized before its first use.
  if (Platform.isAndroid) AndroidPlugin.initialize();
  final runtime = RuntimeHandle.create(RuntimeOptions(cachePath: path));
  // Known before the first settings are applied, so a change meanwhile
  // reaches it too. Its commands run in order, so the latest settings win.
  _runtimes
    ..removeWhere((runtime) => runtime.isClosed)
    ..add(runtime);
  if (!_listensToNetwork) {
    MapLibreNetwork.changes.addListener(_onNetworkChanged);
    _listensToNetwork = true;
  }
  try {
    await _applyNetwork(runtime, changed: false);
  } on Object {
    _runtimes.remove(runtime);
    await runtime.close();
    rethrow;
  }
  return runtime;
}

/// The runtimes that [createRuntime] created, to apply [MapLibreNetwork]
/// changes to. Closed ones are dropped at the next change or creation.
final _runtimes = <RuntimeHandle>{};
var _listensToNetwork = false;

void _onNetworkChanged() {
  _runtimes.removeWhere((runtime) => runtime.isClosed);
  for (final runtime in _runtimes) {
    unawaited(
      _applyNetwork(runtime, changed: true).catchError((
        Object error,
        StackTrace stack,
      ) {
        // A runtime that closed meanwhile needs no settings.
        if (runtime.isClosed) return;
        FlutterError.reportError(
          FlutterErrorDetails(
            exception: error,
            stack: stack,
            library: 'maplibre',
            context: ErrorDescription('while applying the network settings'),
          ),
        );
      }),
    );
  }
}

/// Sets the headers and URL transform of [MapLibreNetwork] on [runtime].
/// A new runtime has neither, so it only needs the ones that are set.
Future<void> _applyNetwork(
  RuntimeHandle runtime, {
  required bool changed,
}) async {
  final headers = MapLibreNetwork.requestHeaders;
  if (headers.isNotEmpty) {
    await runtime.setHttpHeaderTransform(
      HttpHeaderTransform(
        rules: [
          for (final entry in headers)
            if (entry.kinds?.isEmpty != true) entry.toMln(),
        ],
      ),
    );
  } else if (changed) {
    await runtime.clearHttpHeaderTransform();
  }
  // The transform waits for Dart on every request, so it is only set while
  // there is one.
  if (MapLibreNetwork.urlTransform != null) {
    await runtime.setResourceTransform(_transformResource);
  } else if (changed) {
    await runtime.clearResourceTransform();
  }
}

void _transformResource(
  ResourceKind kind,
  String url,
  ResourceTransformRequestHandle request,
) => request.complete(
  MapLibreNetwork.transformUrl(url, kind.toMapResourceKind()),
);
