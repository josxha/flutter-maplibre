part of 'layer.dart';

/// A [LineString] layer.
///
/// {@category Layers}
@immutable
class PolylineLayer extends Layer<LineString> {
  /// Create a new [PolylineLayer] instance.
  const PolylineLayer({
    required List<Feature<LineString>> polylines,
    this.color = const Color(0xFF000000),
    this.width = 1,
    this.gapWidth = 0,
    this.blur = 0,
    this.dashArray,
    super.draggable = false,
    super.sourceId,
    super.layerId,
  }) : super._(list: polylines);

  /// The color of the polyline. Defaults to black
  final Color color;

  /// The opacity at which the polyline will be drawn.
  double get opacity => color.a;

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
    'line-color': color.toHexString(alpha: false),
    'line-opacity': opacity,
    'line-width': width,
    'line-gap-width': gapWidth,
    if (dashArray case final List<int> dashArray) 'line-dasharray': dashArray,
  };

  @override
  Map<String, Object> getLayout() => {};

  @override
  StyleLayer createStyleLayer(int index) => LineStyleLayer(
    id: getLayerId(index),
    sourceId: getSourceId(index),
    paint: getPaint(),
    layout: getLayout(),
    draggable: draggable,
  );

  @override
  bool operator ==(covariant PolylineLayer other) {
    if (identical(this, other)) return true;

    return other.color == color &&
        other.width == width &&
        other.gapWidth == gapWidth &&
        other.blur == blur &&
        listEquals(other.dashArray, dashArray) &&
        const DeepCollectionEquality().equals(
          other.list.map((e) => e.geometry?.coordinates).toList(),
          list.map((e) => e.geometry?.coordinates).toList(),
        );
  }

  @override
  int get hashCode {
    return color.hashCode ^
        width.hashCode ^
        gapWidth.hashCode ^
        blur.hashCode ^
        dashArray.hashCode ^
        const DeepCollectionEquality().hash(
          list.map((e) => e.geometry?.coordinates).toList(),
        );
  }
}
