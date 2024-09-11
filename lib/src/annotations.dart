import 'dart:ui';

import 'package:maplibre/maplibre.dart';

/// This class is the base for all annotation classes like [Marker].
sealed class Annotation {
  const Annotation();
}

/// A class that contains the properties for a map marker.
class Marker extends Annotation {
  /// Default constructor for a [Marker] instance.
  const Marker({
    required this.point,
    this.color,
    this.draggable = false,
  });

  /// The [Position] of where the [Marker] is located.
  final Position point;

  /// The optional [Color] of the [Marker].
  final Color? color;

  /// Defines if the [Marker] can get dragged around the map.
  final bool draggable;
}

/// A class that contains the properties for a line or multi-line on the map.
class Polyline extends Annotation {}
