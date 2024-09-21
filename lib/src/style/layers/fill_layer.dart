part of 'layer.dart';

/// A layer that contains polygons.
///
/// https://maplibre.org/maplibre-style-spec/layers/#fill
final class FillLayer extends LayerWithSource {
  /// Default constructor for a [FillLayer] instance.
  const FillLayer({
    required super.id,
    required super.sourceId,
    super.layout,
    super.paint,
  });
  // TODO add properties
}
