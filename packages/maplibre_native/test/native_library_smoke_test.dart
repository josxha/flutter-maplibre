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
    final runtime = RuntimeHandle.create(const RuntimeOptions());
    final created = runtime.createMap(
      const MapOptions(
        initialExtent: LogicalExtent(width: 256, height: 256, scaleFactor: 1),
      ),
    );
    final map = created.map;
    await created.ready;
    await map.setStyleJson({
      'version': 8,
      'sources': <String, Object?>{},
      'layers': <Object?>[],
    });
    await map.close();
    await runtime.close();
  });
}
