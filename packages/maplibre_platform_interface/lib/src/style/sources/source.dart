import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

part 'geo_json_source.dart';
part 'raster_dem_source.dart';
part 'raster_source.dart';
part 'vector_source.dart';
part 'image_source.dart';
part 'video_source.dart';

/// The base Source class that can't be used directly.
///
/// https://maplibre.org/maplibre-style-spec/sources
///
/// {@category Style}
/// {@subCategory Style Sources}
interface class Source {
  /// Create a new [Source] instance.
  const Source({required this.id});

  /// The id of the source.
  final String id;
}

/// The TileJSON `url` or the `tiles` of a raster, raster DEM or vector
/// [source], as a source specification takes them.
Map<String, Object> tilesetOf(Source source) => switch (source) {
  RasterSourceUrl(:final url) ||
  RasterDemSourceUrl(:final url) ||
  VectorSourceUrl(:final url) => {'url': url},
  RasterSourceTiles(:final tiles) ||
  RasterDemSourceTiles(:final tiles) ||
  VectorSourceTiles(:final tiles) => {'tiles': tiles},
  _ => throw ArgumentError.value(source, 'source', 'Not a tile source'),
};

/// Influences the y direction of the tile coordinates.
///
/// {@category Style}
/// {@subCategory Style Sources}
enum TileScheme {
  /// Slippy map tilenames scheme.
  xyz,

  /// OSGeo spec scheme.
  tms,
}
