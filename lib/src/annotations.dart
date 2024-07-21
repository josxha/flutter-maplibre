import 'dart:ui';

import 'package:maplibre/maplibre.dart';

sealed class Annotation {
  const Annotation();
}

class Marker extends Annotation {
  const Marker({
    required this.point,
    this.color,
    this.draggable = false,
  });

  final Position point;
  final Color? color;
  final bool draggable;
}

class Polyline extends Annotation {}
