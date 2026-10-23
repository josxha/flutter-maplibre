import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mocktail/mocktail.dart';

import '../shared/mocks.dart';
import '../shared/ui_app.dart';

MapCamera _camera({double bearing = 0, double pitch = 0}) => MapCamera(
  center: const Geographic(lon: 0, lat: 0),
  zoom: 3,
  bearing: bearing,
  pitch: pitch,
);

void main() {
  setUpAll(() {
    registerFallbackValue(MockDuration());
  });

  group('MapCompass', () {
    late MockMapController controller;

    setUp(() {
      controller = MockMapController();
      when(
        () => controller.animateCamera(
          bearing: any(named: 'bearing'),
          pitch: any(named: 'pitch'),
          nativeDuration: any(named: 'nativeDuration'),
          webSpeed: any(named: 'webSpeed'),
        ),
      ).thenAnswer((_) async {});
    });

    Future<void> pump(
      WidgetTester tester,
      MapCamera camera,
      MapCompass compass,
    ) async {
      when(controller.getCamera).thenReturn(camera);
      await tester.pumpWidget(
        App(camera: camera, controller: controller, children: [compass]),
      );
    }

    double angleOf(WidgetTester tester) {
      final transform = tester.widget<Transform>(
        find.descendant(
          of: find.byType(MapCompass),
          matching: find.byType(Transform),
        ),
      );
      final m = transform.transform;
      return atan2(m.entry(1, 0), m.entry(0, 0)) * 180 / pi;
    }

    testWidgets('points north against the bearing', (tester) async {
      await pump(tester, _camera(bearing: 30), const MapCompass());
      expect(angleOf(tester), closeTo(-30, 1e-6));
    });

    testWidgets('adds its rotation offset', (tester) async {
      await pump(
        tester,
        _camera(bearing: 30),
        const MapCompass(rotationOffset: 45),
      );
      expect(angleOf(tester), closeTo(15, 1e-6));
    });

    testWidgets('turns the map north when tapped', (tester) async {
      var pressed = 0;
      await pump(
        tester,
        _camera(bearing: 100, pitch: 30),
        MapCompass(onPressed: () => pressed++),
      );
      await tester.tap(find.byType(InkWell));
      verify(
        () => controller.animateCamera(
          bearing: 0,
          nativeDuration: const Duration(milliseconds: 200),
        ),
      ).called(1);
      expect(pressed, 1);
    });

    testWidgets('can reset the pitch instead of the bearing', (tester) async {
      await pump(
        tester,
        _camera(bearing: 100, pitch: 30),
        const MapCompass(
          rotateNorthOnPressed: false,
          removePinchOnPressed: true,
        ),
      );
      await tester.tap(find.byType(InkWell));
      verify(
        () => controller.animateCamera(
          pitch: 0,
          nativeDuration: any(named: 'nativeDuration'),
          webSpeed: any(named: 'webSpeed'),
        ),
      ).called(1);
    });

    testWidgets('only calls back when it moves nothing', (tester) async {
      var pressed = 0;
      await pump(
        tester,
        _camera(bearing: 100),
        MapCompass(rotateNorthOnPressed: false, onPressed: () => pressed++),
      );
      await tester.tap(find.byType(InkWell));
      verifyNever(
        () => controller.animateCamera(
          bearing: any(named: 'bearing'),
          pitch: any(named: 'pitch'),
          nativeDuration: any(named: 'nativeDuration'),
          webSpeed: any(named: 'webSpeed'),
        ),
      );
      expect(pressed, 1);
    });

    testWidgets('can hide while the map points north', (tester) async {
      const compass = MapCompass(hideIfRotatedNorth: true);
      await pump(tester, _camera(), compass);
      expect(find.byType(InkWell), findsNothing);
      await pump(tester, _camera(bearing: 1), compass);
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('shows a custom child', (tester) async {
      await pump(
        tester,
        _camera(),
        const MapCompass(alignment: Alignment.topLeft, child: Text('N')),
      );
      expect(find.text('N'), findsOneWidget);
    });

    testWidgets('shows nothing outside of a map', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: MapCompass()));
      expect(find.byType(InkWell), findsNothing);
    });
  });
}
