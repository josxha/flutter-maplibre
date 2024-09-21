part of 'layer.dart';

/// A layer that contains circles.
///
/// https://maplibre.org/maplibre-style-spec/layers/#circle
final class HeatmapLayer extends LayerWithSource {
  /// Default constructor for a [HeatmapLayer] instance.
  const HeatmapLayer({
    required super.id,
    required super.sourceId,
    super.layout,
    super.paint,
  });

  // TODO add properties
}
