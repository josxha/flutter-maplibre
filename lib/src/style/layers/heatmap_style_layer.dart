part of 'style_layer.dart';

/// A layer that contains circles.
///
/// https://maplibre.org/maplibre-style-spec/layers/#circle
final class HeatmapStyleLayer extends StyleLayerWithSource {
  /// Default constructor for a [HeatmapStyleLayer] instance.
  const HeatmapStyleLayer({
    required super.id,
    required super.sourceId,
    super.layout,
    super.paint,
  });

  // TODO add properties
}
