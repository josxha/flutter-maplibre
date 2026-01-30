import 'package:flutter/widgets.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// This model class is used to stream the download progress in
/// [OfflineManager.downloadRegion].
///
/// {@category Offline}
@immutable
class DownloadProgress {
  /// Create a new [DownloadProgress] instance.
  const DownloadProgress({
    required this.loadedBytes,
    required this.loadedTiles,
    required this.totalTilesEstimated,
    required this.totalTiles,
    required this.region,
    required this.downloadCompleted,
  });

  /// The amount of bytes that are already downloaded.
  final int loadedBytes;

  /// The amount of tiles that are already downloaded.
  final int loadedTiles;

  /// The total amount of tiles in this region.
  ///
  /// If the precise number of tiles is not known yet, this field gives merely
  /// a lower bound.
  final int totalTiles;

  /// Weather the [totalTiles] value is an estimated or precise value.
  ///
  /// It is set to false during early phases of an offline download.
  /// Once style and tile sources have been downloaded, it is possible to
  /// calculate the precise number of required resources, at which point it is
  /// set to true.
  final bool totalTilesEstimated;

  /// The [OfflineRegion] object.
  final OfflineRegion region;

  /// Set to true once the download has completed sucessfully.
  final bool downloadCompleted;

  /// The current progress, returns null if [totalTiles] is unknown.
  double? get progress {
    if (totalTilesEstimated) return null;
    if (totalTiles == 0) return 1;
    return loadedTiles / totalTiles;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadProgress &&
          runtimeType == other.runtimeType &&
          loadedBytes == other.loadedBytes &&
          loadedTiles == other.loadedTiles &&
          totalTiles == other.totalTiles &&
          totalTilesEstimated == other.totalTilesEstimated &&
          region == other.region &&
          downloadCompleted == other.downloadCompleted;

  @override
  int get hashCode => Object.hash(
    loadedBytes,
    loadedTiles,
    totalTiles,
    totalTilesEstimated,
    region,
    downloadCompleted,
  );

  @override
  String toString() =>
      'DownloadProgress('
      'loadedBytes: $loadedBytes, '
      'loadedTiles: $loadedTiles, '
      'totalTiles: $totalTiles, '
      'totalTilesEstimated: $totalTilesEstimated, '
      'region: $region, '
      'downloadCompleted: $downloadCompleted)';
}
