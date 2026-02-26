part of 'expressions.dart';

/// Gets the elevation of a pixel (in meters above the vertical datum reference
/// of the raster-dem tiles) from a [RasterDemSource]. Can only be used in the
/// [ColorReliefStyleLayer.color].
///
/// https://maplibre.org/maplibre-style-spec/expressions/#elevation
Expression<num> elevation() => const Expression.fromJson(['elevation']);
