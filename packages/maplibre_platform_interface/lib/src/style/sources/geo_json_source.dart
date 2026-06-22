part of 'source.dart';

/// A GeoJSON source. Data must be provided via a "data" property, whose value
/// can be a URL or inline GeoJSON. When using in a browser, the GeoJSON data
/// must be on the same domain as the map or served with CORS headers.
///
/// https://maplibre.org/maplibre-style-spec/sources/#geojson
///
/// {@category Style}
/// {@subCategory Style Sources}
@immutable
final class GeoJsonSource extends Source {
  /// The default constructor for a [GeoJsonSource] object.
  const GeoJsonSource({
    required super.id,
    required this.data,
    this.maxZoom = 18,
    this.attribution,
    this.cluster = false,
    this.clusterRadius = 50,
    this.clusterMaxZoom = 14,
    this.clusterMinPoints = 2,
  });

  /// A URL to a GeoJSON file, or GeoJSON string.
  final String data;

  /// Maximum zoom level at which to create vector tiles (higher means greater
  /// detail at high zoom levels).
  ///
  /// Defaults to 18.
  final double maxZoom;

  /// Contains an attribution to be displayed when the map is shown to a user.
  final String? attribution;

  /// If true, the GeoJSON point features are clustered together into grouped
  /// points when they are close to each other. Clusters carry the additional
  /// properties `point_count` and `point_count_abbreviated`.
  ///
  /// Defaults to false.
  final bool cluster;

  /// Radius of each cluster when clustering points, measured in pixels.
  ///
  /// Only applies when [cluster] is true. Defaults to 50.
  final int clusterRadius;

  /// Maximum zoom level at which to cluster points if clustering is enabled.
  /// Defaults to one zoom level less than [maxZoom] so that points are not
  /// clustered at the highest zoom level.
  ///
  /// Only applies when [cluster] is true. Defaults to 14.
  final int clusterMaxZoom;

  /// Minimum number of points necessary to form a cluster if clustering is
  /// enabled.
  ///
  /// Only applies when [cluster] is true. Defaults to 2.
  final int clusterMinPoints;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeoJsonSource &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          data == other.data &&
          maxZoom == other.maxZoom &&
          attribution == other.attribution &&
          cluster == other.cluster &&
          clusterRadius == other.clusterRadius &&
          clusterMaxZoom == other.clusterMaxZoom &&
          clusterMinPoints == other.clusterMinPoints;

  @override
  int get hashCode => Object.hash(
    id,
    data,
    maxZoom,
    attribution,
    cluster,
    clusterRadius,
    clusterMaxZoom,
    clusterMinPoints,
  );

  // TODO add more fields https://maplibre.org/maplibre-style-spec/sources/#buffer
}
