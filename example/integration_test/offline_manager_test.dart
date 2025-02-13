import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maplibre/maplibre.dart';

import 'app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('OfflineManager', () {
    testWidgets('backgroundLocationOfflineGranted', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      final manager = await OfflineManager.createInstance();
      manager.setOfflineTileCountLimit(amount: 1000);
      manager.dispose();
    });
    /* TODO fix app freeze testWidgets('setMaximumAmbientCacheSize', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      final manager = await OfflineManager.createInstance();
      await manager.setMaximumAmbientCacheSize(bytes: 1000);
      manager.dispose();
    });*/
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
    testWidgets('getOfflineRegion', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      final manager = await OfflineManager.createInstance();
      expect(
        () async => manager.getOfflineRegion(regionId: 234),
        throwsA(isA<Exception>()),
      );
      manager.dispose();
    });
    testWidgets('listOfflineRegions', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      final manager = await OfflineManager.createInstance();
      expect(
        await manager.listOfflineRegions(),
        isEmpty,
      );
      manager.dispose();
    });
    /*testWidgets('downloadRegion', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      final manager = await OfflineManager.createInstance();
      await manager.resetDatabase();

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
        expect(event.region.styleUrl, equals(styleUrl));
        expect(event.region.minZoom, equals(0));
        expect(event.region.maxZoom, equals(1));
      }
      final last = await stream.last;
      expect(last.progress, closeTo(1, 0.1));

      // get regions
      final regions = await manager.listOfflineRegions();
      expect(regions, hasLength(1));
      final region = regions.first;
      expect(
        region.styleUrl,
        equals('https://demotiles.maplibre.org/style.json'),
      );
      expect(region.minZoom, 0);
      expect(region.maxZoom, 0);

      // get region
      final region2 = await manager.getOfflineRegion(regionId: 1);
      expect(region, equals(region2));
      expect(region.hashCode, equals(region2.hashCode));

      manager.dispose();
    });*/
  });
}
