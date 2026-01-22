part of 'style_layer.dart';

/// A layer that contains hillshades.
///
/// https://maplibre.org/maplibre-style-spec/layers/#hillshade
///
/// {@category Style}
/// {@subCategory Style Layers}
final class HillshadeStyleLayer extends StyleLayerWithSource {
  /// Default constructor for a [HillshadeStyleLayer] instance.
  const HillshadeStyleLayer({
    required super.id,
    required super.sourceId,
    super.layout,
    super.paint,
    super.minZoom = 0,
    super.maxZoom = 24,
  });

  // TODO add properties
}
