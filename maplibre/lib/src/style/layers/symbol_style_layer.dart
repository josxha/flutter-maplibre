part of 'style_layer.dart';

/// A layer that contains markers.
///
/// https://maplibre.org/maplibre-style-spec/layers/#symbol
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract interface class SymbolStyleLayer implements StyleLayerWithSource {
  /// Default constructor for a [SymbolStyleLayer] instance.
  factory SymbolStyleLayer({
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
