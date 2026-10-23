import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

const _size = Size(800, 600);
const _center = Offset(400, 300);

/// Records what the gestures ask of the camera.
class _RecordingCamera implements GestureCameraSink {
  final calls = <String>[];
  final updates = <GestureCameraUpdate>[];
  final zooms = <(double, Offset, Duration)>[];
  Velocity? endVelocity;

  @override
  void gestureStart() => calls.add('start');

  @override
  void gestureUpdate(GestureCameraUpdate update) {
    calls.add('update');
    updates.add(update);
  }

  @override
  void gestureEnd({Velocity velocity = Velocity.zero}) {
    calls.add('end');
    endVelocity = velocity;
  }

  @override
  void zoomBy(
    double levels,
    Offset around, {
    Duration duration = Duration.zero,
  }) {
    calls.add('zoomBy');
    zooms.add((levels, around, duration));
  }

  Offset get panned => updates
      .where((u) => u.pans)
      .fold(Offset.zero, (sum, u) => sum + (u.panTo! - u.panFrom!));

  double get zoomed => updates.fold(0, (sum, u) => sum + u.zoomBy);

  double get rotated => updates.fold(0, (sum, u) => sum + u.rotateBy);

  double get pitched => updates.fold(0, (sum, u) => sum + u.pitchBy);
}

