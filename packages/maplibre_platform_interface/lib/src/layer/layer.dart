import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// This class is the base for all annotation layer classes.
///
/// Set [onDrag] to let the user drag the features of the layer. The layer
/// doesn't move them itself: update [list] with the new position, for
/// example with `setState()`.
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
    this.onDragStart,
    this.onDrag,
    this.onDragEnd,
  });

  /// The [List] of geometry features.
  final List<G> list;

  /// The minimum zoom level that the [Layer] is displayed.
  final double minZoom;

  /// The maximum zoom level that the [Layer] is displayed.
  final double maxZoom;

  /// Called when the user starts to drag a feature of the layer. The map
  /// doesn't pan during that drag.
  final LayerDragCallback? onDragStart;

  /// Called whenever the user drags a feature of the layer further, with
  /// where it moves to. Move the feature there in [list] to follow the drag.
  ///
  /// ```dart
  /// CircleLayer(
  ///   points: points,
  ///   onDrag: (event) => setState(
  ///     () => points[event.index] = Feature(geometry: Point(event.point)),
  ///   ),
  /// )
  /// ```
  final LayerDragCallback? onDrag;

  /// Called when the user stops dragging a feature of the layer.
  final LayerDragCallback? onDragEnd;

  /// Whether the user can drag the features of the layer, which they can
  /// while [onDragStart], [onDrag] or [onDragEnd] is set.
  bool get draggable =>
      onDragStart != null || onDrag != null || onDragEnd != null;

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
          maxZoom == other.maxZoom;

  @override
  int get hashCode => Object.hash(minZoom, maxZoom, list);
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
    required this.point,
    required this.screenPoint,
  });

  /// The index of the dragged feature in [Layer.list].
  final int index;

  /// Where the dragged feature moves to: the pointer location, offset by
  /// where the pointer grabbed a [Point] feature, so that a [Point] feature
  /// keeps its place under the pointer.
  final Geographic point;

  /// [point] in logical pixels of the map.
  final Offset screenPoint;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LayerDragEvent &&
          index == other.index &&
          point == other.point &&
          screenPoint == other.screenPoint;

  @override
  int get hashCode => Object.hash(index, point, screenPoint);

  @override
  String toString() =>
      'LayerDragEvent(index: $index, point: $point, screenPoint: $screenPoint)';
}
