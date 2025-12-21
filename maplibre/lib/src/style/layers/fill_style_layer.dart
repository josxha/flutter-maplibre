part of 'style_layer.dart';

/// A layer that contains polygons.
///
/// https://maplibre.org/maplibre-style-spec/layers/#fill
///
/// {@category Style}
/// {@subCategory Style Layers}
final class FillStyleLayer extends StyleLayerWithSource {
  /// Default constructor for a [FillStyleLayer] instance.
  const FillStyleLayer({
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
