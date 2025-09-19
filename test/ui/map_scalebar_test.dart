import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mocktail/mocktail.dart';

import '../shared/mocks.dart';
import '../shared/ui_app.dart';

void main() {
  group('MapScalebar', () {
    testWidgets('render', (tester) async {
      final camera = MapCamera(
        center: Position(0, 0),
        zoom: 5,
        bearing: 12,
        pitch: 0,
      );
      final controller = MockMapController();
      when(controller.getCamera).thenReturn(camera);
      when(
        () => controller.getMetersPerPixelAtLatitude(any()),
      ).thenAnswer((_) async => 100.0);
      when(
        () => controller.getMetersPerPixelAtLatitudeSync(any()),
      ).thenReturn(100);
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
      final camera = MapCamera(
        center: Position(0, 0),
        zoom: 5,
        bearing: 12,
        pitch: 0,
      );
      final controller = MockMapController();
      when(controller.getCamera).thenReturn(camera);
      when(
        () => controller.getMetersPerPixelAtLatitude(any()),
      ).thenAnswer((_) async => 100.0);
      when(
        () => controller.getMetersPerPixelAtLatitudeSync(any()),
      ).thenReturn(100);
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
      final camera = MapCamera(
        center: Position(0, 0),
        zoom: 5,
        bearing: 12,
        pitch: 0,
      );
      final controller = MockMapController();
      when(controller.getCamera).thenReturn(camera);
      when(
        () => controller.getMetersPerPixelAtLatitude(any()),
      ).thenAnswer((_) async => 0.001);
      when(
        () => controller.getMetersPerPixelAtLatitudeSync(any()),
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
      final camera = MapCamera(
        center: Position(0, 0),
        zoom: 5,
        bearing: 12,
        pitch: 0,
      );
      final controller = MockMapController();
      when(controller.getCamera).thenReturn(camera);
      when(
        () => controller.getMetersPerPixelAtLatitude(any()),
      ).thenAnswer((_) async => 0.001);
      when(
        () => controller.getMetersPerPixelAtLatitudeSync(any()),
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
  });
}
