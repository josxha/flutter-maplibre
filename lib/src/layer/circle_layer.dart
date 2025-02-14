part of 'layer.dart';

/// A [Point] layer.
///
/// {@category Layers}
@immutable
class CircleLayer extends Layer<Point> {
  /// Create a new [CircleLayer] instance.
  const CircleLayer({
    required List<Point> points,
    this.radius = 5,
    this.color = const Color(0xFF000000),
    this.blur = 0,
    this.strokeWidth = 0,
    this.strokeColor = const Color(0xFF000000),
  }) : super._(list: points);

  /// Circle radius in pixels. Defaults to 5px.
  final int radius;

  /// The color of the circle. Defaults to black.
  final Color color;

  /// Amount to blur the circle. 1 blurs the circle such that only the
  /// centerpoint is full opacity.
  final double blur;

  /// The opacity at which the circle will be drawn.
  double get opacity => color.a;

  /// The outline width
  final int strokeWidth;

  /// The outline color
  final Color strokeColor;

  /// The opacity of the circle's stroke.
  double get strokeOpacity => strokeColor.a;

  @override
  StyleLayer createStyleLayer(int index) => CircleStyleLayer(
    id: getLayerId(index),
    sourceId: getSourceId(index),
    paint: getPaint(),
    layout: getLayout(),
  );

  @override
  Map<String, Object> getPaint() => {
    'circle-radius': radius,
    'circle-color': color.toHexString(alpha: false),
    'circle-blur': blur,
    'circle-opacity': opacity,
    'circle-stroke-width': strokeWidth,
    'circle-stroke-color': strokeColor.toHexString(alpha: false),
    'circle-stroke-opacity': strokeOpacity,
  };

  @override
  Map<String, Object> getLayout() => {};

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
