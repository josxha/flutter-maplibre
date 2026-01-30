import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mocktail/mocktail.dart';

import '../shared/mocks.dart';
import '../shared/ui_app.dart';

void main() {
  group('MapControlButtons', () {
    testWidgets('render', (tester) async {
      const camera = MapCamera(
        center: Geographic(lon: 0, lat: 0),
        zoom: 5,
        bearing: 12,
        pitch: 0,
      );
      final controller = MockMapController();
      when(controller.getCamera).thenReturn(camera);
      const padding = EdgeInsets.all(2);
      const alignment = Alignment.center;
      final app = App(
        camera: camera,
        controller: controller,
        children: const [
          MapControlButtons(alignment: alignment, padding: padding),
        ],
      );
      await tester.pumpWidget(app);
      // give some time for getAttributions
      await tester.pumpAndSettle();

      expect(find.byType(MapControlButtons), findsOneWidget);
    });
  });
}
