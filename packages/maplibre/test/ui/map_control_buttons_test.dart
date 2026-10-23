import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:mocktail/mocktail.dart';

import '../shared/mocks.dart';
import '../shared/ui_app.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(MockDuration());
  });

  group('MapControlButtons', () {
    const camera = MapCamera(
      center: Geographic(lon: 0, lat: 0),
      zoom: 5,
      bearing: 12,
      pitch: 0,
    );

    late MockMapController controller;
    setUp(() {
      controller = MockMapController();
      when(controller.getCamera).thenReturn(camera);
      when(
        () => controller.animateCamera(
          zoom: any(named: 'zoom'),
          nativeDuration: any(named: 'nativeDuration'),
        ),
      ).thenAnswer((_) async {});
    });

    Future<void> pump(WidgetTester tester) => tester.pumpWidget(
      App(
        camera: camera,
        controller: controller,
        children: const [
          MapControlButtons(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(2),
          ),
        ],
      ),
    );

    testWidgets('shows zoom buttons without a location button', (tester) async {
      await pump(tester);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
      // No platform offers the user location yet.
      expect(find.byIcon(Icons.gps_not_fixed), findsNothing);
      expect(
        tester.getTopLeft(find.byType(FloatingActionButton).first),
        const Offset(2, 2),
      );
    });

    testWidgets('zooms in by one level', (tester) async {
      await pump(tester);
      await tester.tap(find.byIcon(Icons.add));
      verify(
        () => controller.animateCamera(
          zoom: 6,
          nativeDuration: const Duration(milliseconds: 200),
        ),
      ).called(1);
    });

    testWidgets('zooms out by one level', (tester) async {
      await pump(tester);
      await tester.tap(find.byIcon(Icons.remove));
      verify(
        () => controller.animateCamera(
          zoom: 4,
          nativeDuration: const Duration(milliseconds: 200),
        ),
      ).called(1);
    });
  });
}
