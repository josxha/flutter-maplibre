part of 'source.dart';

/// A GeoJSON source, from a URL ([GeoJsonSource.url]) or a GeoJSON string
/// ([GeoJsonSource.data]). When using in a browser, GeoJSON from a URL must be
/// on the same domain as the map or served with CORS headers.
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
    this.tolerance = 0.375,
    this.lineMetrics = false,
  });

  factory GeoJsonSource._fromJson(String id, Map<String, Object?> json) {
    final maxZoom = _doubleOf(json['maxzoom']) ?? 18;
    final attribution = json['attribution'] as String?;
    final tolerance = _doubleOf(json['tolerance']) ?? 0.375;
    final lineMetrics = json['lineMetrics'] as bool? ?? false;
    return switch (json['data']) {
      final String url => GeoJsonSourceUrl(
        id: id,
        url: url,
        maxZoom: maxZoom,
        attribution: attribution,
        tolerance: tolerance,
        lineMetrics: lineMetrics,
      ),
      final data => GeoJsonSourceData(
        id: id,
        data: jsonEncode(data),
        maxZoom: maxZoom,
        attribution: attribution,
        tolerance: tolerance,
        lineMetrics: lineMetrics,
      ),
    };
  }

  /// A GeoJSON source that loads its data from the GeoJSON file at [url].
  const factory GeoJsonSource.url({
    required String id,
    required String url,
    double maxZoom,
    String? attribution,
    double tolerance,
    bool lineMetrics,
  }) = GeoJsonSourceUrl;

  /// A GeoJSON source of the GeoJSON string [data].
  const factory GeoJsonSource.data({
    required String id,
    required String data,
    double maxZoom,
    String? attribution,
    double tolerance,
    bool lineMetrics,
  }) = GeoJsonSourceData;

  /// Maximum zoom level at which to create vector tiles (higher means greater
  /// detail at high zoom levels).
  ///
  /// Defaults to 18.
  final double maxZoom;

  /// Contains an attribution to be displayed when the map is shown to a user.
  final String? attribution;

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

  // TODO add more fields https://maplibre.org/maplibre-style-spec/sources/#buffer

  @override
  Map<String, Object?> toJson() => {
    'type': 'geojson',
    'data': switch (this) {
      GeoJsonSourceUrl(:final url) => url,
      GeoJsonSourceData(:final data) => jsonDecode(data),
    },
    'maxzoom': maxZoom,
    'tolerance': tolerance,
    'lineMetrics': lineMetrics,
    'attribution': ?attribution,
  };
}

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
    super.tolerance,
    super.lineMetrics,
  }) : super._();

  /// A URL to a GeoJSON file.
  final String url;
}

/// A [GeoJsonSource] of a GeoJSON string.
///
/// {@category Style}
/// {@subCategory Style Sources}
final class GeoJsonSourceData extends GeoJsonSource {
  /// Creates a [GeoJsonSource] of the GeoJSON string [data].
  const GeoJsonSourceData({
    required super.id,
    required this.data,
    super.maxZoom,
    super.attribution,
    super.tolerance,
    super.lineMetrics,
  }) : super._();

  /// The GeoJSON, such as a `FeatureCollection`, as a string.
  final String data;
}
