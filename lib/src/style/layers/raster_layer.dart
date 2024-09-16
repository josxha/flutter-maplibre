part of 'layer.dart';

/// A layer that contains markers.
///
/// https://maplibre.org/maplibre-style-spec/layers/#symbol
final class RasterLayer extends Layer {
  /// Default constructor for a [RasterLayer] instance.
  const RasterLayer({
    required super.id,
    required this.sourceId,
  });

  /// The id of the source that should get used.
  final String sourceId;

  // TODO add properties
}
