import 'dart:async';

import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/android/extensions.dart';
import 'package:maplibre/src/platform/pigeon.g.dart' as pigeon;

/// The [OfflineManager] implementation that uses Pigeon as a fallback.
abstract class OfflineManagerNative implements OfflineManager {
  final _hostApi = pigeon.OfflineManagerHostApi();

  @override
  Future<void> clearAmbientCache() async => _hostApi.clearAmbientCache();

  @override
  Stream<DownloadProgress> downloadRegion({
    required String mapStyleUrl,
    required LngLatBounds bounds,
    required double minZoom,
    required double maxZoom,
    required double pixelDensity,
    Map<String, Object?> metadata = const {},
  }) async* {
    await _hostApi.downloadRegion(
      mapStyleUrl: mapStyleUrl,
      bounds: bounds.toLngLatBounds(),
      minZoom: minZoom,
      maxZoom: maxZoom,
      pixelDensity: pixelDensity,
    );
    // TODO implement
    yield DownloadProgress(
      loadedBytes: 1,
      loadedTiles: 1,
      totalTilesEstimated: true,
      totalTiles: 1,
      region: OfflineRegion(
        id: 1,
        bounds: bounds,
        minZoom: minZoom,
        maxZoom: maxZoom,
        pixelRatio: pixelDensity,
        styleUrl: mapStyleUrl,
      ),
      downloadCompleted: true,
    );
  }

  @override
  Future<void> invalidateAmbientCache() async =>
      _hostApi.invalidateAmbientCache();

  @override
  Future<List<OfflineRegion>> mergeOfflineRegions({
    required String path,
  }) async {
    final result = await _hostApi.mergeOfflineRegions(path: path);
    return result
        .map(
          (e) => OfflineRegion(
            id: e.id,
            bounds: LngLatBounds(
              longitudeWest: e.bounds.longitudeWest,
              longitudeEast: e.bounds.longitudeEast,
              latitudeSouth: e.bounds.latitudeSouth,
              latitudeNorth: e.bounds.latitudeNorth,
            ),
            minZoom: e.minZoom,
            maxZoom: e.maxZoom,
            pixelRatio: e.pixelRatio,
            styleUrl: e.styleUrl,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<void> packDatabase() async =>
      throw UnimplementedError('The database cannot be packed on iOS.');

  @override
  Future<void> resetDatabase() async => _hostApi.resetDatabase();

  @override
  void runPackDatabaseAutomatically({required bool enabled}) {
    // TODO: implement runPackDatabaseAutomatically
    throw UnimplementedError();
  }

  @override
  Future<void> setMaximumAmbientCacheSize({required int bytes}) async =>
      _hostApi.setMaximumAmbientCacheSize(bytes: bytes);
}
