import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_example/utils/map_styles.dart';

@immutable
class OfflinePage extends StatefulWidget {
  const OfflinePage({super.key});

  static const location = '/offline';

  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  late Future<OfflineManager> _futureOfflineManager;

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

  late List<_OfflineRegionConfig> _regionConfigs;

  @override
  void initState() {
    super.initState();
    _regionConfigs = [
      _OfflineRegionConfig(
        bounds: _boundsWorld,
        name: 'World',
        mapStyleUrl: MapStyles.protomapsLight.uri,
        maxZoom: 2,
        pixelDensity: 1,
      ),
      _OfflineRegionConfig(
        bounds: _boundsBregenz,
        name: 'Bregenz',
        mapStyleUrl: MapStyles.protomapsLight.uri,
        minZoom: 10,
        maxZoom: 14,
        pixelDensity: 1,
      ),
    ];

    _futureOfflineManager = _initOfflineManager();
  }

  Future<OfflineManager> _initOfflineManager() async {
    final manager = await OfflineManager.createInstance();

    final regions = await manager.listOfflineRegions();
    regions.forEach(_mergeRegion);

    return manager;
  }

  void _mergeRegion(OfflineRegion region) {
    final index = _regionConfigs.indexWhere(
      (config) => config.bounds == region.bounds,
    );

    if (index != -1) {
      _regionConfigs[index].offlineRegion = region;
      _regionConfigs[index].progress = 1;
    } else {
      _regionConfigs.add(
        _OfflineRegionConfig(
          bounds: region.bounds,
          offlineRegion: region,
          progress: 1,
          name: 'ID ${region.id}',
          mapStyleUrl: region.styleUrl,
          minZoom: region.minZoom,
          maxZoom: region.maxZoom,
          metadata: region.metadata,
        ),
      );
    }
  }

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
                ..._regionConfigs.map(
                  (config) => _OfflineRegionTile(
                    regionConfig: config,
                    onDelete: () {
                      if (config.offlineRegion?.id case final int regionId) {
                        manager.deleteRegion(regionId: regionId);
                        _print('region $regionId deleted');
                        setState(() {
                          config.offlineRegion = null;
                          config.progress = null;
                        });
                      }
                    },
                    onDownload: () {
                      final stream = manager.downloadRegion(
                        minZoom: config.minZoom,
                        maxZoom: config.maxZoom,
                        bounds: config.bounds,
                        mapStyleUrl: config.mapStyleUrl,
                        pixelDensity: config.pixelDensity ?? 1,
                        metadata: config.metadata,
                      );
                      try {
                        stream.listen((update) {
                          if (!mounted) return;
                          if (update.downloadCompleted) {
                            _print('region downloaded: ${update.region}');
                            setState(() {
                              config.progress = 1;
                              config.offlineRegion = update.region;
                            });
                          } else {
                            setState(() {
                              config.progress =
                                  update.progress ?? config.progress ?? 0;
                            });
                          }
                        });
                      } on Exception catch (error, stacktrace) {
                        _print(error.toString());
                        debugPrintStack(stackTrace: stacktrace);
                      }
                    },
                    onShowOnMap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) => _OfflineMapPage(
                            title: config.name,
                            bounds: config.bounds,
                            zoom: 1,
                          ),
                        ),
                      );
                    },
                    onInfo: () async {
                      if (config.offlineRegion?.id case final int regionId) {
                        try {
                          final region = await manager.getOfflineRegion(
                            regionId: regionId,
                          );
                          _print('offline region: $region');
                        } on Exception catch (error, stacktrace) {
                          _print(error.toString());
                          debugPrintStack(stackTrace: stacktrace);
                        }
                      }
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Get Offline Region'),
                  onTap: () async {
                    try {
                      final region = await manager.getOfflineRegion(
                        regionId: 1,
                      );
                      _print('offline region: $region');
                    } on Exception catch (error, stacktrace) {
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
                    } on Exception catch (error, stacktrace) {
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
                    } on Exception catch (error, stacktrace) {
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
                    } on Exception catch (error, stacktrace) {
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
                    } on Exception catch (error, stacktrace) {
                      _print(error.toString());
                      debugPrintStack(stackTrace: stacktrace);
                    }
                  },
                ),
                if (!Platform.isIOS)
                  ListTile(
                    title: const Text('Pack Database'),
                    onTap: () async {
                      try {
                        await manager.packDatabase();
                        _print('database optimized');
                      } on Exception catch (error, stacktrace) {
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
                    } on Exception catch (error, stacktrace) {
                      _print(error.toString());
                      debugPrintStack(stackTrace: stacktrace);
                    }
                  },
                ),
                if (!Platform.isIOS)
                  ListTile(
                    title: const Text('Run Pack Database Automatically'),
                    onTap: () async {
                      try {
                        manager.runPackDatabaseAutomatically(enabled: true);
                        _print('enable automatic database optimization');
                      } on Exception catch (error, stacktrace) {
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

class _OfflineRegionConfig {
  _OfflineRegionConfig({
    required this.bounds,
    required this.name,
    required this.mapStyleUrl,
    this.offlineRegion,
    this.progress,
    this.minZoom = 0,
    this.maxZoom = 20,
    this.pixelDensity,
    this.metadata = const {},
  });

  LngLatBounds bounds;
  OfflineRegion? offlineRegion;
  double? progress;
  String name;
  double minZoom = 0;
  double maxZoom = 20;
  double? pixelDensity;
  String mapStyleUrl;
  Map<String, dynamic> metadata;
}

class _OfflineMapPage extends StatelessWidget {
  const _OfflineMapPage({
    required this.title,
    required this.bounds,
    required this.zoom,
  });

  final String title;
  final LngLatBounds bounds;
  final double zoom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Offline Map "$title"')),
      body: MapLibreMap(
        options: MapOptions(
          initStyle: MapStyles.protomapsLight.uri,
          maxBounds: bounds,
          initCenter: Geographic(
            lon: (bounds.longitudeEast + bounds.longitudeWest) / 2,
            lat: (bounds.latitudeNorth + bounds.latitudeSouth) / 2,
          ),
          initZoom: zoom,
          maxZoom: 20,
        ),
        layers: [
          PolylineLayer(
            color: Colors.red,
            width: 3,
            polylines: [
              Feature(
                geometry: LineString.from([
                  Geographic(
                    lon: bounds.longitudeWest,
                    lat: bounds.latitudeSouth,
                  ),
                  Geographic(
                    lon: bounds.longitudeWest,
                    lat: bounds.latitudeNorth,
                  ),
                  Geographic(
                    lon: bounds.longitudeEast,
                    lat: bounds.latitudeNorth,
                  ),
                  Geographic(
                    lon: bounds.longitudeEast,
                    lat: bounds.latitudeSouth,
                  ),
                  Geographic(
                    lon: bounds.longitudeWest,
                    lat: bounds.latitudeSouth,
                  ),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OfflineRegionTile extends StatelessWidget {
  const _OfflineRegionTile({
    required this.regionConfig,
    this.onDownload,
    this.onShowOnMap,
    this.onDelete,
    this.onInfo,
  });

  final _OfflineRegionConfig regionConfig;
  final VoidCallback? onDownload;
  final VoidCallback? onShowOnMap;
  final VoidCallback? onDelete;
  final VoidCallback? onInfo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Region: ${regionConfig.name}'),
      subtitle: _subtitle(),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: _actions()),
    );
  }

  Widget? _subtitle() {
    if (regionConfig.progress != null) {
      if (regionConfig.progress == 1) {
        return const Text('Downloaded');
      }
      return Text(
        'Progress: ${(regionConfig.progress! * 100).toStringAsFixed(0)}%',
      );
    }

    return const Text('Ready to download');
  }

  List<Widget> _actions() {
    final buttons = <Widget>[];
    if (regionConfig.offlineRegion?.id != null && onInfo != null) {
      buttons.add(IconButton(onPressed: onInfo, icon: const Icon(Icons.info)));
    }
    if (onShowOnMap != null) {
      buttons.add(
        IconButton(onPressed: onShowOnMap, icon: const Icon(Icons.map)),
      );
    }
    if (regionConfig.offlineRegion?.id != null && onDelete != null) {
      buttons.add(
        IconButton(onPressed: onDelete, icon: const Icon(Icons.delete)),
      );
    }
    if (regionConfig.progress == null && onDownload != null) {
      buttons.add(
        IconButton(onPressed: onDownload, icon: const Icon(Icons.download)),
      );
    }
    return buttons;
  }
}
