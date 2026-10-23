import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mocktail/mocktail.dart';

import '../shared/mocks.dart';
import '../shared/ui_app.dart';

const _camera = MapCamera(
  center: Geographic(lon: 0, lat: 0),
  zoom: 10,
  bearing: 30,
  pitch: 0,
);

/// A screen at 1 px per 0.001 degrees, centered on (0, 0) at (400, 300).
Offset _toScreen(Geographic point) =>
    Offset(400 + point.lon * 1000, 300 - point.lat * 1000);

void main() {
  setUpAll(() {
    registerFallbackValue(MockDuration());
    registerFallbackValue(const Geographic(lon: 0, lat: 0));
  });

  group('UserLocationLayer', () {
    late MockMapController controller;
    late StreamController<UserLocation> locations;
    late List<UserLocationTracking> trackingChanges;

    setUp(() {
      controller = MockMapController();
      locations = StreamController<UserLocation>();
      trackingChanges = [];
      when(() => controller.toScreenLocations(any())).thenAnswer(
        (invocation) =>
            (invocation.positionalArguments.single as List<Geographic>)
                .map(_toScreen)
                .toList(),
      );
      when(
        () => controller.animateCamera(
          center: any(named: 'center'),
          zoom: any(named: 'zoom'),
          bearing: any(named: 'bearing'),
          nativeDuration: any(named: 'nativeDuration'),
          webMaxDuration: any(named: 'webMaxDuration'),
        ),
      ).thenAnswer((_) async {});
    });

    tearDown(() => locations.close());

    Future<void> pump(
      WidgetTester tester, {
      UserLocationTracking tracking = UserLocationTracking.none,
      double? trackingZoom,
    }) => tester.pumpWidget(
      App(
        camera: _camera,
        controller: controller,
        children: [
          UserLocationLayer(
            locations: locations.stream,
            tracking: tracking,
            trackingZoom: trackingZoom,
            onTrackingChanged: trackingChanges.add,
          ),
        ],
      ),
    );

    Future<void> add(WidgetTester tester, UserLocation location) async {
      locations.add(location);
      await tester.pump();
    }

    RenderObject layer(WidgetTester tester) => tester.renderObject(
      find.descendant(
        of: find.byType(UserLocationLayer),
        matching: find.byType(CustomPaint),
      ),
    );

    testWidgets('paints nothing before the first location', (tester) async {
      await pump(tester);
      expect(layer(tester), paintsNothing);
    });

    testWidgets('paints the dot at the screen location', (tester) async {
      await pump(tester);
      await add(
        tester,
        const UserLocation(position: Geographic(lon: 0.1, lat: 0.05)),
      );
      expect(
        layer(tester),
        paints
          ..circle(x: 500, y: 250, radius: 10, color: Colors.white)
          ..circle(x: 500, y: 250, radius: 8),
      );
    });

    testWidgets('paints the accuracy in meters', (tester) async {
      await pump(tester);
      // 111.32 m north is 0.001 degrees, 1 px here: 2226.4 m is 20 px.
      await add(
        tester,
        const UserLocation(
          position: Geographic(lon: 0, lat: 0),
          accuracy: 2226.4,
        ),
      );
      expect(
        layer(tester),
        paints..something(
          (method, arguments) =>
              method == #drawCircle &&
              arguments[0] == const Offset(400, 300) &&
              ((arguments[1] as double) - 20).abs() < 1e-6,
        ),
      );
    });

    testWidgets('paints the heading against the bearing', (tester) async {
      await pump(tester);
      await add(
        tester,
        const UserLocation(position: Geographic(lon: 0, lat: 0), heading: 120),
      );
      // The cone points 90 degrees clockwise from up on screen, to the
      // right, so it covers a point there but none to the left.
      expect(
        layer(tester),
        paints..path(
          includes: [const Offset(420, 300)],
          excludes: [const Offset(380, 300)],
        ),
      );
    });

    testWidgets('does not move the camera without tracking', (tester) async {
      await pump(tester);
      await add(
        tester,
        const UserLocation(position: Geographic(lon: 1, lat: 2)),
      );
      verifyNever(
        () => controller.animateCamera(
          center: any(named: 'center'),
          zoom: any(named: 'zoom'),
          bearing: any(named: 'bearing'),
          nativeDuration: any(named: 'nativeDuration'),
          webMaxDuration: any(named: 'webMaxDuration'),
        ),
      );
    });

    testWidgets('tracks the position, zooming once', (tester) async {
      await pump(
        tester,
        tracking: UserLocationTracking.position,
        trackingZoom: 15,
      );
      await add(
        tester,
        const UserLocation(position: Geographic(lon: 1, lat: 2), heading: 90),
      );
      await add(
        tester,
        const UserLocation(position: Geographic(lon: 3, lat: 4), heading: 90),
      );
      const duration = Duration(milliseconds: 500);
      verifyInOrder([
        () => controller.animateCamera(
          center: const Geographic(lon: 1, lat: 2),
          zoom: 15,
          nativeDuration: duration,
          webMaxDuration: duration,
        ),
        () => controller.animateCamera(
          center: const Geographic(lon: 3, lat: 4),
          nativeDuration: duration,
          webMaxDuration: duration,
        ),
      ]);
    });

    testWidgets('tracks the heading', (tester) async {
      await pump(tester, tracking: UserLocationTracking.positionAndHeading);
      await add(
        tester,
        const UserLocation(position: Geographic(lon: 1, lat: 2), heading: 90),
      );
      verify(
        () => controller.animateCamera(
          center: const Geographic(lon: 1, lat: 2),
          bearing: 90,
          nativeDuration: any(named: 'nativeDuration'),
          webMaxDuration: any(named: 'webMaxDuration'),
        ),
      ).called(1);
    });

    testWidgets('moves to the last location when tracking starts', (
      tester,
    ) async {
      await pump(tester);
      await add(
        tester,
        const UserLocation(position: Geographic(lon: 1, lat: 2)),
      );
      await pump(tester, tracking: UserLocationTracking.position);
      verify(
        () => controller.animateCamera(
          center: const Geographic(lon: 1, lat: 2),
          nativeDuration: any(named: 'nativeDuration'),
          webMaxDuration: any(named: 'webMaxDuration'),
        ),
      ).called(1);
    });

    testWidgets('a drag stops the tracking, a tap does not', (tester) async {
      await pump(tester, tracking: UserLocationTracking.position);
      await tester.tapAt(const Offset(400, 300));
      expect(trackingChanges, isEmpty);
      await tester.dragFrom(const Offset(400, 300), const Offset(100, 0));
      expect(trackingChanges, [UserLocationTracking.none]);
      clearInteractions(controller);
      await add(
        tester,
        const UserLocation(position: Geographic(lon: 1, lat: 2)),
      );
      verifyNever(
        () => controller.animateCamera(
          center: any(named: 'center'),
          nativeDuration: any(named: 'nativeDuration'),
          webMaxDuration: any(named: 'webMaxDuration'),
        ),
      );
    });

    testWidgets('a scroll wheel stops the tracking', (tester) async {
      await pump(tester, tracking: UserLocationTracking.position);
      final pointer = TestPointer(1, PointerDeviceKind.mouse);
      await tester.sendEventToBinding(pointer.hover(const Offset(400, 300)));
      await tester.sendEventToBinding(pointer.scroll(const Offset(0, -100)));
      expect(trackingChanges, [UserLocationTracking.none]);
    });

    testWidgets('lets pointers through to the map', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        App(
          camera: _camera,
          controller: controller,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => taps++,
              child: const SizedBox.expand(),
            ),
            UserLocationLayer(locations: locations.stream),
          ],
        ),
      );
      await tester.tapAt(const Offset(400, 300));
      expect(taps, 1);
    });
  });
}
