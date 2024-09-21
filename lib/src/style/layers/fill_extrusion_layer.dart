part of 'layer.dart';

/// A layer that contains circles.
///
/// https://maplibre.org/maplibre-style-spec/layers/#circle
final class FillExtrusionLayer extends LayerWithSource {
  /// Default constructor for a [FillExtrusionLayer] instance.
  const FillExtrusionLayer({
    required super.id,
    required super.sourceId,
    super.layout,
    super.paint,
  });

  // TODO add properties
}
