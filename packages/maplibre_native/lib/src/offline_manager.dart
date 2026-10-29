import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:geobase/geobase.dart' show GeometryBuilder;
import 'package:maplibre_native/src/database.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart' as mln;
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

final mln.RuntimeEventFlag _offlineEvents =
    mln.RuntimeEventFlag.offlineRegionStatusChanged |
    mln.RuntimeEventFlag.offlineRegionResponseError |
    mln.RuntimeEventFlag.offlineRegionTileCountLimitExceeded;

/// The [OfflineManager] of maplibre_native, over the offline regions of the
/// C API in the database that every map caches its resources in.
///
/// It owns a runtime of its own, which renders no map. Downloads report
/// their progress through that runtime's events.
final class OfflineManagerNative implements OfflineManager {
  OfflineManagerNative._(this._runtime);

  /// Creates an offline manager on the shared database.
  static Future<OfflineManagerNative> create() async {
    final runtime = await createRuntime();
    final manager = OfflineManagerNative._(runtime);
    try {
      await runtime.setEventHandler(manager._onEvents);
      // The runtime renders no map, so it queues only offline events.
      runtime.setEventMask(_offlineEvents);
    } on Object {
      await runtime.close();
      rethrow;
    }
    return manager;
  }

  final mln.RuntimeHandle _runtime;

  /// The downloads in progress, by region id.
  final _downloads = <int, _Download>{};

