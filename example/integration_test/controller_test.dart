import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('controller', () {
    testWidgets('getCamera', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: MapOptions(initCenter: Position(1, 2)),
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      await ctrl.moveCamera(
        center: Position(1, 1),
        bearing: 1,
        zoom: 1,
        pitch: 1,
      );
      await tester.pumpAndSettle();
      final camera = ctrl.getCamera();
      expect(camera.center.lng, closeTo(1, 0.00001));
      expect(camera.center.lat, closeTo(1, 0.00001));
      expect(camera.zoom, closeTo(1, 0.00001));
      expect(camera.bearing, closeTo(1, 0.00001));
      expect(camera.pitch, closeTo(1, 0.00001));
    });

    testWidgets('toScreenLocation', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(
        onMapCreated: ctrlCompleter.complete,
        options: MapOptions(initCenter: Position(1, 2)),
      );
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      final offset = await ctrl.toScreenLocation(Position(1,2));
      print('offset: $offset');
      expect(offset.dx, closeTo(1, 0.00001));
      expect(offset.dy, closeTo(2, 0.00001));
    });

    testWidgets('moveCamera', (tester) async {
      final ctrlCompleter = Completer<MapController>();
      final app = App(onMapCreated: ctrlCompleter.complete);
      await tester.pumpWidget(app);
      final ctrl = await ctrlCompleter.future;
      await ctrl.moveCamera(
        center: Position(1, 2),
        bearing: 1,
        zoom: 1,
        pitch: 1,
      );
      await tester.pumpAndSettle();
      final camera = ctrl.getCamera();
      expect(camera.center.lng, closeTo(1, 0.00001));
      expect(camera.center.lat, closeTo(2, 0.00001));
      expect(camera.zoom, closeTo(1, 0.00001));
      expect(camera.bearing, closeTo(1, 0.00001));
      expect(camera.pitch, closeTo(1, 0.00001));
    });
  });
}
