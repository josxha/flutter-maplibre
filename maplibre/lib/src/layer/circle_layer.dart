part of 'layer.dart';

/// A [Point] layer.
///
/// {@category Layers}
@immutable
class CircleLayer extends Layer<Feature<Point>> {
  /// Create a new [CircleLayer] instance.
  const CircleLayer({
    required List<Feature<Point>> points,
    this.radius = 5,
    this.color = const Color(0xFF000000),
    this.blur = 0,
    this.strokeWidth = 0,
    this.strokeColor = const Color(0xFF000000),
    super.minZoom = 0,
    super.maxZoom = 24,
  }) : super._(list: points);

  /// Circle radius in pixels. Defaults to 5px.
  final double radius;

  /// The color of the circle. Defaults to black.
  final Color color;

  /// Amount to blur the circle. 1 blurs the circle such that only the
  /// centerpoint is full opacity.
  final double blur;

  /// The opacity at which the circle will be drawn.
  double get opacity => color.a;

  /// The outline width
  final double strokeWidth;

  /// The outline color
  final Color strokeColor;

  /// The opacity of the circle's stroke.
  double get strokeOpacity => strokeColor.a;

  @override
  StyleLayer createStyleLayer(int index) => CircleStyleLayer(
    id: getLayerId(index),
    sourceId: getSourceId(index),
    minZoom: minZoom,
    maxZoom: maxZoom,
    radius: PropertyValue.value(radius),
    color: PropertyValue.value(color),
    blur:  PropertyValue.value(blur),
    opacity: PropertyValue.value(opacity),
    strokeWidth: PropertyValue.value(strokeWidth),
    strokeColor: PropertyValue.value(strokeColor),
    strokeOpacity: PropertyValue.value(strokeOpacity),

  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is CircleLayer &&
          runtimeType == other.runtimeType &&
          radius == other.radius &&
          color == other.color &&
          blur == other.blur &&
          strokeWidth == other.strokeWidth &&
          strokeColor == other.strokeColor;

  @override
  int get hashCode => Object.hash(
    super.hashCode,
    radius,
    color,
    blur,
    strokeWidth,
    strokeColor,
  );
}
