import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/native/offline_manager.dart';

/// Use the offline manager to download map regions for offline usage.
abstract interface class OfflineManager {
  /// Create a new [OfflineManager].
  ///
  /// You'll have to call [dispose] to free resources once no longer needed.
  static Future<OfflineManager> createInstance() async =>
      OfflineManagerNative.createInstance();

  /// Call to free resources when the [OfflineManager] is no longer needed.
  void dispose();

  /// Merge offline regions from a secondary database into the main offline
  /// database.
  Future<List<OfflineRegion>> mergeOfflineRegions({required String path});

  /// Retrieve given region in the offline database.
  Future<OfflineRegion> getOfflineRegion({required int regionId});

  /// Sets the maximum number of tiles that may be downloaded and stored on
  /// the current device. By default, the limit is set to 6,000.
  void setOfflineTileCountLimit({required int amount});

  /// Set the maximum size of the ambient cache in bytes.
  Future<void> setMaximumAmbientCacheSize({required int bytes});

  /// Erase resources from the ambient cache, freeing storage space.
  Future<void> clearAmbientCache();

  /// Forces re-validation of the ambient cache.
  Future<void> invalidateAmbientCache();

  /// Retrieve all regions in the offline database.
  Future<List<OfflineRegion>> listOfflineRegions();

  /// Packs the existing database file into a minimal amount of disk space.
  Future<void> packDatabase();

  /// Delete existing database and re-initialize.
  Future<void> resetDatabase();

  /// Sets whether database file packing occurs automatically.
  /// By default, the automatic database file packing is enabled.
  void runPackDatabaseAutomatically({required bool enabled});

  /// Downloads a map region.
  Future<OfflineRegion> downloadRegion({
    required String mapStyleUrl,
    required LngLatBounds bounds,
    required double minZoom,
    required double maxZoom,
    required double pixelDensity,
    Map<String, Object?> metadata = const {},
  });
}
