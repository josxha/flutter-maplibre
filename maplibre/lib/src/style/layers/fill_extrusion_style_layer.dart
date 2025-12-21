part of 'style_layer.dart';

/// A layer that contains circles.
///
/// https://maplibre.org/maplibre-style-spec/layers/#circle
///
/// {@category Style}
/// {@subCategory Style Layers}
final class FillExtrusionStyleLayer extends StyleLayerWithSource {
  /// Default constructor for a [FillExtrusionStyleLayer] instance.
  const FillExtrusionStyleLayer({
    required super.id,
    required super.sourceId,
    super.layout,
    super.paint,
    super.minZoom = 0,
    super.maxZoom = 24,
    super.filter,
    super.metadata,
  });

  // TODO add properties
}
