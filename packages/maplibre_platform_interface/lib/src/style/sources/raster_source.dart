part of 'source.dart';

/// A raster tile source.
///
/// https://maplibre.org/maplibre-style-spec/sources/#raster
///
/// {@category Style}
/// {@subCategory Style Sources}
sealed class RasterSource extends Source {
  const RasterSource._({
    required super.id,
    this.bounds = const [-180, -85.051129, 180, 85.051129],
    this.minZoom = 0,
    this.maxZoom = 22,
    this.tileSize = 512,
    this.scheme = TileScheme.xyz,
    this.attribution,
    this.volatile = false,
  });

  /// A raster source whose tiles are described by the TileJSON resource at
  /// [url]. Supported protocols are `http:` and `https:`, and `pmtiles://`
  /// in front of the URL of a PMTiles archive.
  const factory RasterSource.url({
    required String id,
    required String url,
    List<double> bounds,
    double minZoom,
    double maxZoom,
    int tileSize,
    TileScheme scheme,
    String? attribution,
    bool volatile,
  }) = RasterSourceUrl;

  /// A raster source that loads its tiles from one or more [tiles] URLs, as
  /// in the TileJSON spec.
  const factory RasterSource.tiles({
    required String id,
    required List<String> tiles,
    List<double> bounds,
    double minZoom,
    double maxZoom,
    int tileSize,
    TileScheme scheme,
    String? attribution,
    bool volatile,
  }) = RasterSourceTiles;

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
  final int tileSize;

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

/// A [RasterSource] whose tiles are described by a TileJSON resource.
///
/// {@category Style}
/// {@subCategory Style Sources}
final class RasterSourceUrl extends RasterSource {
  /// Creates a [RasterSource] from the TileJSON resource at [url].
  const RasterSourceUrl({
    required super.id,
    required this.url,
    super.bounds,
    super.minZoom,
    super.maxZoom,
    super.tileSize,
    super.scheme,
    super.attribution,
    super.volatile,
  }) : super._();

  /// A URL to a TileJSON resource. Supported protocols are `http:` and
  /// `https:`, and `pmtiles://` in front of the URL of a PMTiles archive.
  final String url;
}

/// A [RasterSource] that loads its tiles from tile URLs.
///
/// {@category Style}
/// {@subCategory Style Sources}
final class RasterSourceTiles extends RasterSource {
  /// Creates a [RasterSource] from the tile URLs [tiles].
  const RasterSourceTiles({
    required super.id,
    required this.tiles,
    super.bounds,
    super.minZoom,
    super.maxZoom,
    super.tileSize,
    super.scheme,
    super.attribution,
    super.volatile,
  }) : super._();

  /// An array of one or more tile source URLs, as in the TileJSON spec.
  final List<String> tiles;
}
