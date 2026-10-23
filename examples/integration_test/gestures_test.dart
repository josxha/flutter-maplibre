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

MapOptions _options({MapGestures gestures = const MapGestures.all()}) =>
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
double _turned(MapCamera before, MapCamera after) {
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
      final start = await map.waitForEvent<MapEventStartMoveCamera>(
        since: since,
      );
      expect(start.reason, CameraChangeReason.apiGesture);
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
      // 450 px is one zoom level, as in MapLibre GL JS.
      await tester.sendEventToBinding(pointer.scroll(const Offset(0, -450)));
      final after = await map.waitForCamera(
        (camera) => camera.zoom > before.zoom + 0.9,
      );
      expect(after.zoom, closeTo(before.zoom + 1, 0.05));
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
      // On web, tests never see a single tap win the gesture arena from the
      // HtmlElementView; see the known gaps in .agents/decisions.md.
    }, skip: kIsWeb);

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
      // On web, tests never see a single tap win the gesture arena from the
      // HtmlElementView; see the known gaps in .agents/decisions.md.
    }, skip: kIsWeb);

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
