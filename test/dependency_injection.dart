import 'dart:async';

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

      final completer = Completer<BuildContext>();
      final app = App(
        camera: mockCamera,
        controller: mockController,
        children: [
          Builder(
            builder: (context) {
              completer.complete(context);
              return const SizedBox.shrink();
            },
          ),
        ],
      );
      await tester.pumpWidget(app);
      final context = await completer.future;
      expect(MapController.maybeOf(context), equals(mockController));
      expect(MapController.of(context), equals(mockController));
    });
    testWidgets('MapCamera', (tester) async {
      final mockCamera = MockMapCamera();
      final mockController = MockMapController();

      final completer = Completer<BuildContext>();
      final app = App(
        camera: mockCamera,
        controller: mockController,
        children: [
          Builder(
            builder: (context) {
              completer.complete(context);
              return const SizedBox.shrink();
            },
          ),
        ],
      );
      await tester.pumpWidget(app);
      final context = await completer.future;
      expect(MapCamera.maybeOf(context), equals(mockCamera));
      expect(MapCamera.of(context), equals(mockCamera));
    });
    testWidgets('MapOptions', (tester) async {
      final mockCamera = MockMapCamera();
      final mockController = MockMapController();
      final mockOptions = MockMapOptions();
      when(() => mockController.options).thenReturn(mockOptions);

      final completer = Completer<BuildContext>();
      final app = App(
        camera: mockCamera,
        controller: mockController,
        children: [
          Builder(
            builder: (context) {
              completer.complete(context);
              return const SizedBox.shrink();
            },
          ),
        ],
      );
      await tester.pumpWidget(app);
      final context = await completer.future;
      expect(MapOptions.maybeOf(context), equals(mockOptions));
      expect(MapOptions.of(context), equals(mockOptions));
    });
  });
}
