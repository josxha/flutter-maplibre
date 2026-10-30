part of 'source.dart';

/// A raster DEM source. Only supports Mapbox Terrain RGB and Mapzen
/// Terrarium tiles.
///
/// https://maplibre.org/maplibre-style-spec/sources/#raster-dem
///
/// {@category Style}
/// {@subCategory Style Sources}
sealed class RasterDemSource extends Source {
  const RasterDemSource._({
    required super.id,
    this.bounds = const [-180, -85.051129, 180, 85.051129],
    this.minZoom = 0,
    this.maxZoom = 22,
    this.tileSize = 512,
    this.attribution,
    this.encoding = const RasterDemMapboxEncoding(),
    this.volatile = false,
  });

  /// A raster DEM source whose tiles are described by the TileJSON resource at
  /// [url]. Supported protocols are `http:` and `https:`.
  const factory RasterDemSource.url({
    required String id,
    required String url,
    List<double> bounds,
    double minZoom,
    double maxZoom,
    int tileSize,
    String? attribution,
    RasterDemEncoding encoding,
    bool volatile,
  }) = RasterDemSourceUrl;

  /// A raster DEM source that loads its tiles from one or more [tiles] URLs, as
  /// in the TileJSON spec.
  const factory RasterDemSource.tiles({
    required String id,
    required List<String> tiles,
    List<double> bounds,
    double minZoom,
    double maxZoom,
    int tileSize,
    String? attribution,
    RasterDemEncoding encoding,
    bool volatile,
  }) = RasterDemSourceTiles;

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

  /// Contains an attribution to be displayed when the map is shown to a user.
  final String? attribution;

  /// The encoding used by this source. Mapbox Terrain RGB is used by default.
  final RasterDemEncoding encoding;

  /// A setting to determine whether a source's tiles are cached locally.
  ///
  /// Defaults to false. Not available on web.
  final bool volatile;
}

/// A [RasterDemSource] whose tiles are described by a TileJSON resource.
///
/// {@category Style}
/// {@subCategory Style Sources}
final class RasterDemSourceUrl extends RasterDemSource {
  /// Creates a [RasterDemSource] from the TileJSON resource at [url].
  const RasterDemSourceUrl({
    required super.id,
    required this.url,
    super.bounds,
    super.minZoom,
    super.maxZoom,
    super.tileSize,
    super.attribution,
    super.encoding,
    super.volatile,
  }) : super._();

  /// A URL to a TileJSON resource. Supported protocols are `http:` and
  /// `https:`.
  final String url;
}

/// A [RasterDemSource] that loads its tiles from tile URLs.
///
/// {@category Style}
/// {@subCategory Style Sources}
final class RasterDemSourceTiles extends RasterDemSource {
  /// Creates a [RasterDemSource] from the tile URLs [tiles].
  const RasterDemSourceTiles({
    required super.id,
    required this.tiles,
    super.bounds,
    super.minZoom,
    super.maxZoom,
    super.tileSize,
    super.attribution,
    super.encoding,
    super.volatile,
  }) : super._();

  /// An array of one or more tile source URLs, as in the TileJSON spec.
  final List<String> tiles;
}

/// The encoding used by this source. Mapbox Terrain RGB is used by default.
///
/// {@category Style}
/// {@subCategory Style Sources}
sealed class RasterDemEncoding {
  const RasterDemEncoding();
}

/// Terrarium format PNG tiles.
/// See https://aws.amazon.com/es/public-datasets/terrain/ for more info.
///
/// {@category Style}
/// {@subCategory Style Sources}
final class RasterDemTerrariumEncoding extends RasterDemEncoding {
  /// Create a [RasterDemTerrariumEncoding].
  const RasterDemTerrariumEncoding();
}

/// Mapbox Terrain RGB tiles.
/// See https://www.mapbox.com/help/access-elevation-data/#mapbox-terrain-rgb
/// for more info.
///
/// {@category Style}
/// {@subCategory Style Sources}
final class RasterDemMapboxEncoding extends RasterDemEncoding {
  /// Create a [RasterDemMapboxEncoding].
  const RasterDemMapboxEncoding();
}

/// Decodes tiles using the redFactor, blueFactor, greenFactor, baseShift
/// parameters.
///
/// {@category Style}
/// {@subCategory Style Sources}
final class RasterDemCustomEncoding extends RasterDemEncoding {
  /// Create a [RasterDemCustomEncoding].
  const RasterDemCustomEncoding({
    this.redFactor = 1,
    this.blueFactor = 1,
    this.greenFactor = 1,
    this.baseShift = 0,
  });

  /// Value that will be multiplied by the red channel value when decoding.
  ///
  /// Defaults to 1.
  final double redFactor;

  /// Value that will be multiplied by the blue channel value when decoding.
  ///
  /// Defaults to 1.
  final double blueFactor;

  /// Value that will be multiplied by the green channel value when decoding.
  ///
  /// Defaults to 1.
  final double greenFactor;

  /// Value that will be added to the encoding mix when decoding.
  ///
  /// Defaults to 0.
  final double baseShift;
}
