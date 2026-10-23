import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  runTests();
}

/// Features that neither implementation offers yet. These tests document that
/// they fail clearly, and are to be replaced once a platform supports them.
void runTests() {
  group('unsupported features', () {
    test('OfflineManager on web', () async {
      await expectLater(
        OfflineManager.createInstance(),
        throwsA(isA<UnsupportedError>()),
      );
    }, skip: !kIsWeb);

    test('PermissionManager', () {
      expect(PermissionManager.new, throwsA(isA<UnsupportedError>()));
    });

    test('user location', () {
      expect(MapController.userLocationIsSupported, isFalse);
    });
  });
}
