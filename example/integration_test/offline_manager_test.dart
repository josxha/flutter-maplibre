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
      expect(await manager.listOfflineRegions(), isEmpty);
      manager.dispose();
    });
    // testWidgets('downloadRegion', (tester) async {
    //   await tester.pumpWidget(const App());
    //   await tester.pumpAndSettle();
    //   final manager = await OfflineManager.createInstance();

    //   await manager.resetDatabase();
    //   await Future.delayed(const Duration(seconds: 1), () {});

    //   const styleUrl = 'https://demotiles.maplibre.org/style.json';
    //   const metadata = {'name': 'test', 'id': 99, 'empty': null};
    //   final stream = manager.downloadRegion(
    //     maxZoom: 1,
    //     minZoom: 0,
    //     pixelDensity: 1,
    //     mapStyleUrl: styleUrl,
    //     bounds: const LngLatBounds(
    //       longitudeWest: -180,
    //       longitudeEast: 180,
    //       latitudeSouth: -90,
    //       latitudeNorth: 90,
    //     ),
    //     metadata: metadata,
    //   );

    //   final first = await stream.first;
    //   expect(first.region.styleUrl, equals(styleUrl));
    //   expect(first.region.minZoom, equals(0));
    //   expect(first.region.maxZoom, equals(1));
    //   expect(first.region.metadata, equals(metadata));

    //   manager.dispose();
    // });
  });
}
