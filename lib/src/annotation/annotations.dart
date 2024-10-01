import 'package:flutter/cupertino.dart';
import 'package:maplibre/maplibre.dart';

part 'circle.dart';
part 'marker.dart';
part 'polyline.dart';
part 'polygon.dart';

/// This class is the base for all annotation classes like [MarkerAnnotation].
@immutable
sealed class Annotation {
  const Annotation._();
}

/// This class is the base for all annotation layer classes like [MarkerAnnotationLayer].
sealed class AnnotationLayer<A extends Annotation> {
  const AnnotationLayer._({required this.list});

  /// The [List] of [Annotation]s.
  final List<A> list;
}
