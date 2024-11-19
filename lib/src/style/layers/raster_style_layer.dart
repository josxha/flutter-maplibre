part of 'style_layer.dart';

/// A layer that contains markers.
///
/// https://maplibre.org/maplibre-style-spec/layers/#symbol
final class RasterStyleLayer extends StyleLayerWithSource {
  /// Default constructor for a [RasterStyleLayer] instance.
  const RasterStyleLayer({
    required super.id,
    required super.sourceId,
    super.layout,
    super.paint,
  });

  // TODO add properties
}
