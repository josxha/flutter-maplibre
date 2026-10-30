@TestOn('browser')
library;

import 'dart:js_interop';

import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_web/src/loader.dart';

@JS('eval')
external void _eval(String source);

@JS('protocols')
external JSArray<JSString> get _protocols;

void main() {
  setUp(() {
    _eval('''
      globalThis.protocols = [];
      globalThis.pmtiles = { Protocol: class { tile() {} } };
      delete globalThis.maplibregl;
      delete globalThis.flutterMapLibre;
    ''');
  });

  test('reports the URL that maplibre-gl-js failed to load from', () async {
    _eval('''
      globalThis.flutterMapLibre = { maplibreGlBaseUrl: '/missing' };
    ''');

    await expectLater(
      loadMapLibreGlJs(),
      throwsA(
        isA<StateError>().having(
          (e) => e.message,
          'message',
          contains('/missing/maplibre-gl.mjs'),
        ),
      ),
    );
    // The failed load is tried again.
    await expectLater(loadMapLibreGlJs(), throwsStateError);
  });

  test('uses the maplibre-gl-js and PMTiles of index.html', () async {
    _eval('''
      globalThis.maplibregl = {
        getVersion: () => '6.16.0',
        addProtocol: (name) => protocols.push(name),
      };
    ''');

    await loadMapLibreGlJs();

    expect(_protocols.toDart.map((e) => e.toDart), ['pmtiles']);
    // Every map waits for the same load.
    await loadMapLibreGlJs();
    expect(_protocols.length, 1);
  });
}
