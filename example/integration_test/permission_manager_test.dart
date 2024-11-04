import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('PermissionManager', () {
    testWidgets('backgroundLocationPermissionGranted', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      final manager = PermissionManager();
      expect(manager.backgroundLocationPermissionGranted, isTrue);
    });

    testWidgets('locationPermissionsGranted', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      final manager = PermissionManager();
      expect(manager.locationPermissionsGranted, isFalse);
    });

    testWidgets('runtimePermissionsRequired', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      final manager = PermissionManager();
      expect(manager.runtimePermissionsRequired, isTrue);
    });

    // can't interact with the native permission dialog: https://github.com/flutter/flutter/issues/86295
    /*testWidgets('runtimePermissionsRequired', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      final manager = PermissionManager();
      await expectLater(
        manager.requestLocationPermissions(explanation: 'explanation'),
        isTrue,
      );
    });*/
  });
}
