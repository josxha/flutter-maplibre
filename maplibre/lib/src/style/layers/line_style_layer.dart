part of 'style_layer.dart';

/// A layer that contains lines.
///
/// https://maplibre.org/maplibre-style-spec/layers/#line
///
/// {@category Style}
/// {@subCategory Style Layers}
final class LineStyleLayer extends StyleLayerWithSource {
  /// Default constructor for a [LineStyleLayer] instance.
  const LineStyleLayer({
    required super.id,
    required super.sourceId,
    super.layout,
    super.paint,
    super.minZoom = 0,
    super.maxZoom = 24,
    super.filter,
    super.sourceLayerId,
  });

  // TODO add properties
}
