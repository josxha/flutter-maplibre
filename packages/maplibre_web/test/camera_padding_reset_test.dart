@TestOn('browser')
library;

import 'dart:js_interop';

import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_web/src/camera_padding_reset.dart';
import 'package:maplibre_web/src/interop/interop.dart' as interop;

@JS('eval')
external void _eval(String source);

@JS('cameraCalls')
external JSArray<JSString> get _cameraCalls;

@JS('cameraEvents')
external JSArray<JSObject> get _cameraEvents;

void main() {
  setUp(() {
    _eval('''
      globalThis.cameraCalls = [];
      globalThis.cameraEvents = [];
      globalThis.pendingResetEvent = null;
      globalThis.throwOnJump = false;
      globalThis.maplibregl = {
        Camera: class {
          stop() {
            cameraCalls.push('stop');
            cameraEvents.push({});
          }
          jumpTo(options, eventData) {
            cameraCalls.push('jumpTo');
            pendingResetEvent = eventData;
            if (throwOnJump) throw new Error('failed');
          }
        }
      };
    ''');
  });

  test('stops active movement before suppressing reset events', () {
    final paddingReset = CameraPaddingReset();

    paddingReset.run(
      camera: interop.Camera(interop.CameraOptions()),
      padding: interop.PaddingOptions(top: 0, bottom: 0, right: 0, left: 0),
    );

    expect(_cameraCalls.toDart.map((value) => value.toDart), [
      'stop',
      'jumpTo',
    ]);
    _eval('cameraEvents.push(pendingResetEvent);');
    expect(_cameraEvents.toDart.map(paddingReset.shouldForward), [true, false]);
  });

  test('does not suppress later unmarked events when the reset throws', () {
    final paddingReset = CameraPaddingReset();
    _eval('globalThis.throwOnJump = true;');

    expect(
      () => paddingReset.run(
        camera: interop.Camera(interop.CameraOptions()),
        padding: interop.PaddingOptions(top: 0, bottom: 0, right: 0, left: 0),
      ),
      throwsA(anything),
    );
    _eval('cameraEvents.push({});');
    expect(paddingReset.shouldForward(_cameraEvents.toDart.last), isTrue);
  });
}
