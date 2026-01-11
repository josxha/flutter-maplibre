part of 'style_layer.dart';

/// A layer that contains markers.
///
/// https://maplibre.org/maplibre-style-spec/layers/#symbol
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract interface class RasterStyleLayer implements StyleLayerWithSource {
  /// Default constructor for a [RasterStyleLayer] instance.
  factory RasterStyleLayer({
    required super.id,
    required super.sourceId,
    super.minZoom = 0,
    super.maxZoom = 24,
    super.metadata,
  });

  // TODO add properties
}
