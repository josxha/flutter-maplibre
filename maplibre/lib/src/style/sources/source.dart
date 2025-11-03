import 'package:maplibre/maplibre.dart';

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
