import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/layer/extensions.dart';

part 'circle_layer.dart';
part 'marker_layer.dart';
part 'polygon_layer.dart';
part 'polyline_layer.dart';

/// This class is the base for all annotation layer classes like
/// [MarkerLayer].
@immutable
sealed class Layer<G extends GeometryType<Object>> {
  const Layer._({
    required this.list,
  });

  /// The [List] of annotations.
  final List<G> list;

  /// Get a unique source id.
  String getSourceId(int index) => 'maplibre-source-$index';

  /// Get a unique layer id.
  String getLayerId(int index) => 'maplibre-layer-$index';

  /// Build the paint properties.
  Map<String, Object> getPaint();

  /// Build the layout properties.
  Map<String, Object> getLayout();

  /// Add the annotation layer to the map.
  StyleLayer createStyleLayer(int index);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Layer && runtimeType == other.runtimeType && list == other.list;

  @override
  int get hashCode => list.hashCode;
}
