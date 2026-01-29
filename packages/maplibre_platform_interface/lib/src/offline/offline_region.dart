import 'package:flutter/foundation.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Model class that represents a map region for offline usage.
///
/// {@category Offline}
@immutable
class OfflineRegion {
  /// Create a new [OfflineRegion] instance.
  const OfflineRegion({
    required this.id,
    required this.bounds,
    required this.minZoom,
    required this.maxZoom,
    required this.pixelRatio,
    required this.styleUrl,
    this.metadata = const {},
  });

  /// The region id.
  final int id;

  /// The bounding box of the map region.
  final LngLatBounds bounds;

  /// The minimum zoom level.
  final double minZoom;

  /// The maximum zoom level.
  final double maxZoom;

  /// The pixel ratio.
  final double pixelRatio;

  /// The style URL.
  final String styleUrl;

  /// The metadata of the region.
  final Map<String, Object?> metadata;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineRegion &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          bounds == other.bounds &&
          minZoom == other.minZoom &&
          maxZoom == other.maxZoom &&
          pixelRatio == other.pixelRatio &&
          styleUrl == other.styleUrl &&
          mapEquals(metadata, other.metadata);

  @override
  int get hashCode => Object.hash(
    id,
    bounds,
    minZoom,
    maxZoom,
    pixelRatio,
    styleUrl,
    Object.hashAllUnordered(
      metadata.entries.map((e) => Object.hash(e.key, e.value)),
    ),
  );

  @override
  String toString() =>
      'OfflineRegion(id: $id, bounds: $bounds, '
      'minZoom: $minZoom, maxZoom: $maxZoom, pixelRatio: $pixelRatio, '
      'styleUrl: $styleUrl, metadata: $metadata)';
}
