part of 'annotations.dart';

/// A marker layer.
class CircleAnnotationLayer extends AnnotationLayer<Point> {
  /// Create a new [CircleAnnotationLayer] instance.
  const CircleAnnotationLayer({
    required List<Point> points,
    this.radius = 5,
    this.color = const Color(0x00000000),
    this.blur = 0,
    this.strokeWidth = 0,
    this.strokeColor = const Color(0x00000000),
  }) : super._(list: points);

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

  /// Build the paint properties for [CircleLayer.paint].
  Map<String, Object> getPaint() => {
    'circle-radius': radius,
    'circle-color': color.toHexStringNoOpacity(),
    'circle-blur': blur,
    'circle-opacity': color.opacity,
    'circle-stroke-width': strokeWidth,
    'circle-stroke-color': strokeColor.toHexStringNoOpacity(),
    'circle-stroke-opacity': strokeColor.opacity,
  };
}
