import 'package:flutter/cupertino.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/annotation/extensions.dart';
import 'package:collection/collection.dart';

part 'circle_annotation_layer.dart';
part 'marker_annotation_layer.dart';
part 'polygon_annotation_layer.dart';
part 'polyline_annotation_layer.dart';

/// This class is the base for all annotation layer classes like
/// [MarkerAnnotationLayer].
@immutable
sealed class AnnotationLayer<G extends GeometryType<Object>> {
  const AnnotationLayer._({
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
  Layer createLayer(int index);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnnotationLayer &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(list, other.list);

  @override
  int get hashCode => list.hashCode;
}
