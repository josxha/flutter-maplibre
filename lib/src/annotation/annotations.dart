import 'package:flutter/cupertino.dart';
import 'package:maplibre/maplibre.dart';

part 'circle.dart';
part 'marker.dart';
part 'polygon.dart';
part 'polyline.dart';

/// This class is the base for all annotation classes like [Point] or
/// [LineString].
@immutable
sealed class Annotation {
  const Annotation._();
}

/// This class is the base for all annotation layer classes like [MarkerAnnotationLayer].
sealed class AnnotationLayer<G extends GeometryType<Object>> {
  const AnnotationLayer._({required this.list});

  /// The [List] of [Annotation]s.
  final List<G> list;
}
