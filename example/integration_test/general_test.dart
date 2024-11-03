import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('General', () {
    testWidgets('render map with tlhc_vd', (tester) async {
      await tester.pumpWidget(
        App(
          options: MapOptions(
            initCenter: Position(0, 0),
            // ignore: avoid_redundant_argument_values
            androidMode: AndroidPlatformViewMode.tlhc_vd,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.allWidgets.any((w) => w is MapLibreMap), isTrue);
    });

    testWidgets('render map with tlhc_hc', (tester) async {
      await tester.pumpWidget(
        App(
          options: MapOptions(
            initCenter: Position(0, 0),
            // ignore: avoid_redundant_argument_values
            androidMode: AndroidPlatformViewMode.tlhc_hc,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.allWidgets.any((w) => w is MapLibreMap), isTrue);
    });

    testWidgets('render map with hc', (tester) async {
      await tester.pumpWidget(
        App(
          options: MapOptions(
            initCenter: Position(0, 0),
            // ignore: avoid_redundant_argument_values
            androidMode: AndroidPlatformViewMode.hc,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.allWidgets.any((w) => w is MapLibreMap), isTrue);
    });

    testWidgets('render map with vd', (tester) async {
      await tester.pumpWidget(
        App(
          options: MapOptions(
            initCenter: Position(0, 0),
            // ignore: avoid_redundant_argument_values
            androidMode: AndroidPlatformViewMode.vd,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.allWidgets.any((w) => w is MapLibreMap), isTrue);
    });
  });
}
