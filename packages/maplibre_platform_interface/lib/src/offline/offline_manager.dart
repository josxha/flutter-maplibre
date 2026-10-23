import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Use the offline manager to download map regions for offline usage.
///
/// Regions are stored in the database that every map caches its resources
/// in, so a map shows a downloaded region without the network. The
/// [OfflineManager] cannot be used on web.
///
/// {@category Offline}
abstract interface class OfflineManager {
  /// Create a new [OfflineManager].
  ///
  /// You'll have to call [dispose] to free resources once no longer needed.
  static Future<OfflineManager> createInstance() async =>
      MapLibrePlatform.instance.createOfflineManager();

  /// Whether the offline manager is supported on the current platform.
  static bool get isSupported =>
      MapLibrePlatform.instance.offlineManagerIsSupported;

  /// Call to free resources when the [OfflineManager] is no longer needed.
  ///
  /// Downloads that are still running stop, and their streams close.
  void dispose();

  /// Merge offline regions from a secondary database into the main offline
  /// database, and return the merged regions.
  ///
  /// The secondary database may be upgraded in place, so it has to be
  /// writable.
  Future<List<OfflineRegion>> mergeOfflineRegions({required String path});

  /// Retrieve given region in the offline database, or null if there is
  /// none with [regionId].
  Future<OfflineRegion?> getOfflineRegion({required int regionId});

  /// Retrieve all regions in the offline database.
  Future<List<OfflineRegion>> listOfflineRegions();

  /// Replace the metadata of a region, and return the updated region.
  Future<OfflineRegion> updateRegionMetadata({
    required int regionId,
    required Map<String, Object?> metadata,
  });

  /// Delete an offline region by its [regionId].
  Future<void> deleteRegion({required int regionId});

  /// Forces re-validation of the resources of an offline region, which are
  /// then loaded again from the network once they are needed.
  Future<void> invalidateRegion({required int regionId});

  /// Set the maximum size of the ambient cache in bytes.
  Future<void> setMaximumAmbientCacheSize({required int bytes});

  /// Erase resources from the ambient cache, freeing storage space.
  Future<void> clearAmbientCache();

  /// Forces re-validation of the ambient cache.
  Future<void> invalidateAmbientCache();

  /// Packs the existing database file into a minimal amount of disk space.
  Future<void> packDatabase();

  /// Delete existing database and re-initialize.
  Future<void> resetDatabase();

  /// Downloads a map region, and reports its progress until the download
  /// completes.
  ///
  /// The stream reports resources that fail to load as errors; the download
  /// retries them. Cancelling the subscription pauses the download, which
  /// [resumeDownload] continues.
  Stream<DownloadProgress> downloadRegion({
    required String mapStyleUrl,
    required LngLatBounds bounds,
    required double minZoom,
    required double maxZoom,
    required double pixelDensity,
    Map<String, Object?> metadata = const {},
    bool includeIdeographs = false,
  });

  /// Continues the download of a region that is in the database, and
  /// reports its progress until the download completes.
  Stream<DownloadProgress> resumeDownload({required int regionId});
}

/// Reported by the stream of [OfflineManager.downloadRegion] when a resource
/// of the region fails to load, or the region exceeds the tile count limit.
///
/// {@category Offline}
final class OfflineDownloadException implements Exception {
  /// Creates an exception with [message].
  const OfflineDownloadException(this.message);

  /// What went wrong.
  final String message;

  @override
  String toString() => 'OfflineDownloadException: $message';
}
