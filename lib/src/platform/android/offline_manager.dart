import 'dart:async';
import 'dart:convert';

import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/android/extensions.dart';
import 'package:maplibre/src/platform/android/functions.dart';
import 'package:maplibre/src/platform/android/jni.dart' as jni;

/// MapLibre Android specific implementation of the [OfflineManager].
class OfflineManagerAndroid implements OfflineManager {
  const OfflineManagerAndroid._(this._jManager);

  final jni.OfflineManager _jManager;

  /// Create a new [OfflineManager].
  static Future<OfflineManager> createInstance() async => using((arena) async {
    final jContext = getJContext(arena);
    jni.MapLibre.getInstance(jContext);
    final jManager = jni.OfflineManager.getInstance(jContext);
    return OfflineManagerAndroid._(jManager);
  });

  @override
  void dispose() {
    _jManager.release();
  }

  @override
  Future<List<OfflineRegion>> mergeOfflineRegions({
    required String path,
  }) async => using((arena) async {
    final completer = Completer<List<OfflineRegion>>();
    _jManager.mergeOfflineRegions(
      path.toJString()..releasedBy(arena),
      jni.OfflineManager$MergeOfflineRegionsCallback.implement(
        jni.$OfflineManager$MergeOfflineRegionsCallback(
          onMerge: (jRegions) {
            if (jRegions == null) {
              completer.complete([]);
              return;
            }
            final regions = List.generate(
              jRegions.length,
              (index) => jRegions[index].toOfflineRegion(),
            );
            completer.complete(regions);
          },
          onError: (error) => completer.completeError(
            error.toDartString(releaseOriginal: true),
          ),
          onError$async: true,
          onMerge$async: true,
        ),
      ),
    );
    return completer.future;
  });

  @override
  Future<OfflineRegion> getOfflineRegion({required int regionId}) async {
    final completer = Completer<OfflineRegion>();
    _jManager.getOfflineRegion(
      regionId,
      jni.OfflineManager$GetOfflineRegionCallback.implement(
        jni.$OfflineManager$GetOfflineRegionCallback(
          onRegion: (region) => completer.complete(region.toOfflineRegion()),
          onRegionNotFound: () {
            completer.completeError(Exception('Region not found'));
          },
          onError: (error) {
            completer.completeError(
              Exception(error.toDartString(releaseOriginal: true)),
            );
          },
          onError$async: true,
          onRegion$async: true,
          onRegionNotFound$async: true,
        ),
      ),
    );
    return completer.future;
  }

  @override
  void setOfflineTileCountLimit({required int amount}) =>
      _jManager.setOfflineMapboxTileCountLimit(amount);

  @override
  Future<void> setMaximumAmbientCacheSize({required int bytes}) async {
    final completer = Completer<void>();
    _jManager.setMaximumAmbientCacheSize(
      bytes,
      jni.OfflineManager$FileSourceCallback.implement(
        jni.$OfflineManager$FileSourceCallback(
          onSuccess: completer.complete,
          onError: (error) => completer.completeError(Exception(error)),
          onError$async: true,
          onSuccess$async: true,
        ),
      ),
    );
    return completer.future;
  }

  @override
  Future<void> clearAmbientCache() async {
    final completer = Completer<void>();
    _jManager.clearAmbientCache(
      jni.OfflineManager$FileSourceCallback.implement(
        jni.$OfflineManager$FileSourceCallback(
          onSuccess: completer.complete,
          onError: (error) => completer.completeError(Exception(error)),
          onError$async: true,
          onSuccess$async: true,
        ),
      ),
    );
    return completer.future;
  }

  @override
  Future<void> invalidateAmbientCache() async {
    final completer = Completer<void>();
    _jManager.invalidateAmbientCache(
      jni.OfflineManager$FileSourceCallback.implement(
        jni.$OfflineManager$FileSourceCallback(
          onSuccess: completer.complete,
          onError: (error) => completer.completeError(Exception(error)),
          onSuccess$async: true,
          onError$async: true,
        ),
      ),
    );
    return completer.future;
  }

  @override
  Future<void> packDatabase() async {
    final completer = Completer<void>();
    _jManager.packDatabase(
      jni.OfflineManager$FileSourceCallback.implement(
        jni.$OfflineManager$FileSourceCallback(
          onSuccess: completer.complete,
          onError: (error) => completer.completeError(Exception(error)),
          onSuccess$async: true,
          onError$async: true,
        ),
      ),
    );
    return completer.future;
  }

