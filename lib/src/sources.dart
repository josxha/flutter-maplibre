/// The base Source class that can't be used directly.
sealed class Source {
  const Source();
}

/// A layer that contains circles.
final class GeoJsonSource extends Source {
  const GeoJsonSource({required this.id, required this.data});

  final String id;
  final String data;
}
