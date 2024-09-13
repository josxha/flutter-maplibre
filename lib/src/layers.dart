/// The base Layer class that can't be used directly. Use [CircleLayer] or
/// [FillLayer] instead.
sealed class Layer {
  const Layer();
}

/// A layer that contains circles.
final class CircleLayer extends Layer {
  /// Default constructor for a [CircleLayer] instance.
  const CircleLayer({required this.id, required this.sourceId});

  /// The layer id.
  final String id;

  /// The id of the source that should get used.
  final String sourceId;
}

/// A layer that contains polygons.
final class FillLayer extends Layer {
  /// Default constructor for a [FillLayer] instance.
  const FillLayer({required this.id, required this.sourceId});

  /// The layer id.
  final String id;

  /// The id of the source that should get used.
  final String sourceId;
}
