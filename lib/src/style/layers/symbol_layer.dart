part of 'layer.dart';

/// A layer that contains markers.
///
/// https://maplibre.org/maplibre-style-spec/layers/#symbol
final class SymbolLayer extends LayerWithSource {
  /// Default constructor for a [SymbolLayer] instance.
  const SymbolLayer({
    required super.id,
    required super.sourceId,
    super.layout,
    super.paint,
  });

  // TODO add properties
}
