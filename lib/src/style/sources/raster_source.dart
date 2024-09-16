part of 'source.dart';

/// A raster tile source.
///
/// https://maplibre.org/maplibre-style-spec/sources/#raster
final class RasterSource extends Source {
  /// The default constructor for a [RasterSource] object.
  const RasterSource({
    this.url,
    this.tiles,
    this.bounds = const [-180, -85.051129, 180, 85.051129],
    this.minZoom = 0,
    this.maxZoom = 2,
    this.tileSize = 512,
    this.scheme = TileScheme.xyz,
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

  /// The minimum visual size to display tiles for this layer. Only
  /// configurable for raster layers.
  ///
  /// Defaults to 512.
  final double tileSize;

  /// Influences the y direction of the tile coordinates. The global-mercator
  /// (aka Spherical Mercator) profile is assumed.
  ///
  /// Defaults to xyz.
  final TileScheme scheme;

  /// Contains an attribution to be displayed when the map is shown to a user.
  final String? attribution;

  /// A setting to determine whether a source's tiles are cached locally.
  ///
  /// Defaults to false. Not available on web.
  final bool volatile;
}
