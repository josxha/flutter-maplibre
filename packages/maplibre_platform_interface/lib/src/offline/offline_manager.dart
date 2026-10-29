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

  /// Retrieve how far the download of a region got.
  Future<OfflineRegionStatus> getRegionStatus({required int regionId});

  /// Creates a region of [definition], downloads it, and reports its progress
  /// until the download completes.
  ///
  /// The stream reports resources that fail to load as
  /// [OfflineResourceException]s; the download retries them. A region with
  /// more tiles than MapLibre allows stops with an
  /// [OfflineTileCountLimitException]. Cancelling the subscription pauses the
  /// download, which [resumeDownload] continues.
  Stream<DownloadProgress> downloadRegion({
    required OfflineRegionDefinition definition,
    Map<String, Object?> metadata = const {},
  });

  /// Continues the download of a region that is in the database, and
  /// reports its progress until the download completes.
  Stream<DownloadProgress> resumeDownload({required int regionId});
}

/// Reported by the stream of [OfflineManager.downloadRegion] and
/// [OfflineManager.resumeDownload] when the download of a region runs into a
/// problem.
///
/// {@category Offline}
sealed class OfflineDownloadException implements Exception {
  const OfflineDownloadException({required this.regionId});

  /// The id of the region whose download reported the problem.
  final int regionId;

  /// What went wrong.
  String get message;

  @override
  String toString() => 'OfflineDownloadException: $message';
}

/// Why a resource of an offline region failed to load.
///
/// {@category Offline}
enum OfflineResourceErrorReason {
  /// The server has no such resource.
  notFound,

  /// The server answered with an error.
  server,

  /// The server could not be reached.
  connection,

  /// The server limits the rate of requests.
  rateLimit,

  /// Something else went wrong.
  other,
}

/// A resource of an offline region failed to load. The download retries it.
///
/// {@category Offline}
final class OfflineResourceException extends OfflineDownloadException {
  /// Creates an exception for a resource of [regionId] that failed to load.
  const OfflineResourceException({
    required super.regionId,
    required this.reason,
    this.details = '',
  });

  /// Why the resource failed to load.
  final OfflineResourceErrorReason reason;

  /// The error message of MapLibre, if there is one.
  final String details;

  @override
  String get message =>
      'A resource of offline region $regionId failed to load '
      '(${reason.name})${details.isEmpty ? '' : ': $details'}';
}

/// An offline region needs more tiles than MapLibre allows, so its download
/// stopped.
///
/// {@category Offline}
final class OfflineTileCountLimitException extends OfflineDownloadException {
  /// Creates an exception for [regionId], which exceeds [limit] tiles.
  const OfflineTileCountLimitException({
    required super.regionId,
    required this.limit,
  });

  /// The maximum number of tiles of a region.
  final int limit;

  @override
  String get message =>
      'Offline region $regionId exceeds the tile count limit of $limit tiles';
}
