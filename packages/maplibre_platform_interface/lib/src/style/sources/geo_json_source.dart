part of 'source.dart';

/// A GeoJSON source, from a URL ([GeoJsonSource.url]) or from [GeoJsonData]
/// ([GeoJsonSource.data]). When using in a browser, GeoJSON from a URL must
/// be on the same domain as the map or served with CORS headers.
///
/// https://maplibre.org/maplibre-style-spec/sources/#geojson
///
/// {@category Style}
/// {@subCategory Style Sources}
sealed class GeoJsonSource extends Source {
  const GeoJsonSource._({
    required super.id,
    this.maxZoom = 18,
    this.attribution,
    this.buffer = 128,
    this.tolerance = 0.375,
    this.lineMetrics = false,
    this.cluster,
  });

  factory GeoJsonSource._fromJson(String id, Map<String, Object?> json) {
    final maxZoom = _doubleOf(json['maxzoom']) ?? 18;
    final attribution = json['attribution'] as String?;
    final buffer = (json['buffer'] as num?)?.toInt() ?? 128;
    final tolerance = _doubleOf(json['tolerance']) ?? 0.375;
    final lineMetrics = json['lineMetrics'] as bool? ?? false;
    final cluster = json['cluster'] == true
        ? GeoJsonCluster._fromJson(json)
        : null;
    return switch (json['data']) {
      final String url => GeoJsonSourceUrl(
        id: id,
        url: url,
        maxZoom: maxZoom,
        attribution: attribution,
        buffer: buffer,
        tolerance: tolerance,
        lineMetrics: lineMetrics,
        cluster: cluster,
      ),
      final data => GeoJsonSourceData(
        id: id,
        data: data is Map<String, Object?>
            ? GeoJsonData.json(data)
            : GeoJsonData.text(jsonEncode(data)),
        maxZoom: maxZoom,
        attribution: attribution,
        buffer: buffer,
        tolerance: tolerance,
        lineMetrics: lineMetrics,
        cluster: cluster,
      ),
    };
  }

  /// A GeoJSON source that loads its data from the GeoJSON file at [url].
  const factory GeoJsonSource.url({
    required String id,
    required String url,
    double maxZoom,
    String? attribution,
    int buffer,
    double tolerance,
    bool lineMetrics,
    GeoJsonCluster? cluster,
  }) = GeoJsonSourceUrl;

  /// A GeoJSON source of [data].
  const factory GeoJsonSource.data({
    required String id,
    required GeoJsonData data,
    double maxZoom,
    String? attribution,
    int buffer,
    double tolerance,
    bool lineMetrics,
    GeoJsonCluster? cluster,
  }) = GeoJsonSourceData;

  /// Maximum zoom level at which to create vector tiles (higher means greater
  /// detail at high zoom levels).
  ///
  /// Defaults to 18.
  final double maxZoom;

  /// Contains an attribution to be displayed when the map is shown to a user.
  final String? attribution;

  /// Size of the tile buffer on each side, in tile units of 512 per tile. A
  /// higher value draws fewer clipped features at tile edges, at the cost of
  /// speed.
  ///
  /// Defaults to 128.
  final int buffer;

  /// Tolerance for simplifying features. Determines the level of simplification
  /// that the geometry must undergo while rendering the layer.
  ///
  /// Defaults to 0.375 (pixels at zoom 0).
  /// Higher values mean more simplification and better performance.
  final double tolerance;

  /// Whether to calculate line distance metrics, which `line-progress`
  /// expressions such as in [LineStyleLayer.gradient] need.
  ///
  /// Defaults to false.
  final bool lineMetrics;

  /// Groups points into clusters, or null to keep every point on its own.
  final GeoJsonCluster? cluster;

  @override
  Map<String, Object?> toJson() => {
    'type': 'geojson',
    'data': switch (this) {
      GeoJsonSourceUrl(:final url) => url,
      GeoJsonSourceData(:final data) => data.toJson(),
    },
    ..._optionsJson(),
  };

  /// The source JSON without its `type` and `data`.
  Map<String, Object?> _optionsJson() => {
    'maxzoom': maxZoom,
    'buffer': buffer,
    'tolerance': tolerance,
    'lineMetrics': lineMetrics,
    'attribution': ?attribution,
    ...?cluster?._toJson(),
  };

  /// This source with the [data].
  GeoJsonSourceData _withData(GeoJsonData data) => GeoJsonSourceData(
    id: id,
    data: data,
    maxZoom: maxZoom,
    attribution: attribution,
    buffer: buffer,
    tolerance: tolerance,
    lineMetrics: lineMetrics,
    cluster: cluster,
  );

  /// This source loading its data from [url].
  GeoJsonSourceUrl _withUrl(String url) => GeoJsonSourceUrl(
    id: id,
    url: url,
    maxZoom: maxZoom,
    attribution: attribution,
    buffer: buffer,
    tolerance: tolerance,
    lineMetrics: lineMetrics,
    cluster: cluster,
  );
}

