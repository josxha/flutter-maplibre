import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/android/extensions.dart';
import 'package:maplibre/src/platform/android/jni/jni.dart' as jni;

/// MapLibre Android specific implementation of the [OfflineManager].
class OfflineManagerAndroid implements OfflineManager {
  const OfflineManagerAndroid._(this._jManager);

  final jni.OfflineManager _jManager;

  /// Create a new [OfflineManager].
  static Future<OfflineManager> createInstance() async {
    final jContext = jni.MapLibreRegistry.INSTANCE.getContext();
    await runOnPlatformThread(() {
      jni.MapLibre.getInstance(jContext);
    });
    final jManager = jni.OfflineManager.getInstance(jContext);
    return OfflineManagerAndroid._(jManager);
  }

  @override
  void dispose() {
    _jManager.release();
  }

  @override
  Future<List<OfflineRegion>> mergeOfflineRegions({
    required String path,
  }) async {
    final jPath = JString.fromString(path);
    final completer = Completer<List<OfflineRegion>>();
    _jManager.mergeOfflineRegions(
      jPath,
      jni.OfflineManager_MergeOfflineRegionsCallback.implement(
        jni.$OfflineManager_MergeOfflineRegionsCallback(
          onMerge: (jRegions) {
            final regions = List.generate(
              jRegions.length,
              (index) => jRegions[index].toOfflineRegion(),
            );
            completer.complete(regions);
          },
          onError: (error) => completer
              .completeError(error.toDartString(releaseOriginal: true)),
        ),
      ),
    );
    jPath.release();
    return completer.future;
  }

  @override
  Future<OfflineRegion> getOfflineRegion({required int regionId}) async {
    final completer = Completer<OfflineRegion>();
    _jManager.getOfflineRegion(
      regionId,
      jni.OfflineManager_GetOfflineRegionCallback.implement(
        jni.$OfflineManager_GetOfflineRegionCallback(
          onRegion: (region) => completer.complete(region.toOfflineRegion()),
          onRegionNotFound: () {
            completer.completeError(Exception('Region not found'));
          },
          onError: (error) {
            completer.completeError(
              Exception(error.toDartString(releaseOriginal: true)),
            );
          },
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
      jni.OfflineManager_FileSourceCallback.implement(
        jni.$OfflineManager_FileSourceCallback(
          onSuccess: completer.complete,
          onError: (error) => completer.completeError(Exception(error)),
        ),
      ),
    );
    return completer.future;
  }

  @override
  Future<void> clearAmbientCache() async {
    final completer = Completer<void>();
    _jManager.clearAmbientCache(
      jni.OfflineManager_FileSourceCallback.implement(
        jni.$OfflineManager_FileSourceCallback(
          onSuccess: completer.complete,
          onError: (error) => completer.completeError(Exception(error)),
        ),
      ),
    );
    return completer.future;
  }

  @override
  Future<void> invalidateAmbientCache() async {
    final completer = Completer<void>();
    _jManager.invalidateAmbientCache(
      jni.OfflineManager_FileSourceCallback.implement(
        jni.$OfflineManager_FileSourceCallback(
          onSuccess: completer.complete,
          onError: (error) => completer.completeError(Exception(error)),
        ),
      ),
    );
    return completer.future;
  }

  @override
  Future<void> packDatabase() async {
    final completer = Completer<void>();
    _jManager.packDatabase(
      jni.OfflineManager_FileSourceCallback.implement(
        jni.$OfflineManager_FileSourceCallback(
          onSuccess: completer.complete,
          onError: (error) => completer.completeError(Exception(error)),
        ),
      ),
    );
    return completer.future;
  }

  @override
  Future<void> resetDatabase() async {
    final completer = Completer<void>();
    _jManager.resetDatabase(
      jni.OfflineManager_FileSourceCallback.implement(
        jni.$OfflineManager_FileSourceCallback(
          onSuccess: completer.complete,
          onError: (error) => completer.completeError(Exception(error)),
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
      jni.OfflineManager_ListOfflineRegionsCallback.implement(
        jni.$OfflineManager_ListOfflineRegionsCallback(
          onList: (jRegions) {
            final list = List.generate(
              jRegions.length,
              (index) => jRegions[index].toOfflineRegion(),
            );
            completer.complete(list);
          },
          onError: (error) => completer.completeError(Exception(error)),
        ),
      ),
    );
    return completer.future;
  }

  @override
  Stream<DownloadProgress> downloadRegion({
    required String mapStyleUrl,
    required BBox bounds,
    required double minZoom,
    required double maxZoom,
    required double pixelDensity,
    Map<String, Object?> metadata = const {},
  }) {
    final stream = StreamController<DownloadProgress>();
    final jMapStyleUrl = mapStyleUrl.toJString();
    final jBounds = bounds.toLatLngBounds();
    final jDefinition = jni.OfflineTilePyramidRegionDefinition(
      jMapStyleUrl,
      jBounds,
      minZoom,
      maxZoom,
      pixelDensity,
    );

    // convert the Map to a Java byte Array
    final metadataJson = jsonEncode(metadata);
    final metadataBytes = utf8.encode(metadataJson);
    final jMetadata = JArray(jbyte.type, metadataBytes.length);
    for (var i = 0; i < metadataBytes.length; i++) {
      jMetadata[i] = metadataBytes[i];
    }

    _jManager.createOfflineRegion(
      jDefinition.as(jni.OfflineRegionDefinition.type),
      jMetadata,
      jni.OfflineManager_CreateOfflineRegionCallback.implement(
        jni.$OfflineManager_CreateOfflineRegionCallback(
          onCreate: (jRegion) {
            final region = jRegion.toOfflineRegion();
            final jObserver = jni.OfflineRegion_OfflineRegionObserver.implement(
              jni.$OfflineRegion_OfflineRegionObserver(
                onStatusChanged: (status) {
                  // send update to stream
                  if (!stream.isClosed) {
                    stream.add(
                      DownloadProgress(
                        loadedBytes: status.getCompletedResourceSize(),
                        loadedTiles: status.getCompletedResourceCount(),
                        totalTiles: status.getRequiredResourceCount(),
                        totalTilesEstimated:
                            !status.isRequiredResourceCountPrecise(),
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
              ),
            );
            jRegion.setObserver(jObserver);
            jRegion.setDownloadState(jni.OfflineRegion.STATE_ACTIVE);
          },
          onError: (error) => stream.addError(Exception(error)),
        ),
      ),
    );
    jMapStyleUrl.release();
    jBounds.release();
    return stream.stream;
  }
}
