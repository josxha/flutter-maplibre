import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/native/extensions.dart';
import 'package:maplibre/src/native/jni/jni.dart' as jni;

/// MapLibre Android specific implementation of the [OfflineManager].
class OfflineManagerNative implements OfflineManager {
  /// Create a new [OfflineManager].
  OfflineManagerNative() {
    _jContext = jni.MapLibreRegistry.INSTANCE.getContext();
    _jManager = jni.OfflineManager.getInstance(_jContext);
  }

  late final JObject _jContext;
  late final jni.OfflineManager _jManager;

  @override
  void dispose() {
    _jManager.release();
  }

  @override
  Future<List<Object>> mergeOfflineRegions({required String path}) async {
    final jPath = JString.fromString(path);
    final completer = Completer<List<Object>>();
    _jManager.mergeOfflineRegions(
      jPath,
      jni.OfflineManager_MergeOfflineRegionsCallback.implement(
        jni.$OfflineManager_MergeOfflineRegionsCallback(
          onMerge: (jRegions) {
            final list = List.generate(jRegions.length, (index) {
              final jRegion = jRegions[index];
              return jRegion;
            });
            completer.complete(list);
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
  Future<Object> getOfflineRegion({required int regionId}) async {
    final completer = Completer<Object>();
    _jManager.getOfflineRegion(
      regionId,
      jni.OfflineManager_GetOfflineRegionCallback.implement(
        jni.$OfflineManager_GetOfflineRegionCallback(
          onRegion: (region) {
            // TODO map to a public type
            completer.complete(region.getId());
          },
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
  Future<List<Object>> listOfflineRegions() async {
    final completer = Completer<List<Object>>();
    _jManager.listOfflineRegions(
      jni.OfflineManager_ListOfflineRegionsCallback.implement(
        jni.$OfflineManager_ListOfflineRegionsCallback(
          onList: (jRegions) {
            final list = List.generate(jRegions.length, (index) {
              final jRegion = jRegions[index];
              // TODO map to a public type
              return jRegion;
            });
            completer.complete(list);
          },
          onError: (error) => completer.completeError(Exception(error)),
        ),
      ),
    );
    return completer.future;
  }

  @override
  Future<Object> downloadRegion({
    required String mapStyleUrl,
    required LngLatBounds bounds,
    required double minZoom,
    required double maxZoom,
    required double pixelDensity,
    Map<String, Object?> metadata = const {},
  }) async {
    final completer = Completer<Object>();
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
            jRegion.setObserver(
              jni.OfflineRegion_OfflineRegionObserver.implement(
                jni.$OfflineRegion_OfflineRegionObserver(
                  onStatusChanged: (status) {
                    if (status.isComplete()) {
                      jRegion
                          .setDownloadState(jni.OfflineRegion.STATE_INACTIVE);
                      // This can be called multiple times, check if already completed
                      if (!completer.isCompleted) completer.complete(jRegion);
                      return;
                    }

                    final progress = (status.getRequiredResourceCount() > 0)
                        ? status.getCompletedResourceCount() /
                            status.getRequiredResourceCount()
                        : 0;
                    debugPrint('Progress: $progress');
                  },
                  onError: (error) {
                    jRegion.setDownloadState(jni.OfflineRegion.STATE_INACTIVE);
                    completer.completeError(
                      Exception(
                        error.getMessage().toDartString(releaseOriginal: true),
                      ),
                    );
                  },
                  mapboxTileCountLimitExceeded: (limit) {
                    jRegion.setDownloadState(jni.OfflineRegion.STATE_INACTIVE);
                    completer.completeError(
                      Exception('Tile count limit exceeded: $limit'),
                    );
                  },
                ),
              ),
            );
          },
          onError: (error) => completer.completeError(Exception(error)),
        ),
      ),
    );
    jMapStyleUrl.release();
    jBounds.release();
    return completer.future;
  }
}
