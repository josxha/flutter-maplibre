part of 'style_layer.dart';

/// A layer that contains circles.
///
/// https://maplibre.org/maplibre-style-spec/layers/#circle
///
/// {@category Style}
/// {@subCategory Style Layers}
final class HeatmapStyleLayer extends StyleLayerWithSource {
  /// Default constructor for a [HeatmapStyleLayer] instance.
  const HeatmapStyleLayer({
    required super.id,
    required super.sourceId,
    super.layout,
    super.paint,
    super.minZoom = 0,
    super.maxZoom = 24,
    super.sourceLayerId,
  });

  // TODO add properties
}
