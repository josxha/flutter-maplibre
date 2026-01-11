part of 'style_layer.dart';

/// A layer that contains circles.
///
/// https://maplibre.org/maplibre-style-spec/layers/#circle
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract interface class CircleStyleLayer extends StyleLayerWithSource {
  /// Default constructor for a [CircleStyleLayer] instance.
  factory CircleStyleLayer({
    required String id,
    required String sourceId,
    double minZoom = 0,
    double maxZoom = 24,
    List<Object>? filter,
    String? sourceLayerId,
  }) => switch (kIsWeb) {
    true => CircleStyleLayerWeb(
      id: id,
      sourceId: sourceId,
      minZoom: minZoom,
      maxZoom: maxZoom,
      filter: filter,
      sourceLayerId: sourceLayerId,
    ),
    false => switch (defaultTargetPlatform) {
      TargetPlatform.android => CircleStyleLayerAndroid(
        id: id,
        sourceId: sourceId,
        minZoom: minZoom,
        maxZoom: maxZoom,
        filter: filter,
        sourceLayerId: sourceLayerId,
      ),
      TargetPlatform.iOS => CircleStyleLayerIos(
        id: id,
        sourceId: sourceId,
        minZoom: minZoom,
        maxZoom: maxZoom,
        filter: filter,
        sourceLayerId: sourceLayerId,
      ),
      _ => throw UnsupportedError(
        'CircleStyleLayer is not supported for the current platform.',
      ),
    },
  };

  // TODO add properties
}
