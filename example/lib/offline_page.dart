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
  String? _downloadProgressWorld;
  String? _downloadProgressBregenz;
  final _boundsWorld = const LngLatBounds(
    longitudeWest: -180,
    longitudeEast: 180,
    latitudeSouth: -90,
    latitudeNorth: 90,
  );
  final _boundsBregenz = const LngLatBounds(
    longitudeWest: 9.589786,
    longitudeEast: 9.766498,
    latitudeSouth: 47.446159,
    latitudeNorth: 47.574776,
  );

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
                  title: const Text('Download World Overview'),
                  trailing: _downloadProgressWorld == null
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                final stream = manager.downloadRegion(
                                  minZoom: 0,
                                  maxZoom: 14,
                                  bounds: _boundsBregenz,
                                  mapStyleUrl: StyledMapPage.styleUrl,
                                  pixelDensity: 1,
                                );
                                try {
                                  await for (final update in stream) {
                                    if (update.downloadCompleted) {
                                      _print(
                                        'region downloaded: ${update.region}',
                                      );
                                      setState(() {
                                        _downloadProgressWorld = null;
                                      });
                                    } else {
                                      setState(() {
                                        _downloadProgressWorld =
                                            '${update.loadedTiles}/${update.totalTiles} '
                                            '(${((update.progress ?? 0) * 100).toStringAsFixed(0)}%)';
                                      });
                                    }
                                  }
                                } catch (error, stacktrace) {
                                  _print(error.toString());
                                  debugPrintStack(stackTrace: stacktrace);
                                  setState(
                                    () => _downloadProgressWorld = null,
                                  );
                                }
                              },
                              icon: const Icon(Icons.download),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (context) => _OfflineMapPage(
                                      title: 'World',
                                      bounds: _boundsWorld,
                                      zoom: 1,
                                      center: Position(0, 0),
                                      maxZoom: 3,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.map),
                            ),
                          ],
                        )
                      : Text(_downloadProgressWorld!),
                ),
                ListTile(
                  title: const Text('Download Bregenz'),
                  trailing: _downloadProgressBregenz == null
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                final stream = manager.downloadRegion(
                                  minZoom: 10,
                                  maxZoom: 14,
                                  bounds: _boundsBregenz,
                                  mapStyleUrl: StyledMapPage.styleUrl,
                                  pixelDensity: 1,
                                );
                                try {
                                  await for (final update in stream) {
                                    if (update.downloadCompleted) {
                                      _print(
                                        'region downloaded: ${update.region}',
                                      );
                                      setState(() {
                                        _downloadProgressBregenz = null;
                                      });
                                    } else {
                                      setState(() {
                                        _downloadProgressBregenz =
                                            '${update.loadedTiles}/${update.totalTiles} '
                                            '(${((update.progress ?? 0) * 100).toStringAsFixed(0)}%)';
                                      });
                                    }
                                  }
                                } catch (error, stacktrace) {
                                  _print(error.toString());
                                  debugPrintStack(stackTrace: stacktrace);
                                  setState(
                                    () => _downloadProgressBregenz = null,
                                  );
                                }
                              },
                              icon: const Icon(Icons.download),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (context) => _OfflineMapPage(
                                      title: 'Bregenz',
                                      bounds: _boundsBregenz,
                                      zoom: 12,
                                      center: Position(9.717795, 47.504100),
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.map),
                            ),
                          ],
                        )
                      : Text(_downloadProgressBregenz!),
                ),
                ListTile(
                  title: const Text('Merge Offline Regions'),
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
                  title: const Text('Get Offline Region'),
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
                  title: const Text('Set Offline Tile Count Limit'),
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
                  title: const Text('Set Maximum Ambient Cache Size'),
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
                  title: const Text('Clear Ambient Cache'),
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
                  title: const Text('Invalidate Ambient Cache'),
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
                  title: const Text('List Offline Regions'),
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
                  title: const Text('Pack Database'),
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
                  title: const Text('Reset Database'),
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
                  title: const Text('Run Pack Database Automatically'),
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

class _OfflineMapPage extends StatelessWidget {
  const _OfflineMapPage({
    required this.title,
    required this.bounds,
    required this.center,
    required this.zoom,
    this.maxZoom = 20,
  });

  final String title;
  final LngLatBounds bounds;
  final Position center;
  final double zoom;
  final double maxZoom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Offline Map "$title"')),
      body: MapLibreMap(
        options: MapOptions(
          initStyle: StyledMapPage.styleUrl,
          maxBounds: bounds,
          initCenter: center,
          initZoom: zoom,
          maxZoom: maxZoom,
        ),
        layers: [
          PolylineAnnotationLayer(
            color: Colors.red,
            width: 3,
            polylines: [
              LineString(
                coordinates: [
                  Position(bounds.longitudeWest, bounds.latitudeSouth),
                  Position(bounds.longitudeWest, bounds.latitudeNorth),
                  Position(bounds.longitudeEast, bounds.latitudeNorth),
                  Position(bounds.longitudeEast, bounds.latitudeSouth),
                  Position(bounds.longitudeWest, bounds.latitudeSouth),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
