import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('controller', () {
    testWidgets(
      'render map',
      (tester) async {
        await tester.pumpWidget(const App());
        await tester.pumpAndSettle();
        expect(tester.allWidgets.any((w) => w is MapLibreMap), isTrue);
      },
    );
    testWidgets(
      'getCamera',
      (tester) async {
        late final MapController ctrl;
        final app = App(
          onMapCreated: (controller) => ctrl = controller,
          options: MapOptions(center: Position(1, 2)),
        );
        await tester.pumpWidget(app);
        await tester.pumpAndSettle();
        await ctrl.jumpTo(center: Position(1, 1), bearing: 1, zoom: 1, tilt: 1);
        await tester.pumpAndSettle();
        final camera = await ctrl.getCamera();
        expect(camera.center.lng, closeTo(1, 0.00001));
        expect(camera.center.lat, closeTo(1, 0.00001));
        expect(camera.zoom, closeTo(1, 0.00001));
        expect(camera.bearing, closeTo(1, 0.00001));
        expect(camera.tilt, closeTo(1, 0.00001));
      },
    );
    testWidgets(
      'jumpTo',
      (tester) async {
        late final MapController ctrl;
        final app = App(onMapCreated: (controller) => ctrl = controller);
        await tester.pumpWidget(app);
        await tester.pumpAndSettle();
        await ctrl.jumpTo(center: Position(1, 2), bearing: 1, zoom: 1, tilt: 1);
        await tester.pumpAndSettle();
        final camera = await ctrl.getCamera();
        expect(camera.center.lng, closeTo(1, 0.00001));
        expect(camera.center.lat, closeTo(2, 0.00001));
        expect(camera.zoom, closeTo(1, 0.00001));
        expect(camera.bearing, closeTo(1, 0.00001));
        expect(camera.tilt, closeTo(1, 0.00001));
      },
    );
    testWidgets(
      'flyTo',
      (tester) async {
        late final MapController ctrl;
        final app = App(onMapCreated: (controller) => ctrl = controller);
        await tester.pumpWidget(app);
        await tester.pumpAndSettle();
        await ctrl.flyTo(
          center: Position(2, 1),
          bearing: 2,
          zoom: 2,
          tilt: 2,
          webSpeed: 100,
          nativeDuration: Duration.zero,
        );
        await tester.pumpAndSettle();
        final camera = await ctrl.getCamera();
        expect(camera.center.lng, closeTo(2, 0.00001));
        expect(camera.center.lat, closeTo(1, 0.00001));
        expect(camera.zoom, closeTo(2, 0.00001));
        expect(camera.bearing, closeTo(2, 0.00001));
        expect(camera.tilt, closeTo(2, 0.00001));
      },
    );
    testWidgets(
      'flyTo cancel',
      (tester) async {
        late final MapController ctrl;
        final app = App(onMapCreated: (controller) => ctrl = controller);
        await tester.pumpWidget(app);
        await tester.pumpAndSettle();
        await expectLater(
          ctrl.flyTo(
            center: Position(2, 2),
            bearing: 2,
            zoom: 2,
            tilt: 2,
            webSpeed: 0.1,
            nativeDuration: const Duration(seconds: 10),
          ),
          throwsA(isA<PlatformException>()),
        );
      },
    );
    testWidgets(
      'getMetersPerPixelAtLatitude',
      (tester) async {
        late final MapController ctrl;
        final app = App(onMapCreated: (controller) => ctrl = controller);
        await tester.pumpWidget(app);
        await tester.pumpAndSettle();
        await expectLater(
          ctrl.getMetersPerPixelAtLatitude(23),
          closeTo(12345, 0.00001), // TODO adjust value
        );
      },
    );
  });
}
