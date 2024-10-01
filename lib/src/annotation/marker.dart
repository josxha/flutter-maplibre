part of 'annotations.dart';

/// A class that contains the properties for a map marker.
class MarkerAnnotation extends Annotation {
  /// Create a new [MarkerAnnotation] instance.
  const MarkerAnnotation({
    required this.point,
  }) : super._();

  /// The [Position] of where the [MarkerAnnotation] is located.
  final Position point;
}

/// A marker layer.
class MarkerAnnotationLayer extends AnnotationLayer<MarkerAnnotation> {
  /// Create a new [MarkerAnnotationLayer] instance.
  const MarkerAnnotationLayer({
    required List<MarkerAnnotation> markers,
  }) : super._(list: markers);
}