/// The source JSON of [source] without its `type` and `data`, for platforms
/// that pass the data on its own.
Map<String, Object?> geoJsonOptionsOf(GeoJsonSource source) =>
    source._optionsJson();

/// A [GeoJsonSource] that loads its data from a URL.
///
/// {@category Style}
/// {@subCategory Style Sources}
final class GeoJsonSourceUrl extends GeoJsonSource {
  /// Creates a [GeoJsonSource] from the GeoJSON file at [url].
  const GeoJsonSourceUrl({
    required super.id,
    required this.url,
    super.maxZoom,
    super.attribution,
    super.buffer,
    super.tolerance,
    super.lineMetrics,
    super.cluster,
  }) : super._();

  /// A URL to a GeoJSON file.
  final String url;
}

/// A [GeoJsonSource] of [GeoJsonData].
///
/// {@category Style}
/// {@subCategory Style Sources}
final class GeoJsonSourceData extends GeoJsonSource {
  /// Creates a [GeoJsonSource] of [data].
  const GeoJsonSourceData({
    required super.id,
    required this.data,
    super.maxZoom,
    super.attribution,
    super.buffer,
    super.tolerance,
    super.lineMetrics,
    super.cluster,
  }) : super._();

  /// The GeoJSON of the source.
  final GeoJsonData data;
}

/// How a [GeoJsonSource] groups its points into clusters.
///
/// A cluster is a point feature with the properties `cluster` (true),
/// `cluster_id`, `point_count` and `point_count_abbreviated`, plus the
/// [properties]. Read its points with [MapController.getClusterLeaves].
///
/// https://maplibre.org/maplibre-style-spec/sources/#cluster
///
/// {@category Style}
/// {@subCategory Style Sources}
@immutable
final class GeoJsonCluster {
  /// Creates the options of clustering.
  const GeoJsonCluster({
    this.radius = 50,
    this.maxZoom,
    this.minPoints = 2,
    this.properties = const {},
  });

  factory GeoJsonCluster._fromJson(Map<String, Object?> json) => GeoJsonCluster(
    radius: (json['clusterRadius'] as num?)?.toInt() ?? 50,
    maxZoom: _doubleOf(json['clusterMaxZoom']),
    minPoints: (json['clusterMinPoints'] as num?)?.toInt() ?? 2,
    properties: {
      for (final MapEntry(:key, :value)
          in ((json['clusterProperties'] as Map<String, Object?>?) ?? const {})
              .entries)
        if (value case [final reduce, final map])
          key: ClusterProperty(
            reduce: _clusterExpressionOf(reduce),
            map: _clusterExpressionOf(map),
          ),
    },
  );

  /// Radius of each cluster, in pixels of a 512 pixel tile.
  ///
  /// Defaults to 50.
  final int radius;

  /// The zoom level up to which points are clustered, or null for one below
  /// [GeoJsonSource.maxZoom].
  final double? maxZoom;

  /// The number of points that a cluster has at least.
  ///
  /// Defaults to 2.
  final int minPoints;

  /// Properties that clusters accumulate from their points, by name.
  final Map<String, ClusterProperty> properties;

  Map<String, Object?> _toJson() => {
    'cluster': true,
    'clusterRadius': radius,
    'clusterMaxZoom': ?maxZoom,
    'clusterMinPoints': minPoints,
    if (properties.isNotEmpty)
      'clusterProperties': {
        for (final MapEntry(:key, :value) in properties.entries)
          key: [value.reduce.toJson(), value.map.toJson()],
      },
  };

  @override
  bool operator ==(Object other) =>
      other is GeoJsonCluster && jsonEquals(_toJson(), other._toJson());

  @override
  int get hashCode => jsonHash(_toJson());
}

/// A property that the clusters of a [GeoJsonCluster] accumulate from their
/// points.
///
/// ```dart
/// // The sum of the `mag` properties of the points of a cluster.
/// ClusterProperty(
///   reduce: .sum([.accumulated().asNumber(), .get('sum').asNumber()]),
///   map: .get('mag'),
/// );
/// ```
///
/// {@category Style}
/// {@subCategory Style Sources}
@immutable
final class ClusterProperty {
  /// Creates a cluster property.
  const ClusterProperty({required this.reduce, required this.map});

  /// Combines the value accumulated so far, [Expression.accumulated], with
  /// the property of the next point or cluster, read with [Expression.get]
  /// of this property's name.
  final Expression<Object?> reduce;

  /// The value of a single point.
  final Expression<Object?> map;
}

Object? _decodeAny(Object? json) => json;

/// Reads an expression of a cluster property. Its arrays are expressions,
/// also constant ones such as `["rgb", 255, 0, 0]`, which [decodeExpression]
/// would read as colors and write back as a `literal`.
Expression<Object?> _clusterExpressionOf(Object? json) =>
    json is List<Object?> ? Call(json) : decodeExpression(json, _decodeAny);
