/// The base Source class that can't be used directly.
sealed class Source {
  const Source();
}

/// A layer that contains circles.
final class GeoJsonSource extends Source {
  /// The default constructor for a [GeoJsonSource] object.
  const GeoJsonSource({required this.id, required this.data});

  /// The id of the [GeoJsonSource].
  final String id;

  /// The GeoJSON data.
  final String data;
}
