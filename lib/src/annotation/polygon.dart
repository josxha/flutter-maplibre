part of 'annotations.dart';

/// A [Polygon] layer.
class PolygonAnnotationLayer extends AnnotationLayer<Polygon> {
  /// Create a new [PolygonAnnotationLayer] instance.
  PolygonAnnotationLayer({
    required List<Polygon> polygons,
  }) : super._(
          list: polygons,
          sourceId: 'maplibre-polygon-source-${_counter++}',
          layerId: 'maplibre-polygon-layer-${_counter++}',
        );

  @override
  Map<String, Object> getPaint() => {};
}
