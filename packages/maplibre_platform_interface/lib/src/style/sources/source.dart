import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_platform_interface/src/style/expressions/expression_json.dart';

part 'geo_json_source.dart';
part 'raster_dem_source.dart';
part 'raster_source.dart';
part 'vector_source.dart';
part 'image_source.dart';
part 'video_source.dart';
part 'style_sources.dart';

/// The base Source class that can't be used directly.
///
/// https://maplibre.org/maplibre-style-spec/sources
///
/// {@category Style}
/// {@subCategory Style Sources}
interface class Source {
  /// Create a new [Source] instance.
  const Source({required this.id});

  /// Reads the source [id] from its JSON in a style. The class follows its
  /// `type`, and a type that this version of the package doesn't know gives a
  /// plain [Source].
  factory Source.fromJson(String id, Map<String, Object?> json) =>
      switch (json['type']) {
        'geojson' => GeoJsonSource._fromJson(id, json),
        'raster' => RasterSource._fromJson(id, json),
        'raster-dem' => RasterDemSource._fromJson(id, json),
        'vector' => VectorSource._fromJson(id, json),
        'image' => ImageSourceUrl(
          id: id,
          url: json['url'] as String? ?? '',
          coordinates: LngLatQuad._fromJson(json['coordinates']),
        ),
        'video' => VideoSourceUrls(
          id: id,
          urls: [...?(json['urls'] as List<Object?>?)?.cast<String>()],
          coordinates: LngLatQuad._fromJson(json['coordinates']),
        ),
        _ => Source(id: id),
      };

  /// The id of the source.
  final String id;

  /// The source as JSON of a style, or null if it has no such form, as a
  /// source of image bytes doesn't.
  Map<String, Object?>? toJson() => null;
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

/// The `bounds` of the source JSON [json], or the world.
List<double> _boundsOf(Map<String, Object?> json) => switch (json['bounds']) {
  final List<Object?> bounds when bounds.length == 4 => [
    for (final value in bounds) (value! as num).toDouble(),
  ],
  _ => const [-180, -85.051129, 180, 85.051129],
};

double? _doubleOf(Object? json) => (json as num?)?.toDouble();

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
