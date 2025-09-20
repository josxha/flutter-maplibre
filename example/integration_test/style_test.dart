import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/map_styles.dart';

import 'app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('style', () {
    testWidgets('Load JSON', (tester) async {
      final controller = Completer<MapController>();
      final style = Completer<StyleController>();
      final app = App(
        onMapCreated: controller.complete,
        onStyleLoaded: style.complete,
        options: MapOptions(
          initCenter: Position(0, 0),
          initStyle: MapStyles.countries,
        ),
      );
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      final styleC = await style.future;
      expect(styleC.getLayerIds().contains('water_red'), isTrue);
    });

    testWidgets('Load URL', (tester) async {
      final controller = Completer<MapController>();
      final style = Completer<StyleController>();
      final app = App(
        onMapCreated: controller.complete,
        onStyleLoaded: style.complete,
        options: MapOptions(
          initCenter: Position(0, 0),
          initStyle: MapStyles.maptilerStreets,
        ),
      );
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      final styleC = await style.future;
      expect(styleC.getLayerIds().contains('Wood'), isTrue);
    });
  });
}
