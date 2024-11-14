part of 'style_layer.dart';

/// A layer that contains polygons.
///
/// https://maplibre.org/maplibre-style-spec/layers/#fill
final class FillStyleLayer extends StyleLayerWithSource {
  /// Default constructor for a [FillStyleLayer] instance.
  const FillStyleLayer({
    required super.id,
    required super.sourceId,
    super.layout,
    super.paint,
  });
  // TODO add properties
}
