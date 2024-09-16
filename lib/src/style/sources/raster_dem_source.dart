part of 'source.dart';

/// A raster DEM source. Only supports Mapbox Terrain RGB and Mapzen
/// Terrarium tiles.
///
/// https://maplibre.org/maplibre-style-spec/sources/#raster-dem
final class RasterDemSource extends Source {
  /// The default constructor for a [RasterDemSource] object.
  const RasterDemSource({
    required super.id,
    this.url,
    this.tiles,
    this.bounds = const [-180, -85.051129, 180, 85.051129],
    this.minZoom = 0,
    this.maxZoom = 2,
    this.tileSize = 512,
    this.attribution,
    this.encoding = const RasterDemMapboxEncoding(),
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

  /// Contains an attribution to be displayed when the map is shown to a user.
  final String? attribution;

  /// The encoding used by this source. Mapbox Terrain RGB is used by default.
  final RasterDemEncoding encoding;

  /// A setting to determine whether a source's tiles are cached locally.
  ///
  /// Defaults to false. Not available on web.
  final bool volatile;
}

/// The encoding used by this source. Mapbox Terrain RGB is used by default.
sealed class RasterDemEncoding {
  const RasterDemEncoding();
}

/// Terrarium format PNG tiles.
/// See https://aws.amazon.com/es/public-datasets/terrain/ for more info.
final class RasterDemTerrariumEncoding extends RasterDemEncoding {
  /// Create a [RasterDemCustomEncoding].
  const RasterDemTerrariumEncoding();
}

/// Mapbox Terrain RGB tiles.
/// See https://www.mapbox.com/help/access-elevation-data/#mapbox-terrain-rgb
/// for more info.
final class RasterDemMapboxEncoding extends RasterDemEncoding {
  /// Create a [RasterDemMapboxEncoding].
  const RasterDemMapboxEncoding();
}

/// Decodes tiles using the redFactor, blueFactor, greenFactor, baseShift
/// parameters.
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
