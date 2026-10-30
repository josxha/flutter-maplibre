part of 'source.dart';

/// A vector tile source. Tiles must be in Mapbox Vector Tile format. All
/// geometric coordinates in vector tiles must be between -1 * extent and
/// (extent * 2) - 1 inclusive. All layers that use a vector source must
/// specify a source-layer value.
///
/// https://maplibre.org/maplibre-style-spec/sources/#vector
///
/// {@category Style}
/// {@subCategory Style Sources}
sealed class VectorSource extends Source {
  const VectorSource._({
    required super.id,
    this.bounds = const [-180, -85.051129, 180, 85.051129],
    this.scheme = TileScheme.xyz,
    this.minZoom = 0,
    this.maxZoom = 22,
    this.attribution,
    this.volatile = false,
  });

  /// A vector source whose tiles are described by the TileJSON resource at
  /// [url]. Supported protocols are `http:` and `https:`.
  const factory VectorSource.url({
    required String id,
    required String url,
    List<double> bounds,
    TileScheme scheme,
    double minZoom,
    double maxZoom,
    String? attribution,
    bool volatile,
  }) = VectorSourceUrl;

  /// A vector source that loads its tiles from one or more [tiles] URLs, as
  /// in the TileJSON spec.
  const factory VectorSource.tiles({
    required String id,
    required List<String> tiles,
    List<double> bounds,
    TileScheme scheme,
    double minZoom,
    double maxZoom,
    String? attribution,
    bool volatile,
  }) = VectorSourceTiles;

  /// An array containing the longitude and latitude of the southwest and
  /// northeast corners of the source's bounding box in the following order:
  /// `sw.lng, sw.lat, ne.lng, ne.lat`. When this property is included in a
  /// source, no tiles outside of the given bounds are requested by MapLibre.
  ///
  /// Defaults to `-180, -85.051129, 180, 85.051129`.
  final List<double> bounds;

  /// Influences the y direction of the tile coordinates. The global-mercator
  /// (aka Spherical Mercator) profile is assumed.
  ///
  /// Defaults to xyz.
  final TileScheme scheme;

  /// Minimum zoom level for which tiles are available, as in the TileJSON spec.
  ///
  /// Defaults to 0.
  final double minZoom;

  /// Maximum zoom level for which tiles are available, as in the TileJSON
  /// spec. Data from tiles at the maxzoom are used when displaying the map at
  /// higher zoom levels.
  ///
  /// Defaults to 22.
  final double maxZoom;

  /// Contains an attribution to be displayed when the map is shown to a user.
  final String? attribution;

  /// A setting to determine whether a source's tiles are cached locally.
  ///
  /// Defaults to false. Not available on web.
  final bool volatile;
}

/// A [VectorSource] whose tiles are described by a TileJSON resource.
///
/// {@category Style}
/// {@subCategory Style Sources}
final class VectorSourceUrl extends VectorSource {
  /// Creates a [VectorSource] from the TileJSON resource at [url].
  const VectorSourceUrl({
    required super.id,
    required this.url,
    super.bounds,
    super.scheme,
    super.minZoom,
    super.maxZoom,
    super.attribution,
    super.volatile,
  }) : super._();

  /// A URL to a TileJSON resource. Supported protocols are `http:` and
  /// `https:`.
  final String url;
}

/// A [VectorSource] that loads its tiles from tile URLs.
///
/// {@category Style}
/// {@subCategory Style Sources}
final class VectorSourceTiles extends VectorSource {
  /// Creates a [VectorSource] from the tile URLs [tiles].
  const VectorSourceTiles({
    required super.id,
    required this.tiles,
    super.bounds,
    super.scheme,
    super.minZoom,
    super.maxZoom,
    super.attribution,
    super.volatile,
  }) : super._();

  /// An array of one or more tile source URLs, as in the TileJSON spec.
  final List<String> tiles;
}
