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

  late List<_OfflineRegionConfig> _regionConfigs;

  @override
  void initState() {
    super.initState();
    _regionConfigs = [
      _OfflineRegionConfig(
        name: 'World',
        definition: OfflineTilePyramidRegionDefinition(
          bounds: const GeoBox(west: -180, east: 180, south: -90, north: 90),
          styleUrl: MapStyles.protomapsLight.uri,
          minZoom: 0,
          maxZoom: 2,
          pixelRatio: 1,
        ),
      ),
      _OfflineRegionConfig(
        name: 'Bregenz',
        definition: OfflineTilePyramidRegionDefinition(
          bounds: const GeoBox(
            west: 9.589786,
            east: 9.766498,
            south: 47.446159,
            north: 47.574776,
          ),
          styleUrl: MapStyles.protomapsLight.uri,
          minZoom: 10,
          maxZoom: 14,
          pixelRatio: 1,
        ),
      ),
      // A geometry region downloads only the tiles along the route.
      _OfflineRegionConfig(
        name: 'Route Bregenz - Lindau',
        definition: OfflineGeometryRegionDefinition(
          geometry: LineString.from(const [
            Geographic(lon: 9.7471, lat: 47.5031),
            Geographic(lon: 9.7167, lat: 47.5142),
            Geographic(lon: 9.6838, lat: 47.5459),
          ]),
          styleUrl: MapStyles.protomapsLight.uri,
          minZoom: 10,
          maxZoom: 15,
          pixelRatio: 1,
        ),
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
      (config) => config.definition == region.definition,
    );

    if (index != -1) {
      _regionConfigs[index].offlineRegion = region;
      _regionConfigs[index].progress = 1;
    } else {
      _regionConfigs.add(
        _OfflineRegionConfig(
          definition: region.definition,
          offlineRegion: region,
          progress: 1,
          name: 'ID ${region.id}',
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
                        definition: config.definition,
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
                            definition: config.definition,
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
                          final status = await manager.getRegionStatus(
                            regionId: regionId,
                          );
                          _print('offline region: $region, status: $status');
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
    required this.definition,
    required this.name,
    this.offlineRegion,
    this.progress,
    this.metadata = const {},
  });

  OfflineRegionDefinition definition;
  OfflineRegion? offlineRegion;
  double? progress;
  String name;
  Map<String, dynamic> metadata;
}

class _OfflineMapPage extends StatelessWidget {
  const _OfflineMapPage({required this.title, required this.definition});

  final String title;
  final OfflineRegionDefinition definition;

  @override
  Widget build(BuildContext context) {
    final bounds = definition.bounds;
    return Scaffold(
      appBar: AppBar(title: Text('Offline Map "$title"')),
      body: MapLibreMap(
        options: MapOptions(
          style: MapStyle.url(definition.styleUrl),
          maxZoom: 20,
          initCamera: InitialCamera.position(
            center: Geographic(
              lon: (bounds.east + bounds.west) / 2,
              lat: (bounds.north + bounds.south) / 2,
            ),
            zoom: 1,
          ),
        ),
        layers: [
          PolylineLayer(
            color: Colors.red,
            width: 3,
            polylines: [
              Feature(
                geometry: switch (definition) {
                  OfflineGeometryRegionDefinition(
                    geometry: final LineString line,
                  ) =>
                    line,
                  _ => LineString.from([
                    Geographic(lon: bounds.west, lat: bounds.south),
                    Geographic(lon: bounds.west, lat: bounds.north),
                    Geographic(lon: bounds.east, lat: bounds.north),
                    Geographic(lon: bounds.east, lat: bounds.south),
                    Geographic(lon: bounds.west, lat: bounds.south),
                  ]),
                },
              ),
            ],
          ),
        ],
        onMapCreated: (controller) {
          Future.delayed(const Duration(seconds: 1), () {
            controller.fitBounds(
              bounds: bounds,
              padding: const EdgeInsets.all(50),
            );
          });
        },
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
