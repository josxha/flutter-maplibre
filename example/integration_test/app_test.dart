import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('integration tests', () {
    testWidgets(
      'show map',
      (tester) async {
        await tester.pumpWidget(const App());
        await tester.pumpAndSettle();
      },
    );
  });
}
