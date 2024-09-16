part of 'source.dart';

/// A vector tile source. Tiles must be in Mapbox Vector Tile format. All
/// geometric coordinates in vector tiles must be between -1 * extent and
/// (extent * 2) - 1 inclusive. All layers that use a vector source must
/// specify a source-layer value.
///
/// https://maplibre.org/maplibre-style-spec/sources/#vector
final class VectorSource extends Source {
  /// The default constructor for a [VectorSource] object.
  const VectorSource({
    this.url,
    this.tiles,
    this.bounds = const [-180, -85.051129, 180, 85.051129],
    this.scheme = TileScheme.xyz,
    this.minZoom = 0,
    this.maxZoom = 2,
    this.attribution,
    this.volatile = false,
  });

  /// A URL to a TileJSON resource. Supported protocols are `http:` and
  /// `https:`.
  final String? url;

  /// An array of one or more tile source URLs, as in the TileJSON spec.
  final List<String>? tiles;

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
