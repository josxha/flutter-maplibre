part of 'source.dart';

/// A GeoJSON source. Data must be provided via a "data" property, whose value
/// can be a URL or inline GeoJSON. When using in a browser, the GeoJSON data
/// must be on the same domain as the map or served with CORS headers.
///
/// https://maplibre.org/maplibre-style-spec/sources/#geojson
final class GeoJsonSource extends Source {
  /// The default constructor for a [GeoJsonSource] object.
  const GeoJsonSource({
    required this.id,
    required this.data,
    this.maxZoom = 18,
    this.attribution,
  });

  /// The id of the [GeoJsonSource].
  final String id;

  /// A URL to a GeoJSON file, or GeoJSON string.
  final String data;

  /// Maximum zoom level at which to create vector tiles (higher means greater
  /// detail at high zoom levels).
  ///
  /// Defaults to 18.
  final double maxZoom;

  /// Contains an attribution to be displayed when the map is shown to a user.
  final String? attribution;

  // TODO add more fields https://maplibre.org/maplibre-style-spec/sources/#buffer
}
