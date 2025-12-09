import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mocktail/mocktail.dart';

import '../shared/mocks.dart';
import '../shared/ui_app.dart';

void main() {
  group('MapScalebar', () {
    setUpAll(() {
      registerFallbackValue(Offset.zero);
    });
    testWidgets('render', (tester) async {
      const camera = MapCamera(
        center: Geographic(lon: 0, lat: 0),
        zoom: 5,
        bearing: 12,
        pitch: 0,
      );
      final controller = MockMapController();
      when(controller.getCamera).thenReturn(camera);
      when(
        () => controller.toLngLat(any()),
      ).thenReturn(const Geographic(lon: 0, lat: 0));
      when(() => controller.getMetersPerPixelAtLatitude(any())).thenReturn(100);
      const padding = EdgeInsets.all(2);
      const alignment = Alignment.center;
      final app = App(
        camera: camera,
        controller: controller,
        children: const [MapScalebar(alignment: alignment, padding: padding)],
      );
      await tester.pumpWidget(app);
      // give some time for getMetersPerPixelAtLatitude
      await tester.pumpAndSettle();

      expect(find.byType(MapScalebar), findsOneWidget);

      // check Container
      final containerFinder = find.descendant(
        of: find.byType(MapScalebar),
        matching: find.byType(Container),
      );
      expect(containerFinder, findsOneWidget);
      final container = tester.firstWidget<Container>(containerFinder);
      expect(container.padding, equals(padding));
      expect(container.alignment, equals(alignment));

      // check CustomPaint
      final customPaintFinder = find.descendant(
        of: find.byType(MapScalebar),
        matching: find.byType(CustomPaint),
      );
      expect(customPaintFinder, findsOneWidget);
      final size = tester.getSize(customPaintFinder);
      expect(size.width, equals(100));
      expect(size.height, equals(22));
    });
    testWidgets('render imperial', (tester) async {
      const camera = MapCamera(
        center: Geographic(lon: 0, lat: 0),
        zoom: 5,
        bearing: 12,
        pitch: 0,
      );
      final controller = MockMapController();
      when(controller.getCamera).thenReturn(camera);
      when(
        () => controller.toLngLat(any()),
      ).thenReturn(const Geographic(lon: 0, lat: 0));
      when(() => controller.getMetersPerPixelAtLatitude(any())).thenReturn(100);
      const padding = EdgeInsets.all(2);
      const alignment = Alignment.center;
      final app = App(
        camera: camera,
        controller: controller,
        children: const [
          MapScalebar(
            alignment: alignment,
            padding: padding,
            units: ScaleBarUnit.imperial,
          ),
        ],
      );
      await tester.pumpWidget(app);
      // give some time for getMetersPerPixelAtLatitude
      await tester.pumpAndSettle();

      expect(find.byType(MapScalebar), findsOneWidget);

      // check Container
      final containerFinder = find.descendant(
        of: find.byType(MapScalebar),
        matching: find.byType(Container),
      );
      expect(containerFinder, findsOneWidget);
      final container = tester.firstWidget<Container>(containerFinder);
      expect(container.padding, equals(padding));
      expect(container.alignment, equals(alignment));

      // check CustomPaint
      final customPaintFinder = find.descendant(
        of: find.byType(MapScalebar),
        matching: find.byType(CustomPaint),
      );
      expect(customPaintFinder, findsOneWidget);
      final size = tester.getSize(customPaintFinder);
      expect(size.width, moreOrLessEquals(160.9344));
      expect(size.height, equals(22));
    });
    testWidgets('render 2', (tester) async {
      const camera = MapCamera(
        center: Geographic(lon: 0, lat: 0),
        zoom: 5,
        bearing: 12,
        pitch: 0,
      );
      final controller = MockMapController();
      when(controller.getCamera).thenReturn(camera);
      when(
        () => controller.toLngLat(any()),
      ).thenReturn(const Geographic(lon: 0, lat: 0));
      when(
        () => controller.getMetersPerPixelAtLatitude(any()),
      ).thenReturn(0.001);
      final app = App(
        camera: camera,
        controller: controller,
        children: const [MapScalebar()],
      );
      await tester.pumpWidget(app);
      // give some time for getMetersPerPixelAtLatitude
      await tester.pumpAndSettle();

      expect(find.byType(MapScalebar), findsOneWidget);

      // check Container
      final containerFinder = find.descendant(
        of: find.byType(MapScalebar),
        matching: find.byType(Container),
      );
      expect(containerFinder, findsOneWidget);

      // check CustomPaint
      final customPaintFinder = find.descendant(
        of: find.byType(MapScalebar),
        matching: find.byType(CustomPaint),
      );
      expect(customPaintFinder, findsOneWidget);
      final size = tester.getSize(customPaintFinder);
      expect(size.width, equals(100));
      expect(size.height, equals(22));
    });
    testWidgets('render 2 imperial', (tester) async {
      const camera = MapCamera(
        center: Geographic(lon: 0, lat: 0),
        zoom: 5,
        bearing: 12,
        pitch: 0,
      );
      final controller = MockMapController();
      when(controller.getCamera).thenReturn(camera);
      when(
        () => controller.toLngLat(any()),
      ).thenReturn(const Geographic(lon: 0, lat: 0));
      when(
        () => controller.getMetersPerPixelAtLatitude(any()),
      ).thenReturn(0.001);
      final app = App(
        camera: camera,
        controller: controller,
        children: const [MapScalebar(units: ScaleBarUnit.imperial)],
      );
      await tester.pumpWidget(app);
      // give some time for getMetersPerPixelAtLatitude
      await tester.pumpAndSettle();

      expect(find.byType(MapScalebar), findsOneWidget);

      // check Container
      final containerFinder = find.descendant(
        of: find.byType(MapScalebar),
        matching: find.byType(Container),
      );
      expect(containerFinder, findsOneWidget);

      // check CustomPaint
      final customPaintFinder = find.descendant(
        of: find.byType(MapScalebar),
        matching: find.byType(CustomPaint),
      );
      expect(customPaintFinder, findsOneWidget);
      final size = tester.getSize(customPaintFinder);
      expect(size.width, equals(776));
      expect(size.height, equals(22));
    });
    group('accuracy', () {
      final meters = <double, double>{
        300000: 50000000,
        200000: 30000000,
        100000: 20000000,
        75000: 10000000,
        50000: 5000000,
        30000: 3000000,
        15000: 2000000,
        10000: 1000000,
        5000: 500000,
        3000: 300000,
        2000: 200000,
        1000: 100000,
        500: 50000,
        300: 30000,
        200: 20000,
        100: 10000,
        50: 5000,
        30: 3000,
        20: 2000,
        10: 1000,
        5: 500,
        3: 300,
        2: 200,
        1: 100,
        0.5: 50,
        0.3: 30,
        0.2: 20,
        0.1: 10,
        0.05: 5,
        0.03: 3,
        0.02: 2,
        0.01: 1,
      };
      meters.forEach((metersPerPixel, expectedMeters) {
        testWidgets('is correct for $metersPerPixel metersPerPixel', (
          tester,
        ) async {
          const camera = MapCamera(
            center: Geographic(lon: 0, lat: 0),
            zoom: 5,
            bearing: 12,
            pitch: 0,
          );
          final controller = MockMapController();
          when(controller.getCamera).thenReturn(camera);
          when(
            () => controller.toLngLat(any()),
          ).thenReturn(const Geographic(lon: 0, lat: 0));
          when(
            () => controller.getMetersPerPixelAtLatitude(any()),
          ).thenReturn(metersPerPixel);
          final app = App(
            camera: camera,
            controller: controller,
            children: const [MapScalebar()],
          );
          await tester.pumpWidget(app);
          // give some time for getMetersPerPixelAtLatitude
          await tester.pumpAndSettle();

          // check CustomPaint
          final customPaintFinder = find.descendant(
            of: find.byType(MapScalebar),
            matching: find.byType(CustomPaint),
          );
          expect(customPaintFinder, findsOneWidget);
          final size = tester.getSize(customPaintFinder);
          expect(size.width, closeTo(expectedMeters / metersPerPixel, 0.01));
          expect(size.height, equals(22));
        });
      });
    });
  });
}
