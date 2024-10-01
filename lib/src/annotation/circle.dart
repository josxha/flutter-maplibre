part of 'annotations.dart';

/// A class that contains the properties for a map marker.
class MarkerAnnotation extends Annotation {
  /// Create a new [MarkerAnnotation] instance.
  const MarkerAnnotation({
    required this.point,
    this.radius = 5,
    this.color = const Color(0x00000000),
    this.blur = 0,
    this.strokeWidth = 0,
    this.strokeColor = const Color(0x00000000),
  }) : super._();

  /// The [Position] of where the [MarkerAnnotation] is located.
  final Position point;

  /// Circle radius in pixels. Defaults to 5px.
  final int radius;

  /// The color of the circle. Defaults to black
  final Color color;

  /// Amount to blur the circle. 1 blurs the circle such that only the
  /// centerpoint is full opacity.
  final double blur;

  /// The opacity at which the circle will be drawn.
  double get opacity => color.opacity;

  /// The outline width
  final int strokeWidth;

  /// The outline color
  final Color strokeColor;

  /// The opacity of the circle's stroke.
  double get strokeOpacity => strokeColor.opacity;
}

/// A marker layer.
class MarkerAnnotationLayer extends AnnotationLayer<MarkerAnnotation> {
  /// Create a new [MarkerAnnotationLayer] instance.
  const MarkerAnnotationLayer({
    required List<MarkerAnnotation> markers,
  }) : super._(list: markers);
}