void main() {
  late _RecordingCamera camera;
  late List<MapEvent> events;

  setUp(() {
    camera = _RecordingCamera();
    events = [];
  });

  Future<void> pumpMap(
    WidgetTester tester, {
    MapGestures gestures = const MapGestures.all(),
  }) async {
    tester.view
      ..physicalSize = _size
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MapGestureDetector(
        gestures: gestures,
        camera: camera,
        // A plate carrée world 1000 px wide, centered on the screen.
        toLngLat: (point) => Geographic(
          lon: (point.dx - _center.dx) * 360 / 1000,
          lat: (_center.dy - point.dy) * 360 / 1000,
        ),
        onEvent: events.add,
        child: const SizedBox.expand(),
      ),
    );
  }

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
    await tester.pumpAndSettle();
  }

  group('MapGestureDetector', () {
    testWidgets('drag pans the map', (tester) async {
      await pumpMap(tester);
      await tester.dragFrom(_center, const Offset(-200, 0));
      await tester.pumpAndSettle();
      expect(camera.calls.first, 'start');
      expect(camera.calls.last, 'end');
      // The scale recognizer claims the drag past its slop.
      expect(camera.panned.dx, lessThan(-150));
      expect(camera.panned.dx, greaterThanOrEqualTo(-200));
      expect(camera.panned.dy, 0);
      expect(camera.zoomed, 0);
      expect(camera.rotated, 0);
    });

    testWidgets('fling passes the release velocity', (tester) async {
      await pumpMap(tester);
      await tester.flingFrom(_center, const Offset(-300, 0), 1000);
      await tester.pumpAndSettle();
      expect(camera.endVelocity!.pixelsPerSecond.dx, lessThan(-500));
    });

    testWidgets('pinch zooms around the fingers', (tester) async {
      await pumpMap(tester);
      final a = await tester.startGesture(_center - const Offset(50, 0));
      final b = await tester.startGesture(_center + const Offset(50, 0));
      for (var i = 0; i < 10; i++) {
        await a.moveBy(const Offset(-5, 0));
        await b.moveBy(const Offset(5, 0));
        await tester.pump(const Duration(milliseconds: 16));
      }
      await a.up();
      await b.up();
      await tester.pumpAndSettle();
      // The fingers spread from 100 px to 200 px apart, one zoom level, less
      // what they spread before the recognizer claimed the pinch.
      expect(camera.zoomed, inInclusiveRange(0.5, 1));
      // One finger moves at a time, so the focal point wobbles by 2.5 px.
      expect(
        camera.updates
            .where((u) => u.zoomBy != 0)
            .every((u) => (u.around! - _center).distance <= 2.5),
        isTrue,
      );
    });

    testWidgets('scroll wheel zooms the map', (tester) async {
      await pumpMap(tester);
      final pointer = TestPointer(1, PointerDeviceKind.mouse);
      await tester.sendEventToBinding(pointer.hover(_center));
      await tester.sendEventToBinding(pointer.scroll(const Offset(0, -450)));
      expect(camera.zooms.single.$1, closeTo(1, 1e-9));
      expect(camera.zooms.single.$2, _center);
      expect(camera.calls, ['zoomBy']);
    });

    test('wheel deltas are scaled back to CSS pixels on web', () {
      double scale(TargetPlatform platform, {bool isWeb = true}) =>
          MapGestureDetector.wheelPixelScale(
            isWeb: isWeb,
            platform: platform,
            devicePixelRatio: 2,
          );
      expect(scale(TargetPlatform.windows), 2);
      expect(scale(TargetPlatform.linux), 2);
      expect(scale(TargetPlatform.android), 2);
      // Flutter web already keeps macOS deltas in CSS pixels.
      expect(scale(TargetPlatform.macOS), 1);
      expect(scale(TargetPlatform.windows, isWeb: false), 1);
      expect(scale(TargetPlatform.iOS, isWeb: false), 1);
    });

    testWidgets('double tap zooms in', (tester) async {
      await pumpMap(tester);
      await tester.tapAt(_center);
      await tester.pump(const Duration(milliseconds: 50));
      await tester.tapAt(_center);
      await tester.pumpAndSettle();
      expect(camera.zooms.single, (
        1.0,
        _center,
        const Duration(milliseconds: 300),
      ));
      expect(events.whereType<MapEventDoubleClick>(), hasLength(1));
    });

    testWidgets('right drag below the center raises the bearing', (
      tester,
    ) async {
      await pumpMap(tester);
      await mouseDrag(
        tester,
        _center + const Offset(0, 100),
        const Offset(5, 0),
      );
      // 50 px at 0.8 degrees per pixel, as in MapLibre GL JS.
      expect(camera.rotated, closeTo(40, 1e-9));
      expect(camera.pitched, 0);
      expect(camera.updates.every((u) => u.around == _center), isTrue);
    });

    testWidgets('right drag above the center lowers the bearing', (
      tester,
    ) async {
      await pumpMap(tester);
      await mouseDrag(
        tester,
        _center - const Offset(0, 100),
        const Offset(5, 0),
      );
      expect(camera.rotated, closeTo(-40, 1e-9));
    });

    testWidgets('right drag up tilts', (tester) async {
      await pumpMap(tester);
      await mouseDrag(tester, _center, const Offset(0, -5));
      // 50 px at 0.5 degrees per pixel.
      expect(camera.pitched, closeTo(25, 1e-9));
      expect(camera.rotated, 0);
    });

    testWidgets('ctrl and left drag rotates instead of panning', (
      tester,
    ) async {
      await pumpMap(tester);
      await simulateKeyDownEvent(LogicalKeyboardKey.controlLeft);
      await mouseDrag(
        tester,
        _center + const Offset(0, 100),
        const Offset(5, 0),
        buttons: kPrimaryMouseButton,
      );
      await simulateKeyUpEvent(LogicalKeyboardKey.controlLeft);
      expect(camera.rotated, closeTo(40, 1e-9));
      expect(camera.panned, Offset.zero);
      expect(camera.calls.where((c) => c == 'start'), hasLength(1));
      expect(camera.calls.last, 'end');
      expect(camera.endVelocity, Velocity.zero);
    });

    testWidgets('two fingers side by side dragged up tilt', (tester) async {
      await pumpMap(tester);
      final a = await tester.startGesture(_center - const Offset(50, 0));
      final b = await tester.startGesture(_center + const Offset(50, 0));
      for (var i = 0; i < 10; i++) {
        await a.moveBy(const Offset(0, -10));
        await b.moveBy(const Offset(0, -10));
        await tester.pump(const Duration(milliseconds: 16));
      }
      await a.up();
      await b.up();
      await tester.pumpAndSettle();
      // From the move that crossed the 10 px slop on: 19 finger moves of
      // 10 px, at half of 0.25 degrees per pixel each.
      expect(camera.pitched, closeTo(19 * 10 / 2 * 0.25, 1e-9));
      expect(camera.panned, Offset.zero);
      expect(camera.zoomed, 0);
    });

    testWidgets('double tap and drag down zooms in', (tester) async {
      await pumpMap(tester);
      await tester.tapAt(_center);
      await tester.pump(const Duration(milliseconds: 50));
      final gesture = await tester.startGesture(_center);
      for (var i = 0; i < 10; i++) {
        await gesture.moveBy(const Offset(0, 17));
        await tester.pump(const Duration(milliseconds: 16));
      }
      await gesture.up();
      await tester.pumpAndSettle();
      // 150 px per level, from the move that crossed the 18 px touch slop
      // on: 9 moves of 17 px.
      expect(camera.zoomed, closeTo(9 * 17 / 150, 1e-9));
      expect(camera.updates.every((u) => u.around == _center), isTrue);
      expect(camera.zooms, isEmpty);
    });

    testWidgets('click reports its location', (tester) async {
      await pumpMap(tester);
      await tester.tapAt(_center + const Offset(100, 0));
      // A single tap waits out the double tap timeout.
      await tester.pump(const Duration(milliseconds: 400));
      final click = events.whereType<MapEventClick>().single;
      expect(click.point.lon, closeTo(36, 1e-9));
      expect(click.point.lat, closeTo(0, 1e-9));
      expect(click.screenPoint, _center + const Offset(100, 0));
      expect(camera.calls, isEmpty);
    });

    testWidgets('disabled gestures leave the camera', (tester) async {
      await pumpMap(tester, gestures: const MapGestures.none());
      await tester.dragFrom(_center, const Offset(-200, 0));
      await mouseDrag(tester, _center, const Offset(5, -5));
      final pointer = TestPointer(9, PointerDeviceKind.mouse);
      await tester.sendEventToBinding(pointer.hover(_center));
      await tester.sendEventToBinding(pointer.scroll(const Offset(0, -450)));
      await tester.tapAt(_center);
      await tester.pump(const Duration(milliseconds: 50));
      await tester.tapAt(_center);
      await tester.pumpAndSettle();
      expect(camera.updates, isEmpty);
      expect(camera.zooms, isEmpty);
    });

    testWidgets('a widget over the map keeps its pointers', (tester) async {
      tester.view
        ..physicalSize = _size
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      var buttonTaps = 0;
      await tester.pumpWidget(
        Stack(
          textDirection: TextDirection.ltr,
          children: [
            MapGestureDetector(
              gestures: const MapGestures.all(),
              camera: camera,
              toLngLat: (_) => const Geographic(lon: 0, lat: 0),
              onEvent: events.add,
              child: const SizedBox.expand(),
            ),
            Positioned(
              left: 0,
              top: 0,
              width: 100,
              height: 100,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => buttonTaps++,
                onPanUpdate: (_) {},
              ),
            ),
          ],
        ),
      );
      await tester.tapAt(const Offset(50, 50));
      await tester.dragFrom(const Offset(50, 50), const Offset(200, 0));
      await tester.pumpAndSettle();
      expect(buttonTaps, 1);
      expect(camera.calls, isEmpty);
      expect(events, isEmpty);
    });
  });
}
