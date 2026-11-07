import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// This class is the base for all annotation layer classes.
///
/// [onClick] reports taps and clicks on the features of the layer, and
/// [onEnter] and [onLeave] report the mouse moving over them. Set
/// [draggable] to let the user drag the features of the layer, and save
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
    this.onClick,
    this.onEnter,
    this.onLeave,
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
  final LayerFeatureCallback? onDragStart;

  /// Called whenever the user drags a feature of the layer further, with
  /// where it moves to. Needs [draggable].
  final LayerFeatureCallback? onDrag;

  /// Called when the user drops a feature of the layer, with where it was
  /// dropped. Save the feature there in [list] to keep it there. Needs
  /// [draggable].
  final LayerFeatureCallback? onDragEnd;

  /// Called when the user taps or clicks a feature of the layer.
  ///
  /// Of several features at that point, the one of the topmost layer is
  /// reported, and of several points of a layer, the nearest. A tap next to
  /// a small feature still hits it. [MapLibreMap.onClick] is called as well.
  final LayerFeatureCallback? onClick;

  /// Called when a mouse or stylus moves onto a feature of the layer, or
  /// from one feature of the layer onto another.
  ///
  /// Of overlapping features of the layer, the topmost one counts. Touches
  /// don't hover, so this is called for mice and styluses only.
  final LayerFeatureCallback? onEnter;

  /// Called when a mouse or stylus leaves the feature of the layer that
  /// [onEnter] reported, with that feature.
  final LayerFeatureCallback? onLeave;

  /// Whether the user can interact with the features of the layer: it is
  /// [draggable], or one of [onClick], [onEnter] and [onLeave] is set.
  bool get interactive =>
      draggable || onClick != null || onEnter != null || onLeave != null;

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
          draggable == other.draggable &&
          interactive == other.interactive;

  @override
  int get hashCode =>
      Object.hash(minZoom, maxZoom, list, draggable, interactive);
}

/// Called with a [LayerFeatureEvent] when the user interacts with a feature
/// of a [Layer].
///
/// {@category Layers}
typedef LayerFeatureCallback = void Function(LayerFeatureEvent event);

/// The user tapped, hovered or dragged a feature of a [Layer], see
/// [Layer.onClick], [Layer.onEnter] and [Layer.onDrag].
///
/// {@category Layers}
@immutable
class LayerFeatureEvent {
  /// Creates a [LayerFeatureEvent].
  const LayerFeatureEvent({
    required this.index,
    required this.geometry,
    required this.point,
    required this.screenPoint,
  });

  /// The index of the feature in [Layer.list].
  final int index;

  /// The geometry of the feature. While it is dragged, the geometry moved to
  /// where it is dragged.
  ///
  /// A dragged feature moves by the distance on screen that the pointer
  /// moved, so it keeps its place under the pointer.
  final Geometry geometry;

  /// For a dragged [Point] feature, where it moves to. Otherwise, where the
  /// pointer is.
  final Geographic point;

  /// [point] in logical pixels of the map.
  final Offset screenPoint;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LayerFeatureEvent &&
          index == other.index &&
          geometry == other.geometry &&
          point == other.point &&
          screenPoint == other.screenPoint;

  @override
  int get hashCode => Object.hash(index, geometry, point, screenPoint);

  @override
  String toString() =>
      'LayerFeatureEvent(index: $index, point: $point, screenPoint: $screenPoint)';
}
