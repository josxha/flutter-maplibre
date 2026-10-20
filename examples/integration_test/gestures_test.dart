import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  test();
}

void test() {
  group('gestures', () {
    late MapController ctrl;
    late Offset center;

    Future<void> openMap(WidgetTester tester) async {
      final completer = Completer<MapController>();
      await tester.pumpWidget(
        App(
          options: const MapOptions(
            initCenter: Geographic(lon: 10, lat: 50),
            initZoom: 4,
          ),
          onMapCreated: completer.complete,
        ),
      );
      ctrl = await completer.future;
      await tester.pump();
      center = tester.getCenter(find.byType(MapLibreMap));
    }

    /// Pumps until [matches] holds for the camera, failing after 5 seconds.
    Future<MapCamera> waitForCamera(
      WidgetTester tester,
      bool Function(MapCamera camera) matches,
    ) async {
      final deadline = DateTime.now().add(const Duration(seconds: 5));
      while (DateTime.now().isBefore(deadline)) {
        await tester.pump(const Duration(milliseconds: 50));
        final camera = ctrl.camera;
        if (camera != null && matches(camera)) return camera;
      }
      fail('camera never matched, last: ${ctrl.camera}');
    }

    testWidgets('drag pans the map', (tester) async {
      await openMap(tester);
      final before = ctrl.getCamera();
      await tester.dragFrom(center, const Offset(-200, 0));
      final after = await waitForCamera(
        tester,
        (camera) => camera.center.lon > before.center.lon + 1,
      );
      expect(after.zoom, closeTo(before.zoom, 0.01));
    });

    testWidgets('scroll wheel zooms the map', (tester) async {
      await openMap(tester);
      final before = ctrl.getCamera();
      final pointer = TestPointer(1, PointerDeviceKind.mouse);
      await tester.sendEventToBinding(pointer.hover(center));
      await tester.sendEventToBinding(pointer.scroll(const Offset(0, -450)));
      await waitForCamera(tester, (camera) => camera.zoom > before.zoom + 0.9);
    });

    testWidgets('double tap zooms in', (tester) async {
      await openMap(tester);
      final before = ctrl.getCamera();
      await tester.tapAt(center);
      await tester.pump(const Duration(milliseconds: 50));
      await tester.tapAt(center);
      await waitForCamera(tester, (camera) => camera.zoom > before.zoom + 0.9);
    });

    /// Drags with the mouse from [from] by [step] ten times, holding
    /// [buttons].
    Future<void> mouseDrag(
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
    double turned(MapCamera before, MapCamera after) {
      final delta = (after.bearing - before.bearing) % 360;
      return delta > 180 ? delta - 360 : delta;
    }

    testWidgets('right drag below the center raises the bearing', (
      tester,
    ) async {
      await openMap(tester);
      final before = ctrl.getCamera();
      await mouseDrag(
        tester,
        center + const Offset(0, 100),
        const Offset(5, 0),
      );
      // 50 px at 0.8 degrees per pixel, as in MapLibre GL JS.
      final after = await waitForCamera(
        tester,
        (camera) => (turned(before, camera) - 40).abs() < 1,
      );
      expect(after.pitch, closeTo(before.pitch, 0.01));
    });

    testWidgets('right drag above the center lowers the bearing', (
      tester,
    ) async {
      await openMap(tester);
      final before = ctrl.getCamera();
      await mouseDrag(
        tester,
        center - const Offset(0, 100),
        const Offset(5, 0),
      );
      await waitForCamera(
        tester,
        (camera) => (turned(before, camera) + 40).abs() < 1,
      );
    });

    testWidgets('right drag up tilts', (tester) async {
      await openMap(tester);
      final before = ctrl.getCamera();
      await mouseDrag(tester, center, const Offset(0, -5));
      // 50 px at 0.5 degrees per pixel.
      final after = await waitForCamera(
        tester,
        (camera) => (camera.pitch - before.pitch - 25).abs() < 1,
      );
      expect(turned(before, after), closeTo(0, 0.01));
    });

    testWidgets('ctrl and left drag rotates instead of panning', (
      tester,
    ) async {
      await openMap(tester);
      final before = ctrl.getCamera();
      await simulateKeyDownEvent(LogicalKeyboardKey.controlLeft);
      await mouseDrag(
        tester,
        center + const Offset(0, 100),
        const Offset(5, 0),
        buttons: kPrimaryMouseButton,
      );
      await simulateKeyUpEvent(LogicalKeyboardKey.controlLeft);
      final after = await waitForCamera(
        tester,
        (camera) => (turned(before, camera) - 40).abs() < 1,
      );
      expect(after.center.lon, closeTo(before.center.lon, 0.01));
      expect(after.center.lat, closeTo(before.center.lat, 0.01));
    });

    testWidgets('click reports its location', (tester) async {
      final events = <MapEvent>[];
      final completer = Completer<MapController>();
      await tester.pumpWidget(
        App(
          options: const MapOptions(
            initCenter: Geographic(lon: 10, lat: 50),
            initZoom: 4,
          ),
          onMapCreated: completer.complete,
          onEvent: events.add,
        ),
      );
      ctrl = await completer.future;
      await tester.pump();
      center = tester.getCenter(find.byType(MapLibreMap));
      await tester.tapAt(center);
      // A single tap waits out the double tap timeout.
      await tester.pump(const Duration(milliseconds: 400));
      final click = events.whereType<MapEventClick>().single;
      expect(click.point.lon, closeTo(10, 0.5));
      expect(click.point.lat, closeTo(50, 0.5));
    });
  });
}
