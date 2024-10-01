part of 'annotations.dart';

/// A [Polygon] layer.
class PolygonAnnotationLayer extends AnnotationLayer<Polygon> {
  /// Create a new [PolygonAnnotationLayer] instance.
  const PolygonAnnotationLayer({
    required List<Polygon> polygons,
  }) : super._(list: polygons);
}
