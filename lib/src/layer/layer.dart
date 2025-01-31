import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/layer/extensions.dart';

part 'circle_layer.dart';
part 'marker_layer.dart';
part 'polygon_layer.dart';
part 'polyline_layer.dart';

/// This class is the base for all annotation layer classes like
/// [MarkerLayer].
///
/// {@category Layers}
@immutable
sealed class Layer<G extends GeometryObject> {
  const Layer._({
    required this.list,
    this.draggable = false,
  });

  /// The [List] of layers.
  final List<Feature<G>> list;

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

  /// Whether the layer is draggable.
  /// Default is `false` to prevent accidental dragging and performance issues.
  final bool draggable;

  /// Create a [Feature] list from a list of [G]s.
  static List<Feature<G>> generateFeatureList<G extends GeometryObject>(
    List<G> geometries,
  ) {
    final list = <Feature<G>>[];
    for (final (index, point) in geometries.indexed) {
      list.add(Feature(id: index, geometry: point));
    }
    return list;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Layer &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(list, other.list);

  @override
  int get hashCode => const DeepCollectionEquality().hash(list);
}
