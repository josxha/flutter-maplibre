part of 'annotations.dart';

/// A class that contains the properties for a map marker.
class Marker extends Annotation {
  /// Create a new [Marker] instance.
  const Marker({
    required this.point,
  }) : super._();

  /// The [Position] of where the [Marker] is located.
  final Position point;
}

/// A marker layer.
class MarkerAnnotationLayer extends AnnotationLayer<Marker> {
  /// Create a new [MarkerAnnotationLayer] instance.
  const MarkerAnnotationLayer({
    required List<Marker> markers,
  }) : super._(list: markers);
}
