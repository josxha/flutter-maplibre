import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mocktail/mocktail.dart';

import 'shared/annotation_app.dart';
import 'shared/mocks.dart';

void main() {
  group('WidgetLayer', () {
    testWidgets('one marker', (tester) async {
      final camera = MapCamera(
        center: Position(0, 0),
        zoom: 0,
        bearing: 180,
        pitch: 0,
      );
      final controller = MockMapController();
      when(controller.getCamera).thenReturn(camera);
      const offsets = [Offset(123, 423)];
      when(
        () => controller.toScreenLocations(any()),
      ).thenAnswer((_) async => offsets);
      when(() => controller.toScreenLocationsSync(any())).thenReturn(offsets);
      final marker = Marker(
        point: Position(0, 0),
        size: const Size.square(50),
        child: const Icon(Icons.location_on, size: 50),
        alignment: Alignment.bottomCenter,
        rotate: true,
      );
      final app = App(
        camera: camera,
        controller: controller,
        children: [
          WidgetLayer(markers: [marker]),
        ],
      );
      await tester.pumpWidget(app);
      // give some time for toScreenLocations
      await tester.pumpAndSettle();

      expect(find.byType(WidgetLayer), findsOneWidget);

      expect(find.byType(Positioned), findsOneWidget);
      final size = tester.getSize(find.byType(Icon));
      expect(size.width, equals(50));
      expect(size.height, equals(50));

      expect(find.byType(Icon), findsOneWidget);
      final size2 = tester.getSize(find.byType(Icon));
      expect(size2.width, equals(50));
      expect(size2.height, equals(50));
    });

    testWidgets('multiple markers', (tester) async {
      final camera = MapCamera(
        center: Position(0, 0),
        zoom: 0,
        bearing: 180,
        pitch: 0,
      );
      final controller = MockMapController();
      when(controller.getCamera).thenReturn(camera);
      const offsets = [Offset(1, 100), Offset(2, 100), Offset(3, 300)];
      when(
        () => controller.toScreenLocations(any()),
      ).thenAnswer((_) async => offsets);
      when(() => controller.toScreenLocationsSync(any())).thenReturn(offsets);
      const size = 50.0;
      final markers = [
        Marker(
          point: Position(1, 1),
          size: const Size.square(size),
          alignment: Alignment.topLeft,
          child: const Icon(Icons.circle, size: size),
        ),
        Marker(
          point: Position(2, 1),
          size: const Size.square(size),
          alignment: Alignment.topLeft,
          child: const Icon(Icons.square, size: size),
        ),
        Marker(
          point: Position(3, 1),
          size: const Size.square(size),
          alignment: Alignment.topLeft,
          child: const Icon(Icons.emoji_emotions, size: size),
        ),
      ];
      final app = App(
        camera: camera,
        controller: controller,
        children: [WidgetLayer(markers: markers)],
      );
      await tester.pumpWidget(app);
      // give some time for toScreenLocations
      await tester.pumpAndSettle();

      expect(find.byType(WidgetLayer), findsOneWidget);
      expect(find.byType(Positioned), findsNWidgets(3));

      final finder = find.descendant(
        of: find.byType(WidgetLayer),
        matching: find.byType(Positioned),
      );
      final positioned = tester.firstWidget<Positioned>(finder);
      // defaultTargetPlatform defaults to Android in the tests
      expect(positioned.left, closeTo(offsets.first.dx / 3, 0.01));
      expect(positioned.top, closeTo(offsets.first.dy / 3, 0.01));
      expect(positioned.width, closeTo(size, 0.01));
      expect(positioned.height, closeTo(size, 0.01));
    });
  });
}
