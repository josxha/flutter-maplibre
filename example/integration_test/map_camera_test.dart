import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/map_styles.dart';

import 'app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('MapCamera', () {
    testWidgets('get from map', (tester) async {
      final options = MapOptions(
        minZoom: 1,
        maxZoom: 2,
        initZoom: 1,
        initCenter: Position(1, 2),
        initStyle: MapStyles.protomapsLight,
      );
      final completer = Completer<MapController>();
      await tester.pumpWidget(
        App(options: options, onMapCreated: completer.complete),
      );
      await tester.pumpAndSettle();
      final ctrl = await completer.future;
      final camera = ctrl.camera;
      expect(camera, isNot(isNull));
      expect(camera!.zoom, equals(1));
      expect(camera.center, equals(Position(1, 2)));
    });
  });
}
