part of 'layer.dart';

/// A [Point] layer.
///
/// {@category Layers}
@immutable
class CircleLayer extends Layer<Point> {
  /// Create a new [CircleLayer] instance.
  const CircleLayer({
    required List<Feature<Point>> circles,
    this.radius = 5,
    this.color = const Color(0xFF000000),
    this.blur = 0,
    this.strokeWidth = 0,
    this.strokeColor = const Color(0xFF000000),
  }) : super._(list: circles);

  /// Circle radius in pixels. Defaults to 5px.
  final int radius;

  /// The color of the circle. Defaults to black.
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
        'circle-color': color.toHexStringNoOpacity(),
        'circle-blur': blur,
        'circle-opacity': opacity,
        'circle-stroke-width': strokeWidth,
        'circle-stroke-color': strokeColor.toHexStringNoOpacity(),
        'circle-stroke-opacity': strokeOpacity,
      };

  @override
  Map<String, Object> getLayout() => {};

  @override
  bool operator ==(covariant CircleLayer other) {
    if (identical(this, other)) return true;

    return other.radius == radius &&
        other.color == color &&
        other.blur == blur &&
        other.strokeWidth == strokeWidth &&
        other.strokeColor == strokeColor;
  }

  @override
  int get hashCode {
    return radius.hashCode ^
        color.hashCode ^
        blur.hashCode ^
        strokeWidth.hashCode ^
        strokeColor.hashCode;
  }
}
