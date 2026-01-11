part of 'style_layer.dart';

/// A layer that contains hillshades.
///
/// https://maplibre.org/maplibre-style-spec/layers/#hillshade
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract interface class HillshadeStyleLayer implements StyleLayerWithSource {
  /// Default constructor for a [HillshadeStyleLayer] instance.
  factory HillshadeStyleLayer({
    required super.id,
    required super.sourceId,
    super.minZoom = 0,
    super.maxZoom = 24,
    super.metadata,
  });

  // TODO add properties
}
