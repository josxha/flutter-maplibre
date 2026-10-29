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
    required this.definition,
    this.metadata = const {},
  });

  /// The region id.
  final int id;

  /// The area, zoom levels and style that the region covers.
  final OfflineRegionDefinition definition;

  /// The metadata of the region.
  final Map<String, Object?> metadata;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineRegion &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          definition == other.definition &&
          mapEquals(metadata, other.metadata);

  @override
  int get hashCode => Object.hash(
    id,
    definition,
    Object.hashAllUnordered(
      metadata.entries.map((e) => Object.hash(e.key, e.value)),
    ),
  );

  @override
  String toString() =>
      'OfflineRegion(id: $id, definition: $definition, metadata: $metadata)';
}

/// What an [OfflineRegion] covers: the tiles of a style within an area,
/// between two zoom levels.
///
/// {@category Offline}
@immutable
sealed class OfflineRegionDefinition {
  const OfflineRegionDefinition({
    required this.styleUrl,
    required this.minZoom,
    required this.maxZoom,
    required this.pixelRatio,
    this.includeIdeographs = false,
  });

  /// The URL of the style whose sources the region downloads.
  final String styleUrl;

  /// The minimum zoom level.
  final double minZoom;

  /// The maximum zoom level.
  ///
  /// Tile sources download up to their own maximum zoom level if it is lower.
  /// Use a finite value: MapLibre Native downloads no tiles at all for
  /// [double.infinity].
  final double maxZoom;

  /// The pixel ratio of the screen the region is shown on, which selects the
  /// raster tiles and sprites to download.
  final double pixelRatio;

  /// Whether to download the glyphs of CJK ideographs, which maps otherwise
  /// draw with a local font.
  final bool includeIdeographs;

  /// The bounding box of the region.
  LngLatBounds get bounds;
}

/// An [OfflineRegionDefinition] of every tile within a rectangle.
///
/// {@category Offline}
final class OfflineTilePyramidRegionDefinition extends OfflineRegionDefinition {
  /// Creates a definition of the tiles within [bounds].
  const OfflineTilePyramidRegionDefinition({
    required this.bounds,
    required super.styleUrl,
    required super.minZoom,
    required super.maxZoom,
    required super.pixelRatio,
    super.includeIdeographs,
  });

  @override
  final LngLatBounds bounds;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineTilePyramidRegionDefinition &&
          bounds == other.bounds &&
          styleUrl == other.styleUrl &&
          minZoom == other.minZoom &&
          maxZoom == other.maxZoom &&
          pixelRatio == other.pixelRatio &&
          includeIdeographs == other.includeIdeographs;

  @override
  int get hashCode => Object.hash(
    bounds,
    styleUrl,
    minZoom,
    maxZoom,
    pixelRatio,
    includeIdeographs,
  );

  @override
  String toString() =>
      'OfflineTilePyramidRegionDefinition(bounds: $bounds, '
      'styleUrl: $styleUrl, minZoom: $minZoom, maxZoom: $maxZoom, '
      'pixelRatio: $pixelRatio, includeIdeographs: $includeIdeographs)';
}

/// An [OfflineRegionDefinition] of the tiles that a geometry touches, such as
/// a route as a [LineString] or an area as a [Polygon].
///
/// It downloads fewer tiles than an [OfflineTilePyramidRegionDefinition] of
/// the geometry's [bounds] when the geometry does not fill its bounding box.
///
/// {@category Offline}
final class OfflineGeometryRegionDefinition extends OfflineRegionDefinition {
  /// Creates a definition of the tiles that [geometry] touches.
  const OfflineGeometryRegionDefinition({
    required this.geometry,
    required super.styleUrl,
    required super.minZoom,
    required super.maxZoom,
    required super.pixelRatio,
    super.includeIdeographs,
  });

  /// The geometry whose tiles the region downloads.
  final Geometry geometry;

  /// The bounding box of [geometry].
  @override
  LngLatBounds get bounds {
    final box = geometry.calculateBounds();
    if (box == null) {
      return const LngLatBounds(
        longitudeWest: 0,
        longitudeEast: 0,
        latitudeSouth: 0,
        latitudeNorth: 0,
      );
    }
    return LngLatBounds(
      longitudeWest: box.minX,
      longitudeEast: box.maxX,
      latitudeSouth: box.minY,
      latitudeNorth: box.maxY,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineGeometryRegionDefinition &&
          // geobase compares the coordinates of geometries by identity.
          geometry.runtimeType == other.geometry.runtimeType &&
          geometry.equalsCoords(other.geometry) &&
          styleUrl == other.styleUrl &&
          minZoom == other.minZoom &&
          maxZoom == other.maxZoom &&
          pixelRatio == other.pixelRatio &&
          includeIdeographs == other.includeIdeographs;

  @override
  int get hashCode => Object.hash(
    geometry.runtimeType,
    bounds,
    styleUrl,
    minZoom,
    maxZoom,
    pixelRatio,
    includeIdeographs,
  );

  @override
  String toString() =>
      'OfflineGeometryRegionDefinition(geometry: ${geometry.toText()}, '
      'styleUrl: $styleUrl, minZoom: $minZoom, maxZoom: $maxZoom, '
      'pixelRatio: $pixelRatio, includeIdeographs: $includeIdeographs)';
}
