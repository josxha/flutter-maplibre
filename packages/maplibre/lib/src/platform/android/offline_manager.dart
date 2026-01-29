import 'dart:async';
import 'dart:convert';

import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/android/extensions.dart';
import 'package:maplibre/src/platform/android/functions.dart';
import 'package:maplibre/src/platform/android/jni.g.dart' as jni;

/// MapLibre Android specific implementation of the [OfflineManager].
class OfflineManagerAndroid implements OfflineManager {
  const OfflineManagerAndroid._(this._jManager);

  final jni.OfflineManager _jManager;

  /// Create a new [OfflineManager].
  static Future<OfflineManager> createInstance() async => using((arena) async {
    final jContext = getJContext();
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
        _MergeOfflineRegionsCallback(WeakReference(completer)),
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
        _GetOfflineRegionCallback(WeakReference(completer)),
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
        _FileSourceCallback(WeakReference(completer)),
      ),
    );
    return completer.future;
  }

  @override
  Future<void> clearAmbientCache() async {
    final completer = Completer<void>();
    _jManager.clearAmbientCache(
      jni.OfflineManager$FileSourceCallback.implement(
        _FileSourceCallback(WeakReference(completer)),
      ),
    );
    return completer.future;
  }

  @override
  Future<void> invalidateAmbientCache() async {
    final completer = Completer<void>();
    _jManager.invalidateAmbientCache(
      jni.OfflineManager$FileSourceCallback.implement(
        _FileSourceCallback(WeakReference(completer)),
      ),
    );
    return completer.future;
  }

  @override
  Future<void> packDatabase() async {
    final completer = Completer<void>();
    _jManager.packDatabase(
      jni.OfflineManager$FileSourceCallback.implement(
        _FileSourceCallback(WeakReference(completer)),
      ),
    );
    return completer.future;
  }

  @override
  Future<void> resetDatabase() async {
    final completer = Completer<void>();
    _jManager.resetDatabase(
      jni.OfflineManager$FileSourceCallback.implement(
        _FileSourceCallback(WeakReference(completer)),
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
        _ListOfflineRegionsCallback(WeakReference(completer)),
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
      JByteArray.from(utf8.encode(metadataJson))..releasedBy(arena),
      jni.OfflineManager$CreateOfflineRegionCallback.implement(
        _CreateOfflineRegionCallback(stream, arena),
      )..releasedBy(arena),
    );
    return stream.stream;
  });
}

final class _MergeOfflineRegionsCallback
    with jni.$OfflineManager$MergeOfflineRegionsCallback {
  const _MergeOfflineRegionsCallback(this.weakCompleter);

  final WeakReference<Completer<List<OfflineRegion>>> weakCompleter;

  @override
  void onError(JString string) {
    weakCompleter.target?.completeError(
      string.toDartString(releaseOriginal: true),
    );
  }

  @override
  void onMerge(JArray<jni.OfflineRegion>? jRegions) => using((arena) {
    if (jRegions == null) {
      weakCompleter.target?.complete([]);
      return;
    }
    jRegions.releasedBy(arena);
    final regions = List.generate(jRegions.length, (index) {
      final jRegion = jRegions[index]..releasedBy(arena);
      return jRegion.toOfflineRegion();
    });
    weakCompleter.target?.complete(regions);
  });

  @override
  bool get onError$async => true;

  @override
  bool get onMerge$async => true;
}

final class _GetOfflineRegionCallback
    with jni.$OfflineManager$GetOfflineRegionCallback {
  const _GetOfflineRegionCallback(this.weakCompleter);

  final WeakReference<Completer<OfflineRegion>> weakCompleter;

  @override
  void onError(JString error) {
    weakCompleter.target?.completeError(
      Exception(error.toDartString(releaseOriginal: true)),
    );
  }

  @override
  void onRegion(jni.OfflineRegion jRegion) {
    weakCompleter.target?.complete(jRegion.toOfflineRegion());
  }

  @override
  void onRegionNotFound() {
    weakCompleter.target?.completeError(Exception('Region not found'));
  }

  @override
  bool get onError$async => true;

  @override
  bool get onRegion$async => true;

  @override
  bool get onRegionNotFound$async => true;
}

final class _FileSourceCallback with jni.$OfflineManager$FileSourceCallback {
  const _FileSourceCallback(this.weakCompleter);