  @override
  Future<void> resetDatabase() async {
    final completer = Completer<void>();
    _jManager.resetDatabase(
      jni.OfflineManager$FileSourceCallback.implement(
        jni.$OfflineManager$FileSourceCallback(
          onSuccess: completer.complete,
          onError: (error) => completer.completeError(Exception(error)),
          onSuccess$async: true,
          onError$async: true,
        ),
      ),
    );
    return completer.future;
  }

  @override
  void runPackDatabaseAutomatically({required bool enabled}) =>
      _jManager.runPackDatabaseAutomatically(enabled);

  @override
  Future<List<OfflineRegion>> listOfflineRegions() async {
    final completer = Completer<List<OfflineRegion>>();
    _jManager.listOfflineRegions(
      jni.OfflineManager$ListOfflineRegionsCallback.implement(
        jni.$OfflineManager$ListOfflineRegionsCallback(
          onList: (jRegions) {
            if (jRegions == null) {
              completer.complete([]);
              return;
            }
            final list = List.generate(
              jRegions.length,
              (index) => jRegions[index].toOfflineRegion(),
            );
            completer.complete(list);
          },
          onError: (error) => completer.completeError(Exception(error)),
          onError$async: true,
          onList$async: true,
        ),
      ),
    );
    return completer.future;
  }

  @override
  Stream<DownloadProgress> downloadRegion({
    required String mapStyleUrl,
    required LngLatBounds bounds,
    required double minZoom,
    required double maxZoom,
    required double pixelDensity,
    Map<String, Object?> metadata = const {},
  }) => using((arena) {
    final stream = StreamController<DownloadProgress>();
    final jDefinition = jni.OfflineTilePyramidRegionDefinition(
      mapStyleUrl.toJString()..releasedBy(arena),
      bounds.toJLatLngBounds(arena: arena),
      minZoom,
      maxZoom,
      pixelDensity,
    );

    // convert the Map to a Java byte Array
    final metadataJson = jsonEncode(metadata);

    _jManager.createOfflineRegion(
      jDefinition.as(jni.OfflineRegionDefinition.type)..releasedBy(arena),
      JByteArray.from(utf8.encode(metadataJson))
        ..releasedBy(arena),
      jni.OfflineManager$CreateOfflineRegionCallback.implement(
        jni.$OfflineManager$CreateOfflineRegionCallback(
          onCreate: (jRegion) {
            jRegion.releasedBy(arena);
            final region = jRegion.toOfflineRegion();
            final jObserver = jni.OfflineRegion$OfflineRegionObserver.implement(
              jni.$OfflineRegion$OfflineRegionObserver(
                onStatusChanged: (status) {
                  status.releasedBy(arena);
                  if (!stream.isClosed) {
                    stream.add(
                      DownloadProgress(
                        loadedBytes: status.getCompletedResourceSize(),
                        loadedTiles: status.getCompletedResourceCount(),
                        totalTiles: status.getRequiredResourceCount(),
                        totalTilesEstimated: !status
                            .isRequiredResourceCountPrecise(),
                        region: region,
                        downloadCompleted: status.isComplete(),
                      ),
                    );
                  }

                  // end download if status is complete
                  if (status.isComplete()) {
                    jRegion.setDownloadState(jni.OfflineRegion.STATE_INACTIVE);
                    // This can be called multiple times, check if already completed
                    if (!stream.isClosed) {
                      stream.close();
                    }
                    return;
                  }
                },
                onError: (error) {
                  jRegion.setDownloadState(jni.OfflineRegion.STATE_INACTIVE);
                  stream.addError(
                    Exception(
                      error.getMessage().toDartString(releaseOriginal: true),
                    ),
                  );
                },
                mapboxTileCountLimitExceeded: (limit) {
                  jRegion.setDownloadState(jni.OfflineRegion.STATE_INACTIVE);
                  stream.addError(
                    Exception('Tile count limit exceeded: $limit'),
                  );
                },
                onError$async: true,
                mapboxTileCountLimitExceeded$async: true,
                onStatusChanged$async: true,
              ),
            )..releasedBy(arena);
            jRegion.setObserver(jObserver);
            jRegion.setDownloadState(jni.OfflineRegion.STATE_ACTIVE);
          },
          onError: (error) => stream.addError(Exception(error)),
          onError$async: true,
          onCreate$async: true,
        ),
      )..releasedBy(arena),
    );
    return stream.stream;
  });
}
