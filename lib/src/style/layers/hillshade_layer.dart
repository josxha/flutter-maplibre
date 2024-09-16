part of 'layer.dart';

/// A layer that contains circles.
///
/// https://maplibre.org/maplibre-style-spec/layers/#circle
final class HillshadeLayer extends LayerWithSource {
  /// Default constructor for a [HillshadeLayer] instance.
  const HillshadeLayer({
    required super.id,
    required super.sourceId,
    super.layout,
    super.paint,
  });

  // TODO add properties
}
