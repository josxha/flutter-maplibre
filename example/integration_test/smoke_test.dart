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
        late final MapController ctrl;
        final app = App(
          onMapCreated: (controller) => ctrl = controller,
        );
        await tester.pumpWidget(app);
        await tester.pumpAndSettle();
        expect(tester.allWidgets.any((w) => w is MapLibreMap), true);
        // await ctrl.jumpTo(center: Position(1, 1), bearing: 1, zoom: 1, tilt: 1);
      },
    );
  });
}
