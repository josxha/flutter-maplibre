part of 'annotations.dart';

/// A class that contains the properties for a line on the map.
class PolylineAnnotation extends Annotation {
  /// Create a new [PolylineAnnotation] instance.
  const PolylineAnnotation({
    required this.points,
  }) : super._();

  /// The [Position]s of where the [PolylineAnnotation] is located.
  final List<Position> points;
}

/// A [PolylineAnnotation] layer.
class PolylineAnnotationLayer extends AnnotationLayer<PolylineAnnotation> {
  /// Create a new [PolylineAnnotationLayer] instance.
  const PolylineAnnotationLayer({
    required List<PolylineAnnotation> polyline,
  }) : super._(list: polyline);
}