  var _disposed = false;

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    for (final download in _downloads.values.toList()) {
      unawaited(download.controller.close());
    }
    _downloads.clear();
    unawaited(_runtime.close());
  }

  @override
  Future<List<OfflineRegion>> listOfflineRegions() async =>
      (await _runtime.listOfflineRegions()).map(toOfflineRegion).toList();

  @override
  Future<OfflineRegion?> getOfflineRegion({required int regionId}) async {
    final info = await _runtime.getOfflineRegion(regionId);
    return info == null ? null : toOfflineRegion(info);
  }

  @override
  Future<List<OfflineRegion>> mergeOfflineRegions({
    required String path,
  }) async =>
      (await _runtime.mergeOfflineRegions(path)).map(toOfflineRegion).toList();

  @override
  Future<OfflineRegion> updateRegionMetadata({
    required int regionId,
    required Map<String, Object?> metadata,
  }) async => toOfflineRegion(
    await _runtime.updateOfflineRegionMetadata(
      regionId,
      encodeRegionMetadata(metadata),
    ),
  );

  @override
  Future<void> deleteRegion({required int regionId}) async {
    await _stopDownload(regionId);
    await _runtime.deleteOfflineRegion(regionId);
  }

  @override
  Future<void> invalidateRegion({required int regionId}) =>
      _runtime.invalidateOfflineRegion(regionId);

  @override
  Future<void> setMaximumAmbientCacheSize({required int bytes}) =>
      _runtime.setMaximumAmbientCacheSize(bytes);

  @override
  Future<void> clearAmbientCache() =>
      _runtime.runAmbientCacheOperation(mln.AmbientCacheOperation.clear);

  @override
  Future<void> invalidateAmbientCache() =>
      _runtime.runAmbientCacheOperation(mln.AmbientCacheOperation.invalidate);

  @override
  Future<void> packDatabase() =>
      _runtime.runAmbientCacheOperation(mln.AmbientCacheOperation.packDatabase);

  @override
  Future<void> resetDatabase() async {
    for (final regionId in _downloads.keys.toList()) {
      await _stopDownload(regionId);
    }
    await _runtime.runAmbientCacheOperation(
      mln.AmbientCacheOperation.resetDatabase,
    );
  }

  @override
  Future<OfflineRegionStatus> getRegionStatus({required int regionId}) async =>
      toRegionStatus(await _runtime.getOfflineRegionStatus(regionId));

  @override
  Stream<DownloadProgress> downloadRegion({
    required OfflineRegionDefinition definition,
    Map<String, Object?> metadata = const {},
  }) => _download(() async {
    final info = await _runtime.createOfflineRegion(
      toNativeDefinition(definition),
      encodeRegionMetadata(metadata),
    );
    return toOfflineRegion(info);
  });

  @override
  Stream<DownloadProgress> resumeDownload({required int regionId}) =>
      _download(() async {
        final region = await getOfflineRegion(regionId: regionId);
        if (region == null) {
          throw ArgumentError.value(regionId, 'regionId', 'No such region');
        }
        return region;
      });

  /// Downloads the region that [region] returns, reporting its progress
  /// from the region's status events until it completes or the
  /// subscription is cancelled.
  Stream<DownloadProgress> _download(Future<OfflineRegion> Function() region) {
    late final StreamController<DownloadProgress> controller;
    _Download? download;
    controller = StreamController<DownloadProgress>(
      onListen: () async {
        try {
          if (_disposed) throw StateError('The OfflineManager is disposed.');
          final started = await region();
          if (controller.isClosed) return;
          final id = started.id;
          await _stopDownload(id);
          download = _downloads[id] = _Download(started, controller);
          await _runtime.setOfflineRegionObserved(id, true);
          await _runtime.setOfflineRegionDownloadState(
            id,
            mln.OfflineRegionDownloadState.active,
          );
        } on Object catch (error, stackTrace) {
          if (controller.isClosed) return;
          controller.addError(error, stackTrace);
          await controller.close();
        }
      },
      onCancel: () async {
        final active = download;
        if (active != null) await _stopDownload(active.region.id);
      },
    );
    return controller.stream;
  }

  /// Stops the download of [regionId], if there is one, and closes its
  /// stream.
  Future<void> _stopDownload(int regionId) async {
    final download = _downloads.remove(regionId);
    if (download == null) return;
    unawaited(download.controller.close());
    if (_disposed) return;
    try {
      await _runtime.setOfflineRegionDownloadState(
        regionId,
        mln.OfflineRegionDownloadState.inactive,
      );
      await _runtime.setOfflineRegionObserved(regionId, false);
    } on mln.MaplibreException {
      // The region was deleted meanwhile, which stopped its download.
    }
  }

  void _onEvents(List<mln.RuntimeEvent> events) {
    if (_disposed) return;
    for (final event in events) {
      switch (event.payload) {
        case mln.RuntimeEventPayloadOfflineRegionStatus(:final value):
          final download = _downloads[value.regionId];
          if (download == null) continue;
          final progress = DownloadProgress(
            region: download.region,
            status: toRegionStatus(value.status),
          );
          download.controller.add(progress);
          if (progress.downloadCompleted) {
            unawaited(_stopDownload(value.regionId));
          }
        case mln.RuntimeEventPayloadOfflineRegionResponseError(:final value):
          _downloads[value.regionId]?.controller.addError(
            OfflineResourceException(
              regionId: value.regionId,
              reason: _toErrorReason(value.reason),
              details: event.message,
            ),
          );
        case mln.RuntimeEventPayloadOfflineRegionTileCountLimit(:final value):
          final download = _downloads[value.regionId];
          if (download == null) continue;
          download.controller.addError(
            OfflineTileCountLimitException(
              regionId: value.regionId,
              limit: value.limit,
            ),
          );
          unawaited(_stopDownload(value.regionId));
        default:
      }
    }
  }
}

/// A download in progress and the stream that reports it.
final class _Download {
  _Download(this.region, this.controller);

  final OfflineRegion region;
  final StreamController<DownloadProgress> controller;
}

/// Encodes region metadata as UTF-8 JSON, which keeps characters outside
/// ASCII (#581).
Uint8List encodeRegionMetadata(Map<String, Object?> metadata) =>
    utf8.encode(jsonEncode(metadata));

/// Decodes region metadata, which regions from other databases may store as
/// anything but a JSON object.
Map<String, Object?> decodeRegionMetadata(Uint8List bytes) {
  if (bytes.isEmpty) return const {};
  try {
    final value = jsonDecode(utf8.decode(bytes));
    if (value is Map<String, Object?>) return value;
  } on FormatException {
    // Not JSON.
  }
  return const {};
}

