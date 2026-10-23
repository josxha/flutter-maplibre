import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart';

/// Loads the MapLibre Native C library through the `maplibre_native_ffi` code
/// asset and opens and closes a runtime and a map, without rendering.
void main() {
  test('loads the native library', () {
    expect(cVersion(), isNotNull);
    expect(supportedRenderBackendMask().rawValue, isNonZero);
  });

  test('creates and closes a runtime and a map', () async {
    final runtime = runtimeCreate(runtimeOptionsDefault());
    final map = await runtime.createMap(mapOptionsDefault());
    await map.setStyleJson(
      Uint8List.fromList(utf8.encode('{"version":8,"sources":{},"layers":[]}')),
    );
    await map.close();
    await runtime.close();
  });
}
