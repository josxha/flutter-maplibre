part of 'annotations.dart';

/// A class that contains the properties for a polygon on the map.
class PolygonAnnotation extends Annotation {
  /// Create a new [PolygonAnnotation] instance.
  const PolygonAnnotation({
    required this.points,
  }) : super._();

  /// The [Position]s of where the [PolygonAnnotation] is located.
  final List<Position> points;
}

/// A [PolygonAnnotation] layer.
class FillAnnotationLayer extends AnnotationLayer<PolygonAnnotation> {
  /// Create a new [FillAnnotationLayer] instance.
  const FillAnnotationLayer({
    required List<PolygonAnnotation> fills,
  }) : super._(list: fills);
}
