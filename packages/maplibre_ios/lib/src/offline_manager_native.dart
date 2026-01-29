import 'dart:async';
import 'dart:convert';

import 'package:maplibre/maplibre.dart';
import 'package:maplibre_android/src/extensions.dart';
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
      metadata: jsonEncode(metadata),
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
        metadata: metadata,
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
  }) async =>
      throw UnimplementedError('Importing Offline Regions is not available.');

  @override
  Future<void> packDatabase() async =>
      throw UnimplementedError('The database cannot be packed.');

  @override
  Future<void> resetDatabase() async => _hostApi.resetDatabase();

  @override
  void runPackDatabaseAutomatically({required bool enabled}) =>
      throw UnimplementedError('The database cannot be packed.');

  @override
  Future<void> setMaximumAmbientCacheSize({required int bytes}) async =>
      _hostApi.setMaximumAmbientCacheSize(bytes: bytes);
}
