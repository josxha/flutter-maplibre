import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mocktail/mocktail.dart';

import 'shared/mocks.dart';
import 'shared/ui_app.dart';

void main() {
  group('the map in the widget tree', () {
    const camera = MapCamera(
      center: Geographic(lon: 1, lat: 2),
      zoom: 3,
      bearing: 0,
      pitch: 0,
    );
    const options = MapOptions(initCamera: InitialCamera.position(zoom: 3));

    Future<BuildContext> pumpChild(
      WidgetTester tester,
      MapController controller,
    ) async {
      late BuildContext context;
      await tester.pumpWidget(
        App(
          camera: camera,
          controller: controller,
          children: [
            Builder(
              builder: (c) {
                context = c;
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      );
      return context;
    }

    testWidgets('children find the controller, camera and options', (
      tester,
    ) async {
      final controller = MockMapController();
      when(() => controller.options).thenReturn(options);
      final context = await pumpChild(tester, controller);
      expect(MapController.maybeOf(context), same(controller));
      expect(MapController.of(context), same(controller));
      expect(MapCamera.maybeOf(context), camera);
      expect(MapCamera.of(context), camera);
      expect(MapOptions.maybeOf(context), same(options));
      expect(MapOptions.of(context), same(options));
    });

    testWidgets('widgets outside of a map find nothing', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(
        Builder(
          builder: (c) {
            context = c;
            return const SizedBox.shrink();
          },
        ),
      );
      expect(MapController.maybeOf(context), isNull);
      expect(MapCamera.maybeOf(context), isNull);
      expect(MapOptions.maybeOf(context), isNull);
      expect(() => MapController.of(context), throwsStateError);
      expect(() => MapCamera.of(context), throwsStateError);
    });
  });
}
