part of 'annotations.dart';

/// A [LineString] layer.
class PolylineAnnotationLayer extends AnnotationLayer<LineString> {
  /// Create a new [PolylineAnnotationLayer] instance.
  const PolylineAnnotationLayer({
    required List<LineString> polylines,
  }) : super._(list: polylines);
}
