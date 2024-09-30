part of 'annotations.dart';

/// A class that contains the properties for a line on the map.
class Polyline extends Annotation {
  /// Create a new [Polyline] instance.
  const Polyline({
    required this.points,
  }) : super._();

  /// The [Position]s of where the [Polyline] is located.
  final List<Position> points;
}

/// A [Polyline] layer.
class PolylineAnnotationLayer extends AnnotationLayer<Polyline> {
  /// Create a new [PolylineAnnotationLayer] instance.
  const PolylineAnnotationLayer({
    required List<Polyline> polyline,
  }) : super._(list: polyline);
}
