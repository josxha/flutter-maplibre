import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('controller', () {
    testWidgets(
      'render map',
      (tester) async {
        final app = MaterialApp(
          title: 'MapLibre Demo',
          home: Scaffold(
            body: MapLibreMap(options: MapOptions(center: Position(0, 0))),
          ),
        );
        await tester.pumpWidget(app);
        await tester.pumpAndSettle();
        expect(tester.allWidgets.any((w) => w is MapLibreMap), true);
      },
    );

    testWidgets(
      'jumpTo',
      (tester) async {
        late MapController controller;
        final app = MaterialApp(
          title: 'MapLibre Demo',
          home: Scaffold(
            body: MapLibreMap(
              options: MapOptions(center: Position(0, 0)),
              onMapCreated: (ctrl) => controller = ctrl,
            ),
          ),
        );
        await tester.pumpWidget(app);
        await tester.pumpAndSettle();
        await controller.jumpTo(
          center: Position(10, 10),
          zoom: 10,
          bearing: 10,
          tilt: 10,
        );
      },
    );
  });
}
