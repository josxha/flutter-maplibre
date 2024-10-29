import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/styled_map_page.dart';

@immutable
class OfflinePage extends StatefulWidget {
  const OfflinePage({super.key});

  static const location = '/offline';

  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  final _futureOfflineManager = OfflineManager.createInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offline Map')),
      body: FutureBuilder<OfflineManager>(
        future: _futureOfflineManager,
        builder: (context, snapshot) {
          if (snapshot.data case final OfflineManager manager) {
            return ListView(
              children: [
                ListTile(
                  title: const Text('mergeOfflineRegions'),
                  onTap: () async {
                    final regions = await manager.mergeOfflineRegions(
                      path: 'region.mbtiles',
                    );
                    _print(
                      'offline regions merged:\n${regions.join('\n')}',
                    );
                  },
                ),
                ListTile(
                  title: const Text('getOfflineRegion'),
                  onTap: () async {
                    final region = await manager.getOfflineRegion(regionId: 1);
                    _print('offline region: $region');
                  },
                ),
                ListTile(
                  title: const Text('setOfflineTileCountLimit'),
                  onTap: () async {
                    manager.setOfflineTileCountLimit(amount: 5000);
                    _print('offline tile count limit set');
                  },
                ),
                ListTile(
                  title: const Text('setMaximumAmbientCacheSize'),
                  onTap: () async {
                    await manager.setMaximumAmbientCacheSize(bytes: 10000000);
                    _print('maximum ambient cache size set');
                  },
                ),
                ListTile(
                  title: const Text('clearAmbientCache'),
                  onTap: () async {
                    await manager.clearAmbientCache();
                    _print('ambient cache cleared');
                  },
                ),
                ListTile(
                  title: const Text('invalidateAmbientCache'),
                  onTap: () async {
                    await manager.invalidateAmbientCache();
                    _print('ambient cache invalidated');
                  },
                ),
                ListTile(
                  title: const Text('listOfflineRegions'),
                  onTap: () async {
                    final regions = await manager.listOfflineRegions();
                    _print('offline regions:\n${regions.join('\n')}');
                  },
                ),
                ListTile(
                  title: const Text('packDatabase'),
                  onTap: () async {
                    await manager.packDatabase();
                    _print('database optimized');
                  },
                ),
                ListTile(
                  title: const Text('resetDatabase'),
                  onTap: () async {
                    await manager.resetDatabase();
                    _print('database reset');
                  },
                ),
                ListTile(
                  title: const Text('runPackDatabaseAutomatically'),
                  onTap: () async {
                    manager.runPackDatabaseAutomatically(enabled: true);
                    _print('enable automatic database optimization');
                  },
                ),
                ListTile(
                  title: const Text('downloadRegion'),
                  onTap: () async {
                    final region = await manager.downloadRegion(
                      minZoom: 0,
                      maxZoom: 1,
                      bounds: const LngLatBounds(
                        longitudeWest: -1,
                        longitudeEast: 1,
                        latitudeSouth: -1,
                        latitudeNorth: 1,
                      ),
                      mapStyleUrl: StyledMapPage.styleUrl,
                      pixelDensity: 1,
                    );
                    _print('region downloaded: $region');
                  },
                ),
              ],
            );
          }
          if (snapshot.error case final Object error) {
            return Center(child: Text(error.toString()));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _print(String message) {
    debugPrint(message);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _futureOfflineManager.then((manager) => manager.dispose());
    super.dispose();
  }
}
