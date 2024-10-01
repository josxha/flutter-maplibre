part of 'annotations.dart';

/// A class that contains the properties for a map marker.
class CircleAnnotation extends Annotation {
  /// Create a new [CircleAnnotation] instance.
  const CircleAnnotation({
    required this.point,
  }) : super._();

  /// The [Position] of where the [CircleAnnotation] is located.
  final Position point;
}

/// A marker layer.
class CircleAnnotationLayer extends AnnotationLayer<CircleAnnotation> {
  /// Create a new [CircleAnnotationLayer] instance.
  const CircleAnnotationLayer({
    required List<CircleAnnotation> circles,
  }) : super._(list: circles);
}
