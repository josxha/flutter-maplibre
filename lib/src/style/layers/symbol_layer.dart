part of 'layer.dart';

/// A layer that contains markers.
///
/// https://maplibre.org/maplibre-style-spec/layers/#symbol
final class SymbolLayer extends Layer {
  /// Default constructor for a [SymbolLayer] instance.
  const SymbolLayer({
    required super.id,
    required this.sourceId,
  });

  /// The id of the source that should get used.
  final String sourceId;

  // TODO add properties
}
