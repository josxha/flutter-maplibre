part of 'annotation_layer.dart';

/// A marker layer.
@immutable
class CircleAnnotationLayer extends AnnotationLayer<Point> {
  /// Create a new [CircleAnnotationLayer] instance.
  // ignore: prefer_const_constructors_in_immutables
  CircleAnnotationLayer({
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
  double get opacity => color.opacity;

  /// The outline width
  final int strokeWidth;

  /// The outline color
  final Color strokeColor;

  /// The opacity of the circle's stroke.
  double get strokeOpacity => strokeColor.opacity;

  @override
  Layer createLayer(int index) => CircleLayer(
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
        'circle-opacity': color.opacity,
        'circle-stroke-width': strokeWidth,
        'circle-stroke-color': strokeColor.toHexStringNoOpacity(),
        'circle-stroke-opacity': strokeColor.opacity,
      };

  @override
  Map<String, Object> getLayout() => {};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is CircleAnnotationLayer &&
          runtimeType == other.runtimeType &&
          radius == other.radius &&
          color == other.color &&
          blur == other.blur &&
          strokeWidth == other.strokeWidth &&
          strokeColor == other.strokeColor &&
          const DeepCollectionEquality().equals(list, other.list);

  late final int? _cachedHashCode;

  @override
  int get hashCode => _cachedHashCode ??= super.hashCode ^
      radius.hashCode ^
      color.hashCode ^
      blur.hashCode ^
      strokeWidth.hashCode ^
      strokeColor.hashCode;
}
