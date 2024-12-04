part of 'style_layer.dart';

/// A layer that contains circles.
///
/// https://maplibre.org/maplibre-style-spec/layers/#circle
///
/// {@category Style}
/// {@subCategory Style Layers}
final class CircleStyleLayer extends StyleLayerWithSource {
  /// Default constructor for a [CircleStyleLayer] instance.
  const CircleStyleLayer({
    required super.id,
    required super.sourceId,
    super.layout,
    super.paint,
  });

  // TODO add properties
}
