import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mocktail/mocktail.dart';

import '../shared/mocks.dart';
import '../shared/ui_app.dart';

void main() {
  group('MapZoomButtons', () {
    testWidgets('render', (tester) async {
      final camera = MapCamera(
        center: Position(0, 0),
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
          MapZoomButtons(alignment: alignment, padding: padding),
        ],
      );
      await tester.pumpWidget(app);
      // give some time for getAttributions
      await tester.pumpAndSettle();

      expect(find.byType(MapZoomButtons), findsOneWidget);
    });
  });
}
