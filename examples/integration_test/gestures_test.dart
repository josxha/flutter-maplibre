import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'shared/test_map.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  runTests();
}

MapOptions _options({MapGestures gestures = const MapGestures()}) =>
    offlineOptions(
      center: const Geographic(lon: 10, lat: 50),
      gestures: gestures,
    );

/// Drags with the mouse from [from] by [step] ten times, holding [buttons].
Future<void> _mouseDrag(
  WidgetTester tester,
  Offset from,
  Offset step, {
  int buttons = kSecondaryMouseButton,
}) async {
  final gesture = await tester.startGesture(
    from,
    kind: PointerDeviceKind.mouse,
    buttons: buttons,
  );
  for (var i = 0; i < 10; i++) {
    await gesture.moveBy(step);
    await tester.pump(const Duration(milliseconds: 16));
  }
  await gesture.up();
}

/// The signed bearing change from [before] to [after], in (-180, 180].
double _turned(CameraPosition before, CameraPosition after) {
  final delta = (after.bearing - before.bearing) % 360;
  return delta > 180 ? delta - 360 : delta;
}

void runTests() {
  group('gestures', () {
    testWidgets('drag pans the map', (tester) async {
      final map = await pumpMap(tester, options: _options());
      final before = map.controller.getCamera();
      final since = map.events.length;
      await tester.dragFrom(map.toGlobal(map.center), const Offset(-200, 0));
      final after = await map.waitForCamera(
        (camera) => camera.center.lon > before.center.lon + 1,
      );
      expect(after.zoom, closeTo(before.zoom, 0.01));
      final start = await map.waitForEvent<MapEventCameraMoveStart>(
        since: since,
      );
      expect(start.reason, CameraChangeReason.gesture);
    });

    testWidgets('pan momentum continues after release and tap stops it', (
      tester,
    ) async {
      final map = await pumpMap(tester, options: _options());
      final beforeDrag = map.controller.getCamera();
      final gesture = await tester.startGesture(map.toGlobal(map.center));
      await gesture.moveBy(
        const Offset(-60, 0),
        timeStamp: const Duration(milliseconds: 16),
      );
      await tester.pump(const Duration(milliseconds: 16));
      final afterFirstMove = await map.waitForCamera(
        (camera) => camera.center.lon > beforeDrag.center.lon + 0.001,
      );
      await gesture.moveBy(
        const Offset(-60, 0),
        timeStamp: const Duration(milliseconds: 32),
      );
      final afterSecondMove = await map.waitForCamera(
        (camera) => camera.center.lon > afterFirstMove.center.lon + 0.001,
      );
      final finalMoveLon =
          afterSecondMove.center.lon +
          (afterSecondMove.center.lon - afterFirstMove.center.lon);
      await gesture.moveBy(
        const Offset(-60, 0),
        timeStamp: const Duration(milliseconds: 48),
      );
      await gesture.up(timeStamp: const Duration(milliseconds: 49));

      final afterRelease = await map.waitForCamera(
        (camera) => camera.center.lon > finalMoveLon + 0.001,
      );
      final whileFlinging = await map.waitForCamera(
        (camera) => camera.center.lon > afterRelease.center.lon,
      );
      expect(whileFlinging.center.lon, greaterThan(afterRelease.center.lon));

      await tester.tapAt(map.toGlobal(map.center));
      final afterTap = map.controller.getCamera();
      await tester.pump(const Duration(milliseconds: 200));
      final settled = map.controller.getCamera();
      expect(settled.center.lon, closeTo(afterTap.center.lon, 1e-6));
      expect(settled.center.lat, closeTo(afterTap.center.lat, 1e-6));
    }, skip: kIsWeb);

    testWidgets('pinch zoom and rotation continue after release', (
      tester,
    ) async {
      final map = await pumpMap(tester, options: _options());
      final before = map.controller.getCamera();
      final since = map.events.length;
      // Away from the center, where the previous test tapped, so that the
      // first finger isn't a double tap.
      final center = map.toGlobal(map.center - const Offset(0, 150));
      var time = Duration.zero;
      var radius = 40.0;
      var angle = 0.0;
      Offset finger(double sign) =>
          center + Offset(cos(angle), sin(angle)) * radius * sign;
      final a = await tester.createGesture();
      final b = await tester.createGesture();
      await a.down(finger(-1), timeStamp: time);
      await b.down(finger(1), timeStamp: time);
      // Enough steps that the fling speed is measured after the recognizer
      // has accepted the gesture, which takes a few moves.
      for (var i = 0; i < 20; i++) {
        time += const Duration(milliseconds: 16);
        radius *= 1.04;
        angle += 0.02;
        await a.moveTo(finger(-1), timeStamp: time);
        await b.moveTo(finger(1), timeStamp: time);
        await tester.pump(const Duration(milliseconds: 16));
      }
      final released = await map.waitForCamera(
        (camera) => camera.zoom > before.zoom + 0.5,
      );
      await a.up(timeStamp: time);
      await b.up(timeStamp: time);

      final flung = await map.waitForCamera(
        (camera) =>
            camera.zoom > released.zoom + 0.1 && _turned(released, camera) < -1,
      );
      expect(flung.zoom, greaterThan(released.zoom));
      final end = await map.waitForEvent<MapEventCameraMoveEnd>(since: since);
      expect(end.camera.zoom, greaterThanOrEqualTo(flung.zoom));
    }, skip: kIsWeb);

    testWidgets('a drag is reported where it starts and ends', (tester) async {
      final map = await pumpMap(tester, options: _options());
      final since = map.events.length;
      await tester.dragFrom(map.toGlobal(map.center), const Offset(-200, 0));
      final end = await map.waitForEvent<MapEventDragEnd>(since: since);
      final start = map.events
          .skip(since)
          .whereType<MapEventDragStart>()
          .single;
      expect(start.screenPoint, map.center);
      expect(end.screenPoint.dx, closeTo(map.center.dx - 200, 1));
      expect(map.events.skip(since).whereType<MapEventDrag>(), isNotEmpty);
    });

    testWidgets('disabled gestures leave the camera alone', (tester) async {
      final map = await pumpMap(
        tester,
        options: _options(gestures: const MapGestures.none()),
      );
      final before = map.controller.getCamera();
      await tester.dragFrom(map.toGlobal(map.center), const Offset(-200, 0));
      await tester.pump(const Duration(milliseconds: 500));
      final after = map.controller.getCamera();
      expect(after.center.lon, closeTo(before.center.lon, 1e-6));
      expect(after.zoom, closeTo(before.zoom, 1e-6));
    });

    testWidgets('scroll wheel zooms the map', (tester) async {
      final map = await pumpMap(tester, options: _options());
      final before = map.controller.getCamera();
      final pointer = TestPointer(1, PointerDeviceKind.mouse);
      await tester.sendEventToBinding(pointer.hover(map.toGlobal(map.center)));
      // 450 CSS px is one zoom level, as in MapLibre GL JS. The test sends
      // logical pixels, which Flutter web would have divided by the device
      // pixel ratio.
      await tester.sendEventToBinding(pointer.scroll(const Offset(0, -450)));
      final levels = kIsWeb && defaultTargetPlatform != TargetPlatform.macOS
          ? tester.view.devicePixelRatio
          : 1.0;
      final after = await map.waitForCamera(
        (camera) => camera.zoom > before.zoom + levels - 0.1,
      );
      expect(after.zoom, closeTo(before.zoom + levels, 0.05));
    });

    testWidgets('double tap zooms in and is reported', (tester) async {
      final map = await pumpMap(tester, options: _options());
      final before = map.controller.getCamera();
      final since = map.events.length;
      await tester.tapAt(map.toGlobal(map.center));
      await tester.pump(const Duration(milliseconds: 50));
      await tester.tapAt(map.toGlobal(map.center));
      await map.waitForCamera((camera) => camera.zoom > before.zoom + 0.9);
      final event = await map.waitForEvent<MapEventDoubleClick>(since: since);
      expect(event.point.lon, closeTo(10, 0.5));
      expect(event.point.lat, closeTo(50, 0.5));
      expect(map.events.skip(since).whereType<MapEventClick>(), isEmpty);
    });

    testWidgets('click reports its location', (tester) async {
      final map = await pumpMap(tester, options: _options());
      final since = map.events.length;
      final point = map.center + const Offset(40, -30);
      await tester.tapAt(map.toGlobal(point));
      // A single tap waits out the double tap timeout.
      final click = await map.waitForEvent<MapEventClick>(since: since);
      expect(click.screenPoint.dx, closeTo(point.dx, 1));
      expect(click.screenPoint.dy, closeTo(point.dy, 1));
      final expected = map.controller.toLngLat(point);
      expect(click.point.lon, closeTo(expected.lon, 1e-3));
      expect(click.point.lat, closeTo(expected.lat, 1e-3));
    });

    testWidgets('long press is reported', (tester) async {
      final map = await pumpMap(tester, options: _options());
      final since = map.events.length;
      await tester.longPressAt(map.toGlobal(map.center));
      final event = await map.waitForEvent<MapEventLongClick>(since: since);
      expect(event.point.lon, closeTo(10, 0.5));
    });

    testWidgets('secondary click is reported', (tester) async {
      final map = await pumpMap(tester, options: _options());
      final since = map.events.length;
      await tester.tapAt(
        map.toGlobal(map.center),
        kind: PointerDeviceKind.mouse,
        buttons: kSecondaryMouseButton,
      );
      final event = await map.waitForEvent<MapEventSecondaryClick>(
        since: since,
      );
      expect(event.point.lat, closeTo(50, 0.5));
    });

    testWidgets('right drag below the center raises the bearing', (
      tester,
    ) async {
      final map = await pumpMap(tester, options: _options());
      final before = map.controller.getCamera();
      await _mouseDrag(
        tester,
        map.toGlobal(map.center + const Offset(0, 100)),
        const Offset(5, 0),
      );
      // 50 px at 0.8 degrees per pixel, as in MapLibre GL JS.
      final after = await map.waitForCamera(
        (camera) => (_turned(before, camera) - 40).abs() < 1,
      );
      expect(after.pitch, closeTo(before.pitch, 0.01));
    });

    testWidgets('right drag above the center lowers the bearing', (
      tester,
    ) async {
      final map = await pumpMap(tester, options: _options());
      final before = map.controller.getCamera();
      await _mouseDrag(
        tester,
        map.toGlobal(map.center - const Offset(0, 100)),
        const Offset(5, 0),
      );
      await map.waitForCamera(
        (camera) => (_turned(before, camera) + 40).abs() < 1,
      );
    });

    testWidgets('right drag up tilts', (tester) async {
      final map = await pumpMap(tester, options: _options());
      final before = map.controller.getCamera();
      await _mouseDrag(tester, map.toGlobal(map.center), const Offset(0, -5));
      // 50 px at 0.5 degrees per pixel.
      final after = await map.waitForCamera(
        (camera) => (camera.pitch - before.pitch - 25).abs() < 1,
      );
      expect(_turned(before, after), closeTo(0, 0.01));
    });

    testWidgets('ctrl and left drag rotates instead of panning', (
      tester,
    ) async {
      final map = await pumpMap(tester, options: _options());
      final before = map.controller.getCamera();
      await simulateKeyDownEvent(LogicalKeyboardKey.controlLeft);
      await _mouseDrag(
        tester,
        map.toGlobal(map.center + const Offset(0, 100)),
        const Offset(5, 0),
        buttons: kPrimaryMouseButton,
      );
      await simulateKeyUpEvent(LogicalKeyboardKey.controlLeft);
      final after = await map.waitForCamera(
        (camera) => (_turned(before, camera) - 40).abs() < 1,
      );
      expect(after.center.lon, closeTo(before.center.lon, 0.01));
      expect(after.center.lat, closeTo(before.center.lat, 0.01));
    });
  });
}
