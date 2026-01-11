part of 'style_layer.dart';

/// A layer that contains lines.
///
/// https://maplibre.org/maplibre-style-spec/layers/#line
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract interface class LineStyleLayer implements StyleLayerWithSource {
  /// Default constructor for a [LineStyleLayer] instance.
  factory LineStyleLayer({
    required super.id,
    required super.sourceId,
    super.minZoom = 0,
    super.maxZoom = 24,
    super.filter,
    super.metadata,
    super.sourceLayerId,
  });

  // TODO add properties
}
