part of 'annotations.dart';

/// A marker layer.
class MarkerAnnotationLayer extends AnnotationLayer<Point> {
  /// Create a new [MarkerAnnotationLayer] instance.
  const MarkerAnnotationLayer({
    required List<Point> points,
  }) : super._(list: points);
}
