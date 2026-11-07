import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// This class is the base for all annotation layer classes.
///
/// Set [draggable] to let the user drag the features of the layer, and save
/// where they were dropped with [onDragEnd].
///
/// {@category Layers}
@immutable
abstract class Layer<G extends Feature<Geometry>> {
  /// Creates a [Layer] with the given list of geometry features and optional
  /// zoom levels.
  const Layer({
    required this.list,
    this.minZoom = 0,
    this.maxZoom = 24,
    this.draggable = false,
    this.onDragStart,
    this.onDrag,
    this.onDragEnd,
  }) : assert(
         draggable ||
             (onDragStart == null && onDrag == null && onDragEnd == null),
         'Set draggable to drag the features of the layer.',
       );

  /// The [List] of geometry features.
  final List<G> list;

  /// The minimum zoom level that the [Layer] is displayed.
  final double minZoom;

  /// The maximum zoom level that the [Layer] is displayed.
  final double maxZoom;

  /// Whether the user can drag the features of the layer. Defaults to false.
  ///
  /// A drag that starts on a feature moves the feature instead of the map.
  /// The layer shows the feature where it is dragged without a rebuild, and
  /// puts it back once the drag ends, unless [list] has it at its new place
  /// by then. Save it there in [onDragEnd]:
  ///
  /// ```dart
  /// CircleLayer(
  ///   points: points,
  ///   draggable: true,
  ///   onDragEnd: (event) => setState(
  ///     () => points[event.index] = Feature(geometry: Point(event.point)),
  ///   ),
  /// )
  /// ```
  final bool draggable;

  /// Called when the user starts to drag a feature of the layer. The map
  /// doesn't pan during that drag. Needs [draggable].
  final LayerDragCallback? onDragStart;

  /// Called whenever the user drags a feature of the layer further, with
  /// where it moves to. Needs [draggable].
  final LayerDragCallback? onDrag;

  /// Called when the user drops a feature of the layer, with where it was
  /// dropped. Save the feature there in [list] to keep it there. Needs
  /// [draggable].
  final LayerDragCallback? onDragEnd;

  /// Get a unique source id.
  String getSourceId(int index) => 'maplibre-source-$index';

  /// Get a unique layer id.
  String getLayerId(int index) => 'maplibre-layer-$index';

  /// Add the annotation layer to the map.
  StyleLayer createStyleLayer(int index);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Layer &&
          runtimeType == other.runtimeType &&
          list == other.list &&
          minZoom == other.minZoom &&
          maxZoom == other.maxZoom &&
          draggable == other.draggable;

  @override
  int get hashCode => Object.hash(minZoom, maxZoom, list, draggable);
}

/// Called with a [LayerDragEvent] while the user drags a feature of a
/// [Layer].
///
/// {@category Layers}
typedef LayerDragCallback = void Function(LayerDragEvent event);

/// The user drags a feature of a [Layer], see [Layer.onDrag].
///
/// {@category Layers}
@immutable
class LayerDragEvent {
  /// Creates a [LayerDragEvent].
  const LayerDragEvent({
    required this.index,
    required this.geometry,
    required this.point,
    required this.screenPoint,
  });

  /// The index of the dragged feature in [Layer.list].
  final int index;

  /// The geometry of the dragged feature, moved to where it is dragged.
  ///
  /// It is moved by the distance on screen that the pointer moved, so the
  /// feature keeps its place under the pointer.
  final Geometry geometry;

  /// For a [Point] feature, where it moves to. For other features, where
  /// the pointer is.
  final Geographic point;

  /// [point] in logical pixels of the map.
  final Offset screenPoint;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LayerDragEvent &&
          index == other.index &&
          geometry == other.geometry &&
          point == other.point &&
          screenPoint == other.screenPoint;

  @override
  int get hashCode => Object.hash(index, geometry, point, screenPoint);

  @override
  String toString() =>
      'LayerDragEvent(index: $index, point: $point, screenPoint: $screenPoint)';
}