  final WeakReference<Completer<void>> weakCompleter;

  @override
  void onError(JString error) {
    weakCompleter.target?.completeError(
      Exception(error.toDartString(releaseOriginal: true)),
    );
  }

  @override
  void onSuccess() {
    weakCompleter.target?.complete();
  }

  @override
  bool get onError$async => true;

  @override
  bool get onSuccess$async => true;
}

final class _ListOfflineRegionsCallback
    with jni.$OfflineManager$ListOfflineRegionsCallback {
  const _ListOfflineRegionsCallback(this.weakCompleter);

  final WeakReference<Completer<List<OfflineRegion>>> weakCompleter;

  @override
  void onError(JString error) {
    weakCompleter.target?.completeError(
      Exception(error.toDartString(releaseOriginal: true)),
    );
  }

  @override
  void onList(JArray<jni.OfflineRegion>? jRegions) => using((arena) {
    if (jRegions == null) {
      weakCompleter.target?.complete([]);
      return;
    }
    jRegions.releasedBy(arena);
    final regions = List.generate(jRegions.length, (index) {
      final jRegion = jRegions[index]..releasedBy(arena);
      return jRegion.toOfflineRegion();
    });
    weakCompleter.target?.complete(regions);
  });

  @override
  bool get onError$async => true;

  @override
  bool get onList$async => true;
}

final class _CreateOfflineRegionCallback
    with jni.$OfflineManager$CreateOfflineRegionCallback {
  const _CreateOfflineRegionCallback(this.stream, this.arena);

  final StreamController<DownloadProgress> stream;
  final Arena arena;

  @override
  void onCreate(jni.OfflineRegion jRegion) {
    jRegion.releasedBy(arena);
    final jObserver = jni.OfflineRegion$OfflineRegionObserver.implement(
      _OfflineRegionObserver(stream, WeakReference(jRegion), arena),
    )..releasedBy(arena);
    jRegion.setObserver(jObserver);
    jRegion.setDownloadState(jni.OfflineRegion.STATE_ACTIVE);
  }

  @override
  void onError(JString error) => stream.addError(Exception(error));

  @override
  bool get onCreate$async => true;

  @override
  bool get onError$async => true;
}

final class _OfflineRegionObserver
    with jni.$OfflineRegion$OfflineRegionObserver {
  const _OfflineRegionObserver(this.stream, this.weakJRegion, this.arena);

  final StreamController<DownloadProgress> stream;
  final WeakReference<jni.OfflineRegion> weakJRegion;
  final Arena arena;

  @override
  void onStatusChanged(jni.OfflineRegionStatus jStatus) {
    jStatus.releasedBy(arena);
    final region = weakJRegion.target?.toOfflineRegion();
    if (region == null) return;
    if (!stream.isClosed) {
      stream.add(
        DownloadProgress(
          loadedBytes: jStatus.getCompletedResourceSize(),
          loadedTiles: jStatus.getCompletedResourceCount(),
          totalTiles: jStatus.getRequiredResourceCount(),
          totalTilesEstimated: !jStatus.isRequiredResourceCountPrecise(),
          region: region,
          downloadCompleted: jStatus.isComplete(),
        ),
      );
    }

    // end download if status is complete
    if (jStatus.isComplete()) {
      weakJRegion.target?.setDownloadState(jni.OfflineRegion.STATE_INACTIVE);
      // This can be called multiple times, check if already completed
      if (!stream.isClosed) {
        stream.close();
      }
      return;
    }
  }

  @override
  void onError(jni.OfflineRegionError error) {
    error.releasedBy(arena);
    weakJRegion.target?.setDownloadState(jni.OfflineRegion.STATE_INACTIVE);
    stream.addError(
      Exception(error.getMessage().toDartString(releaseOriginal: true)),
    );
  }

  @override
  void mapboxTileCountLimitExceeded(int limit) {
    weakJRegion.target?.setDownloadState(jni.OfflineRegion.STATE_INACTIVE);
    stream.addError(Exception('Tile count limit exceeded: $limit'));
  }

  @override
  bool get onStatusChanged$async => true;

  @override
  bool get onError$async => true;

  @override
  bool get mapboxTileCountLimitExceeded$async => true;
}
