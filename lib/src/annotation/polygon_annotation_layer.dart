part of 'annotation_layer.dart';

/// A [Polygon] layer.
@immutable
class PolygonAnnotationLayer extends AnnotationLayer<Polygon> {
  /// Create a new [PolygonAnnotationLayer] instance.
  // ignore: prefer_const_constructors_in_immutables
  PolygonAnnotationLayer({
    required List<Polygon> polygons,
    this.color = const Color(0xFF000000),
    this.outlineColor = const Color(0xFF000000),
  }) : super._(list: polygons);

  /// The color of the polygon. Defaults to black.
  final Color color;

  /// The opacity at which the polygon will be drawn.
  double get opacity => color.opacity;

  /// The outline color
  final Color outlineColor;

  @override
  Map<String, Object> getPaint() => {
        'fill-color': color.toHexStringNoOpacity(),
        'fill-opacity': color.opacity,
        'fill-outline-color': outlineColor.toHexStringNoOpacity(),
      };

  @override
  Map<String, Object> getLayout() => {};

  @override
  Layer createLayer(int index) => FillLayer(
        id: getLayerId(index),
        sourceId: getSourceId(index),
        paint: getPaint(),
        layout: getLayout(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is PolygonAnnotationLayer &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          outlineColor == other.outlineColor &&
          const DeepCollectionEquality().equals(list, other.list);

  late final int? _cachedHashCode;

  @override
  int get hashCode => _cachedHashCode ??=
      super.hashCode ^ color.hashCode ^ outlineColor.hashCode;
}