/// The status of the C API as an [OfflineRegionStatus].
OfflineRegionStatus toRegionStatus(mln.OfflineRegionStatus status) =>
    OfflineRegionStatus(
      downloadState:
          status.downloadState == mln.OfflineRegionDownloadState.active
          ? OfflineRegionDownloadState.active
          : OfflineRegionDownloadState.inactive,
      completedResourceCount: status.completedResourceCount,
      completedResourceSize: status.completedResourceSize,
      completedTileCount: status.completedTileCount,
      completedTileSize: status.completedTileSize,
      requiredResourceCount: status.requiredResourceCount,
      requiredTileCount: status.requiredTileCount,
      requiredResourceCountIsPrecise: status.requiredResourceCountIsPrecise,
      complete: status.complete,
    );

OfflineResourceErrorReason _toErrorReason(mln.ResourceErrorReason reason) =>
    switch (reason) {
      mln.ResourceErrorReason.notFound => OfflineResourceErrorReason.notFound,
      mln.ResourceErrorReason.server => OfflineResourceErrorReason.server,
      mln.ResourceErrorReason.connection =>
        OfflineResourceErrorReason.connection,
      mln.ResourceErrorReason.rateLimit => OfflineResourceErrorReason.rateLimit,
      _ => OfflineResourceErrorReason.other,
    };

mln.LatLngBounds _toNativeBounds(GeoBox bounds) => mln.LatLngBounds(
  southwest: mln.LatLng(latitude: bounds.south, longitude: bounds.west),
  northeast: mln.LatLng(latitude: bounds.north, longitude: bounds.east),
);

/// The region definition of the C API for [definition].
mln.OfflineRegionDefinition toNativeDefinition(
  OfflineRegionDefinition definition,
) => switch (definition) {
  OfflineTilePyramidRegionDefinition() =>
    mln.OfflineRegionDefinition.tilePyramid(
      mln.OfflineTilePyramidRegionDefinition(
        styleUrl: definition.styleUrl,
        bounds: _toNativeBounds(definition.bounds),
        minZoom: definition.minZoom,
        maxZoom: definition.maxZoom,
        pixelRatio: definition.pixelRatio,
        includeIdeographs: definition.includeIdeographs,
      ),
    ),
  OfflineGeometryRegionDefinition() => mln.OfflineRegionDefinition.geometry(
    mln.OfflineGeometryRegionDefinition(
      styleUrl: definition.styleUrl,
      geometry: jsonDecode(definition.geometry.toText()),
      minZoom: definition.minZoom,
      maxZoom: definition.maxZoom,
      pixelRatio: definition.pixelRatio,
      includeIdeographs: definition.includeIdeographs,
    ),
  ),
};

/// The [OfflineRegion] of a region of the C API.
OfflineRegion toOfflineRegion(mln.OfflineRegionInfo info) => OfflineRegion(
  id: info.id,
  definition: switch (info.definition) {
    mln.OfflineRegionDefinitionUnknown(:final tag) => throw UnsupportedError(
      'Offline region ${info.id} has a definition of unknown type $tag.',
    ),
    mln.OfflineRegionDefinitionTilePyramid(:final value) =>
      OfflineTilePyramidRegionDefinition(
        bounds: GeoBox(
          west: value.bounds.southwest.longitude,
          south: value.bounds.southwest.latitude,
          east: value.bounds.northeast.longitude,
          north: value.bounds.northeast.latitude,
        ),
        styleUrl: value.styleUrl,
        minZoom: value.minZoom,
        maxZoom: value.maxZoom,
        pixelRatio: value.pixelRatio,
        includeIdeographs: value.includeIdeographs,
      ),
    mln.OfflineRegionDefinitionGeometry(:final value) =>
      OfflineGeometryRegionDefinition(
        geometry: GeometryBuilder.parse(jsonEncode(value.geometry)),
        styleUrl: value.styleUrl,
        minZoom: value.minZoom,
        maxZoom: value.maxZoom,
        pixelRatio: value.pixelRatio,
        includeIdeographs: value.includeIdeographs,
      ),
  },
  metadata: decodeRegionMetadata(info.metadata),
);
