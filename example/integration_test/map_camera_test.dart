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
      const options = MapOptions(
        minZoom: 1,
        maxZoom: 2,
        initZoom: 1,
        initCenter: Geographic(lon: 1, lat: 2),
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
      expect(camera!.zoom, closeTo(1, 0.01));
      expect(camera.center.lon, closeTo(1, 0.01));
      expect(camera.center.lat, closeTo(2, 0.01));
    });
  });
}
