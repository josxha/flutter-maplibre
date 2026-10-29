import 'package:flutter/widgets.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// This model class is used to stream the download progress in
/// [OfflineManager.downloadRegion] and [OfflineManager.resumeDownload].
///
/// {@category Offline}
@immutable
class DownloadProgress {
  /// Create a new [DownloadProgress] instance.
  const DownloadProgress({required this.region, required this.status});

  /// The [OfflineRegion] object.
  final OfflineRegion region;

  /// The download status of [region].
  final OfflineRegionStatus status;

  /// Set to true once the download has completed sucessfully.
  bool get downloadCompleted => status.complete;

  /// The current progress, see [OfflineRegionStatus.progress].
  double? get progress => status.progress;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadProgress &&
          runtimeType == other.runtimeType &&
          region == other.region &&
          status == other.status;

  @override
  int get hashCode => Object.hash(region, status);

  @override
  String toString() => 'DownloadProgress(region: $region, status: $status)';
}

/// Whether an offline region downloads.
///
/// {@category Offline}
enum OfflineRegionDownloadState {
  /// The region does not download.
  inactive,

  /// The region downloads the resources it is missing.
  active,
}

/// How far the download of an offline region got, from
/// [OfflineManager.getRegionStatus] or [DownloadProgress.status].
///
/// Resources are every file a region needs: its style, sources, sprites,
/// glyphs and tiles.
///
/// {@category Offline}
@immutable
class OfflineRegionStatus {
  /// Create a new [OfflineRegionStatus] instance.
  const OfflineRegionStatus({
    required this.downloadState,
    required this.completedResourceCount,
    required this.completedResourceSize,
    required this.completedTileCount,
    required this.completedTileSize,
    required this.requiredResourceCount,
    required this.requiredTileCount,
    required this.requiredResourceCountIsPrecise,
    required this.complete,
  });

  /// Whether the region downloads.
  final OfflineRegionDownloadState downloadState;

  /// The number of resources that are already downloaded.
  final int completedResourceCount;

  /// The size of the resources that are already downloaded, in bytes.
  final int completedResourceSize;

  /// The number of tiles that are already downloaded.
  final int completedTileCount;

  /// The size of the tiles that are already downloaded, in bytes.
  final int completedTileSize;

  /// The number of resources the region needs.
  ///
  /// It is a lower bound until [requiredResourceCountIsPrecise] is true.
  final int requiredResourceCount;

  /// The number of tiles the region needs.
  ///
  /// It is a lower bound until [requiredResourceCountIsPrecise] is true.
  final int requiredTileCount;

  /// Whether [requiredResourceCount] and [requiredTileCount] are precise.
  ///
  /// It is false during early phases of a download. Once the style and tile
  /// sources have been downloaded, the precise number of required resources
  /// is known, and it becomes true.
  final bool requiredResourceCountIsPrecise;

  /// Whether every resource of the region is downloaded.
  final bool complete;

  /// The share of the required resources that are downloaded, from 0 to 1,
  /// or null while the number of required resources is not precise.
  double? get progress {
    if (complete) return 1;
    if (!requiredResourceCountIsPrecise) return null;
    if (requiredResourceCount == 0) return 1;
    return completedResourceCount / requiredResourceCount;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineRegionStatus &&
          runtimeType == other.runtimeType &&
          downloadState == other.downloadState &&
          completedResourceCount == other.completedResourceCount &&
          completedResourceSize == other.completedResourceSize &&
          completedTileCount == other.completedTileCount &&
          completedTileSize == other.completedTileSize &&
          requiredResourceCount == other.requiredResourceCount &&
          requiredTileCount == other.requiredTileCount &&
          requiredResourceCountIsPrecise ==
              other.requiredResourceCountIsPrecise &&
          complete == other.complete;

  @override
  int get hashCode => Object.hash(
    downloadState,
    completedResourceCount,
    completedResourceSize,
    completedTileCount,
    completedTileSize,
    requiredResourceCount,
    requiredTileCount,
    requiredResourceCountIsPrecise,
    complete,
  );

  @override
  String toString() =>
      'OfflineRegionStatus('
      'downloadState: ${downloadState.name}, '
      'completedResourceCount: $completedResourceCount, '
      'completedResourceSize: $completedResourceSize, '
      'completedTileCount: $completedTileCount, '
      'completedTileSize: $completedTileSize, '
      'requiredResourceCount: $requiredResourceCount, '
      'requiredTileCount: $requiredTileCount, '
      'requiredResourceCountIsPrecise: $requiredResourceCountIsPrecise, '
      'complete: $complete)';
}
