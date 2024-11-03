import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('General', () {
    testWidgets('render map', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      expect(tester.allWidgets.any((w) => w is MapLibreMap), isTrue);
    });
  });
}
