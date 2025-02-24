import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/map_styles.dart';

import 'app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('MapOptions', () {
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
      final options2 = ctrl.options;
      expect(options2, equals(options));
      expect(options2.hashCode, equals(options.hashCode));
    });

    testWidgets('default gestures in map', (tester) async {
      final completer = Completer<MapController>();
      await tester.pumpWidget(App(onMapCreated: completer.complete));
      await tester.pumpAndSettle();
      final ctrl = await completer.future;
      final options = ctrl.options;
      expect(options.gestures.drag, isFalse);
      expect(options.gestures.zoom, isTrue);
      expect(options.gestures.rotate, isTrue);
      expect(options.gestures.pitch, isTrue);
      expect(options.gestures.pan, isTrue);
    });
  });
}
