part of 'layer.dart';

/// A layer that contains polygons.
///
/// https://maplibre.org/maplibre-style-spec/layers/#fill
final class FillLayer extends Layer {
  /// Default constructor for a [FillLayer] instance.
  const FillLayer({
    required super.id,
    required this.sourceId,
  });

  /// The id of the source that should get used.
  final String sourceId;

  // TODO add properties
}
