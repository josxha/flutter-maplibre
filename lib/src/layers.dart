/// The base Layer class that can't be used directly. Use [CircleLayer] or
/// [FillLayer] instead.
sealed class Layer {
  const Layer();
}

/// A layer that contains circles.
final class CircleLayer extends Layer {
  const CircleLayer({required this.id, required this.sourceId});

  final String id;
  final String sourceId;
}

/// A layer that contains polygons.
final class FillLayer extends Layer {
  const FillLayer({required this.id, required this.sourceId});

  final String id;
  final String sourceId;
}
