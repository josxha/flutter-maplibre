import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/utils/map_styles.dart';

import '../apps/map_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('style', () {
    testWidgets('Load JSON', (tester) async {
      final controller = Completer<MapController>();
      final style = Completer<StyleController>();
      final app = MapApp(
        onMapCreated: controller.complete,
        onStyleLoaded: style.complete,
        options: MapOptions(
          initCenter: const Geographic(lon: 0, lat: 0),
          initStyle: MapStyles.countries.uri,
        ),
      );
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      final styleC = await style.future;
      expect(styleC.getLayerIds().contains('countries-fill'), isTrue);
    });

    testWidgets('Load URL', (tester) async {
      final controller = Completer<MapController>();
      final style = Completer<StyleController>();
      final app = MapApp(
        onMapCreated: controller.complete,
        onStyleLoaded: style.complete,
        options: MapOptions(
          initCenter: const Geographic(lon: 0, lat: 0),
          initStyle: MapStyles.openMapTilesStreets.uri,
        ),
      );
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      final styleC = await style.future;
      expect(styleC.getLayerIds().contains('Wood'), isTrue);
    });
  });
}
