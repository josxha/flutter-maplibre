part of 'annotation_layer.dart';

/// A [LineString] layer.
@immutable
class PolylineAnnotationLayer extends AnnotationLayer<LineString> {
  /// Create a new [PolylineAnnotationLayer] instance.
  const PolylineAnnotationLayer({
    required List<LineString> polylines,
    this.color = const Color(0xFF000000),
    this.width = 1,
    this.gapWidth = 0,
    this.blur = 0,
    this.dashArray,
  }) : super._(list: polylines);

  /// The color of the polyline. Defaults to black
  final Color color;

  /// The opacity at which the polyline will be drawn.
  double get opacity => color.opacity;

  /// Stroke thickness.
  final int width;

  /// Stroke thickness.
  final int gapWidth;

  /// Blur applied to the line, in pixels. Defaults to 0.
  final int blur;

  /// Specifies the lengths of the alternating dashes and gaps that form the
  /// dash pattern. The lengths are later scaled by the line width.
  final List<int>? dashArray;

  @override
  Map<String, Object> getPaint() => {
        'line-color': color.toHexStringNoOpacity(),
        'line-opacity': opacity,
        'line-width': width,
        'line-gap-width': gapWidth,
        if (dashArray case final List<int> dashArray)
          'line-dasharray': dashArray,
      };

  @override
  Map<String, Object> getLayout() => {};

  @override
  Layer createLayer(int index) => LineLayer(
        id: getLayerId(index),
        sourceId: getSourceId(index),
        paint: getPaint(),
        layout: getLayout(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is PolylineAnnotationLayer &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          width == other.width &&
          gapWidth == other.gapWidth &&
          blur == other.blur &&
          dashArray == other.dashArray;

  @override
  int get hashCode =>
      Object.hash(super.hashCode, color, width, gapWidth, blur, dashArray);
}
