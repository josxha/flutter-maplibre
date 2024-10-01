part of 'annotations.dart';

/// A marker layer.
class MarkerAnnotationLayer extends AnnotationLayer<Point> {
  /// Create a new [MarkerAnnotationLayer] instance.
  MarkerAnnotationLayer({
    required List<Point> points,
  }) : super._(
          list: points,
          sourceId: 'maplibre-marker-source-${_counter++}',
          layerId: 'maplibre-marker-layer-${_counter++}',
        );

  @override
  Map<String, Object> getPaint() => {};

  @override
  Layer createLayer() => SymbolLayer(
    id: layerId,
    sourceId: sourceId,
    paint: getPaint(),
  );
}
