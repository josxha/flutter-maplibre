import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:maplibre_native/src/database.dart';
import 'package:maplibre_native/src/extensions.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart' as mln;
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// The events that a download observes its region for.
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
      await runtime.setEventHandler(
        mln.RuntimeEventHandler(callback: manager._onEvents),
      );
    } on Object {
      await runtime.release();
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
    unawaited(_runtime.release());
  }

  @override
  Future<List<OfflineRegion>> listOfflineRegions() async =>
      (await _runtime.listOfflineRegions())
          .map((info) => info.toOfflineRegion())
          .toList();

  @override
  Future<OfflineRegion?> getOfflineRegion({required int regionId}) async {
    final info = await _runtime.getOfflineRegion(regionId);
    return info?.toOfflineRegion();
  }

  @override
  Future<List<OfflineRegion>> mergeOfflineRegions({
    required String path,
  }) async =>
      (await _runtime.mergeOfflineRegions(path))
          .map((info) => info.toOfflineRegion())
          .toList();

  @override
  Future<OfflineRegion> updateRegionMetadata({
    required int regionId,
    required Map<String, Object?> metadata,
  }) async => (await _runtime.updateOfflineRegionMetadata(
    regionId,
    encodeRegionMetadata(metadata),
  )).toOfflineRegion();

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
      _runtime.runCacheDatabaseOperation(mln.CacheDatabaseOperation.clear);

  @override
  Future<void> invalidateAmbientCache() =>
      _runtime.runCacheDatabaseOperation(mln.CacheDatabaseOperation.invalidate);

  @override
  Future<void> packDatabase() =>
      _runtime.runCacheDatabaseOperation(mln.CacheDatabaseOperation.pack);

  @override
  Future<void> resetDatabase() async {
    for (final regionId in _downloads.keys.toList()) {
      await _stopDownload(regionId);
    }
    await _runtime.runCacheDatabaseOperation(mln.CacheDatabaseOperation.reset);
  }

  @override
  Future<OfflineRegionStatus> getRegionStatus({required int regionId}) async =>
      (await _runtime.getOfflineRegionStatus(regionId)).toOfflineRegionStatus();

  @override
  Stream<DownloadProgress> downloadRegion({
    required OfflineRegionDefinition definition,
    Map<String, Object?> metadata = const {},
  }) => _download(() async {
    final info = await _runtime.createOfflineRegion(
      definition.toMln(),
      encodeRegionMetadata(metadata),
    );
    return info.toOfflineRegion();
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
          await _runtime.setOfflineRegionObserved(id, _offlineEvents);
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
      await _runtime.setOfflineRegionObserved(
        regionId,
        mln.RuntimeEventFlag.none,
      );
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
            status: value.status.toOfflineRegionStatus(),
          );
          download.controller.add(progress);
          if (progress.downloadCompleted) {
            unawaited(_stopDownload(value.regionId));
          }
        case mln.RuntimeEventPayloadOfflineRegionResponseError(:final value):
          _downloads[value.regionId]?.controller.addError(
            OfflineResourceException(
              regionId: value.regionId,
              reason: value.reason.toOfflineResourceErrorReason(),
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
