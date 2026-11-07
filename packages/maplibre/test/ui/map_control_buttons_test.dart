import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/ui/map_button.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../shared/mocks.dart';
import '../shared/ui_app.dart';

Finder icon(MapButtonIcon icon) => find.byWidgetPredicate(
  (widget) =>
      widget is CustomPaint &&
      widget.painter is MapButtonIconPainter &&
      (widget.painter! as MapButtonIconPainter).icon == icon,
);

void main() {
  setUpAll(() {
    registerFallbackValue(const CameraUpdate.position());
    registerFallbackValue(const CameraAnimation.ease());
  });

  group('MapControlButtons', () {
    const camera = CameraPosition(
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
        () =>
            controller.animateCamera(any(), animation: any(named: 'animation')),
      ).thenAnswer((_) async => CameraAnimationResult.completed);
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
      expect(find.bySemanticsLabel('Zoom in'), findsOneWidget);
      expect(find.bySemanticsLabel('Zoom out'), findsOneWidget);
      // The location button shows only with onTrackingPressed.
      expect(find.bySemanticsLabel('Track location'), findsNothing);
      expect(
        tester.getTopLeft(find.bySemanticsLabel('Zoom in')),
        const Offset(2, 2),
      );
    });

    testWidgets('zooms in by one level', (tester) async {
      await pump(tester);
      await tester.tap(find.bySemanticsLabel('Zoom in'));
      verify(
        () => controller.animateCamera(
          const CameraUpdate.position(zoom: 6),
          animation: const CameraAnimation.ease(
            duration: Duration(milliseconds: 200),
          ),
        ),
      ).called(1);
    });

    testWidgets('zooms out by one level', (tester) async {
      await pump(tester);
      await tester.tap(find.bySemanticsLabel('Zoom out'));
      verify(
        () => controller.animateCamera(
          const CameraUpdate.position(zoom: 4),
          animation: const CameraAnimation.ease(
            duration: Duration(milliseconds: 200),
          ),
        ),
      ).called(1);
    });

    testWidgets('shows the tracking and reports a press', (tester) async {
      var presses = 0;
      Future<void> pumpTracking(UserLocationTracking tracking) =>
          tester.pumpWidget(
            App(
              camera: camera,
              controller: controller,
              children: [
                MapControlButtons(
                  tracking: tracking,
                  onTrackingPressed: () => presses++,
                ),
              ],
            ),
          );
      await pumpTracking(UserLocationTracking.none);
      await tester.tap(find.bySemanticsLabel('Track location'));
      expect(presses, 1);
      await pumpTracking(UserLocationTracking.position);
      expect(icon(MapButtonIcon.location), findsOneWidget);
      await pumpTracking(UserLocationTracking.positionAndHeading);
      expect(icon(MapButtonIcon.locationAndHeading), findsOneWidget);
    });
  });
}
