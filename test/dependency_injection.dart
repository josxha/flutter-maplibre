import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mocktail/mocktail.dart';

import 'shared/mocks.dart';
import 'shared/ui_app.dart';

void main() {
  group('Dependency Injection', () {
    testWidgets('MapController', (tester) async {
      final mockCamera = MockMapCamera();
      final mockController = MockMapController();

      final app = App(
        camera: mockCamera,
        controller: mockController,
        children: [
          Builder(
            builder: (context) {
              expect(MapController.maybeOf(context), equals(mockController));
              expect(MapController.of(context), equals(mockController));
              return const SizedBox.shrink();
            },
          ),
        ],
      );
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();
    });
    testWidgets('MapCamera', (tester) async {
      final mockCamera = MockMapCamera();
      final mockController = MockMapController();

      final app = App(
        camera: mockCamera,
        controller: mockController,
        children: [
          Builder(
            builder: (context) {
              expect(MapCamera.maybeOf(context), equals(mockCamera));
              expect(MapCamera.of(context), equals(mockCamera));
              return const SizedBox.shrink();
            },
          ),
        ],
      );
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();
    });
    testWidgets('MapOptions', (tester) async {
      final mockCamera = MockMapCamera();
      final mockController = MockMapController();
      final mockOptions = MockMapOptions();
      when(() => mockController.options).thenReturn(mockOptions);

      final app = App(
        camera: mockCamera,
        controller: mockController,
        children: [
          Builder(
            builder: (context) {
              expect(MapOptions.maybeOf(context), equals(mockOptions));
              expect(MapOptions.of(context), equals(mockOptions));
              return const SizedBox.shrink();
            },
          ),
        ],
      );
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();
    });
  });
}
