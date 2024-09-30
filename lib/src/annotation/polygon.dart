part of 'annotations.dart';

/// A class that contains the properties for a polygon on the map.
class Fill extends Annotation {
  /// Create a new [Fill] instance.
  const Fill({
    required this.points,
  }) : super._();

  /// The [Position]s of where the [Fill] is located.
  final List<Position> points;
}

/// A [Fill] layer.
class FillAnnotationLayer extends AnnotationLayer<Fill> {
  /// Create a new [FillAnnotationLayer] instance.
  const FillAnnotationLayer({
    required List<Fill> fills,
  }) : super._(list: fills);
}
