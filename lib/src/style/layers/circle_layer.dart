part of 'layer.dart';

/// A layer that contains circles.
///
/// https://maplibre.org/maplibre-style-spec/layers/#circle
final class CircleLayer extends Layer {
  /// Default constructor for a [CircleLayer] instance.
  const CircleLayer({
    required super.id,
    required this.sourceId,
  });

  /// The id of the source that should get used.
  final String sourceId;

  // TODO add properties
}
