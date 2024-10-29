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
  String? _downloadProgress;

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
                    try {
                      final regions = await manager.mergeOfflineRegions(
                        path: 'region.mbtiles',
                      );
                      _print(
                        'offline regions merged:\n${regions.join('\n')}',
                      );
                    } catch (error, stacktrace) {
                      _print(error.toString());
                      debugPrintStack(stackTrace: stacktrace);
                    }
                  },
                ),
                ListTile(
                  title: const Text('getOfflineRegion'),
                  onTap: () async {
                    try {
                      final region =
                          await manager.getOfflineRegion(regionId: 1);
                      _print('offline region: $region');
                    } catch (error, stacktrace) {
                      _print(error.toString());
                      debugPrintStack(stackTrace: stacktrace);
                    }
                  },
                ),
                ListTile(
                  title: const Text('setOfflineTileCountLimit'),
                  onTap: () async {
                    try {
                      manager.setOfflineTileCountLimit(amount: 5000);
                      _print('offline tile count limit set');
                    } catch (error, stacktrace) {
                      _print(error.toString());
                      debugPrintStack(stackTrace: stacktrace);
                    }
                  },
                ),
                ListTile(
                  title: const Text('setMaximumAmbientCacheSize'),
                  onTap: () async {
                    try {
                      await manager.setMaximumAmbientCacheSize(bytes: 10000000);
                      _print('maximum ambient cache size set');
                    } catch (error, stacktrace) {
                      _print(error.toString());
                      debugPrintStack(stackTrace: stacktrace);
                    }
                  },
                ),
                ListTile(
                  title: const Text('clearAmbientCache'),
                  onTap: () async {
                    try {
                      await manager.clearAmbientCache();
                      _print('ambient cache cleared');
                    } catch (error, stacktrace) {
                      _print(error.toString());
                      debugPrintStack(stackTrace: stacktrace);
                    }
                  },
                ),
                ListTile(
                  title: const Text('invalidateAmbientCache'),
                  onTap: () async {
                    try {
                      await manager.invalidateAmbientCache();
                      _print('ambient cache invalidated');
                    } catch (error, stacktrace) {
                      _print(error.toString());
                      debugPrintStack(stackTrace: stacktrace);
                    }
                  },
                ),
                ListTile(
                  title: const Text('listOfflineRegions'),
                  onTap: () async {
                    try {
                      final regions = await manager.listOfflineRegions();
                      _print('offline regions:\n${regions.join('\n')}');
                    } catch (error, stacktrace) {
                      _print(error.toString());
                      debugPrintStack(stackTrace: stacktrace);
                    }
                  },
                ),
                ListTile(
                  title: const Text('packDatabase'),
                  onTap: () async {
                    try {
                      await manager.packDatabase();
                      _print('database optimized');
                    } catch (error, stacktrace) {
                      _print(error.toString());
                      debugPrintStack(stackTrace: stacktrace);
                    }
                  },
                ),
                ListTile(
                  title: const Text('resetDatabase'),
                  onTap: () async {
                    try {
                      await manager.resetDatabase();
                      _print('database reset');
                    } catch (error, stacktrace) {
                      _print(error.toString());
                      debugPrintStack(stackTrace: stacktrace);
                    }
                  },
                ),
                ListTile(
                  title: const Text('runPackDatabaseAutomatically'),
                  onTap: () async {
                    try {
                      manager.runPackDatabaseAutomatically(enabled: true);
                      _print('enable automatic database optimization');
                    } catch (error, stacktrace) {
                      _print(error.toString());
                      debugPrintStack(stackTrace: stacktrace);
                    }
                  },
                ),
                ListTile(
                  title: const Text('downloadRegion'),
                  trailing: Text(_downloadProgress ?? ''),
                  onTap: () async {
                    final stream = manager.downloadRegion(
                      minZoom: 0,
                      maxZoom: 3,
                      bounds: const LngLatBounds(
                        longitudeWest: -180,
                        longitudeEast: 180,
                        latitudeSouth: -90,
                        latitudeNorth: 90,
                      ),
                      mapStyleUrl: StyledMapPage.styleUrl,
                      pixelDensity: 1,
                    );
                    try {
                      await for (final update in stream) {
                        if (update.downloadCompleted) {
                          _print('region downloaded: ${update.region}');
                          setState(() => _downloadProgress = null);
                        } else {
                          setState(() {
                            _downloadProgress =
                            '${update.loadedTiles}/${update.totalTiles} '
                                '(${((update.progress ?? 0) * 100).toStringAsFixed(0)}%)';
                          });
                        }
                      }
                    } catch (error, stacktrace) {
                      _print(error.toString());
                      debugPrintStack(stackTrace: stacktrace);
                      setState(() => _downloadProgress = null);
                    }
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
