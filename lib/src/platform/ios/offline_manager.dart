import 'package:maplibre/maplibre.dart';

/// iOS specific implementation of the [OfflineManager].
class OfflineManagerIos implements OfflineManager {
  const OfflineManagerIos._();

  /// Create a new [OfflineManagerIos] instance.
  static Future<OfflineManagerIos> createInstance() async {
    return const OfflineManagerIos._();
  }

  @override
  Future<void> clearAmbientCache() {
    // TODO: implement clearAmbientCache
    throw UnimplementedError();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Stream<DownloadProgress> downloadRegion({
    required String mapStyleUrl,
    required LngLatBounds bounds,
    required double minZoom,
    required double maxZoom,
    required double pixelDensity,
    Map<String, Object?> metadata = const {},
  }) {
    // TODO: implement downloadRegion
    throw UnimplementedError();
  }

  @override
  Future<OfflineRegion> getOfflineRegion({required int regionId}) {
    // TODO: implement getOfflineRegion
    throw UnimplementedError();
  }

  @override
  Future<void> invalidateAmbientCache() {
    // TODO: implement invalidateAmbientCache
    throw UnimplementedError();
  }

  @override
  Future<List<OfflineRegion>> listOfflineRegions() {
    // TODO: implement listOfflineRegions
    throw UnimplementedError();
  }

  @override
  Future<List<OfflineRegion>> mergeOfflineRegions({required String path}) {
    // TODO: implement mergeOfflineRegions
    throw UnimplementedError();
  }

  @override
  Future<void> packDatabase() {
    // TODO: implement packDatabase
    throw UnimplementedError();
  }

  @override
  Future<void> resetDatabase() {
    // TODO: implement resetDatabase
    throw UnimplementedError();
  }

  @override
  void runPackDatabaseAutomatically({required bool enabled}) {
    // TODO: implement runPackDatabaseAutomatically
  }

  @override
  Future<void> setMaximumAmbientCacheSize({required int bytes}) {
    // TODO: implement setMaximumAmbientCacheSize
    throw UnimplementedError();
  }

  @override
  void setOfflineTileCountLimit({required int amount}) {
    // TODO: implement setOfflineTileCountLimit
  }
}
