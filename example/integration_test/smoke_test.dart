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
        expect(tester.allWidgets.any((w) => w is MapLibreMap), true);
      },
    );
    testWidgets(
      'jumpTo',
      (tester) async {
        late final MapController ctrl;
        final app = App(onMapCreated: (controller) => ctrl = controller);
        await tester.pumpWidget(app);
        await tester.pumpAndSettle();
        await ctrl.jumpTo(center: Position(1, 1), bearing: 1, zoom: 1, tilt: 1);
        await tester.pumpAndSettle();
        final camera = await ctrl.getCamera();
        expect(camera.center, Position(1, 1));
        expect(camera.zoom, 1);
        expect(camera.bearing, 1);
        expect(camera.tilt, 1);
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
          center: Position(2, 2),
          bearing: 2,
          zoom: 2,
          tilt: 2,
          webSpeed: 100,
          nativeDuration: Duration.zero,
        );
        await tester.pumpAndSettle();
        final camera = await ctrl.getCamera();
        expect(camera.center, Position(2, 2));
        expect(camera.zoom, 2);
        expect(camera.bearing, 2);
        expect(camera.tilt, 2);
      },
    );
  });
}
