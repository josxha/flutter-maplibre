import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mocktail/mocktail.dart';

import '../shared/mocks.dart';
import '../shared/ui_app.dart';

void main() {
  group('SourceAttribution', () {
    testWidgets('render', (tester) async {
      final camera = MapCamera(
        center: Position(0, 0),
        zoom: 5,
        bearing: 12,
        pitch: 0,
      );
      final controller = MockMapController();
      final style = MockStyleController();
      when(controller.getCamera).thenReturn(camera);
      when(() => controller.style).thenReturn(style);
      when(style.getAttributions).thenAnswer(
        (_) async =>
            ['Source 1', '<a href="https://maplibre.org">Source 2</a>'],
      );
      const padding = EdgeInsets.all(2);
      const alignment = Alignment.center;
      final app = App(
        camera: camera,
        controller: controller,
        children: const [
          SourceAttribution(alignment: alignment, padding: padding),
        ],
      );
      await tester.pumpWidget(app);
      // give some time for getAttributions
      await tester.pumpAndSettle();

      expect(find.byType(SourceAttribution), findsOneWidget);

      // check Container
      final containerFinder = find.descendant(
        of: find.byType(SourceAttribution),
        matching: find.byType(Container),
      );
      expect(containerFinder, findsWidgets);
      final container = tester.firstWidget<Container>(containerFinder);
      expect(container.padding, equals(padding));
      expect(container.alignment, equals(alignment));
    });
  });
}
