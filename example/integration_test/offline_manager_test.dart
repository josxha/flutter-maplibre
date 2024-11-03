import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('setOfflineTileCountLimit', () {
    testWidgets('backgroundLocationOfflineGranted', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      final manager = await OfflineManager.createInstance();
      manager.setOfflineTileCountLimit(amount: 1000);
      manager.dispose();
    });
    testWidgets('setMaximumAmbientCacheSize', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      final manager = await OfflineManager.createInstance();
      await manager.setMaximumAmbientCacheSize(bytes: 1000);
      manager.dispose();
    });
    testWidgets('clearAmbientCache', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      final manager = await OfflineManager.createInstance();
      await manager.clearAmbientCache();
      manager.dispose();
    });
    testWidgets('invalidateAmbientCache', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      final manager = await OfflineManager.createInstance();
      await manager.invalidateAmbientCache();
      manager.dispose();
    });
    testWidgets('packDatabase', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      final manager = await OfflineManager.createInstance();
      await manager.packDatabase();
      manager.dispose();
    });
    testWidgets('resetDatabase', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      final manager = await OfflineManager.createInstance();
      await manager.resetDatabase();
      manager.dispose();
    });
    testWidgets('runPackDatabaseAutomatically', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      final manager = await OfflineManager.createInstance();
      manager.runPackDatabaseAutomatically(enabled: true);
      manager.dispose();
    });
    testWidgets('downloadRegion', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      final manager = await OfflineManager.createInstance();
      const styleUrl = 'https://demotiles.maplibre.org/style.json';
      final stream = manager.downloadRegion(
        maxZoom: 1,
        minZoom: 0,
        pixelDensity: 1,
        mapStyleUrl: styleUrl,
        bounds: const LngLatBounds(
          longitudeWest: -180,
          longitudeEast: 180,
          latitudeSouth: -90,
          latitudeNorth: 90,
        ),
      );
      await for (final event in stream) {
        expect(event.region.styleUrl, styleUrl);
        expect(event.region.minZoom, 0);
        expect(event.region.maxZoom, 1);
      }
      final last = await stream.last;
      expect(last.progress, closeTo(1, 0.1));
      manager.dispose();
    });
  });
}
