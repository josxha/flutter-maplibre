import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';

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
  });

  /// The region id.
  final int id;

  /// The bounding box of the map region.
  final BBox bounds;

  /// The minimum zoom level.
  final double minZoom;

  /// The maximum zoom level.
  final double maxZoom;

  /// The pixel ratio.
  final double pixelRatio;

  /// The style URL.
  final String styleUrl;

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
          styleUrl == other.styleUrl;

  @override
  int get hashCode =>
      Object.hash(id, bounds, minZoom, maxZoom, pixelRatio, styleUrl);

  @override
  String toString() => 'OfflineRegion(id: $id, bounds: $bounds, '
      'minZoom: $minZoom, maxZoom: $maxZoom, pixelRatio: $pixelRatio, '
      'styleUrl: $styleUrl)';
}
