import 'dart:ui';

import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Base class of the events that a [MapLibreMap] reports through its `on…`
/// callbacks.
///
/// {@category Events}
sealed class MapEvent {
  const MapEvent();
}

/// Callback of a [MapLibreMap] event of type [T].
///
/// {@category Basic}
/// {@category Events}
typedef MapEventCallback<T extends MapEvent> = void Function(T event);

// Camera

/// Why the camera moves.
///
/// {@category Events}
enum CameraChangeReason {
  /// The user moves the map with a gesture.
  gesture,

  /// The app moves the camera through the [MapController], for example with
  /// [MapController.animateCamera].
  programmatic,

  /// The map moves the camera by itself, for example to the camera of a new
  /// style or to keep it within [MapOptions.maxBounds].
  map,
}

/// The camera starts to move, see [MapLibreMap.onCameraMoveStart].
///
/// {@category Events}
final class MapEventCameraMoveStart extends MapEvent {
  /// Creates a [MapEventCameraMoveStart].
  const MapEventCameraMoveStart({required this.reason});

  /// Why the camera moves.
  final CameraChangeReason reason;

  @override
  String toString() => 'MapEventCameraMoveStart(reason: $reason)';
}

/// The camera moved, see [MapLibreMap.onCameraMove].
///
/// {@category Events}
final class MapEventCameraMove extends MapEvent {
  /// Creates a [MapEventCameraMove].
  const MapEventCameraMove({required this.camera, required this.reason});

  /// The new camera.
  final CameraPosition camera;

  /// Why the camera moves.
  final CameraChangeReason reason;

  @override
  String toString() => 'MapEventCameraMove(camera: $camera, reason: $reason)';
}

/// The camera stopped moving, see [MapLibreMap.onCameraMoveEnd].
///
/// {@category Events}
final class MapEventCameraMoveEnd extends MapEvent {
  /// Creates a [MapEventCameraMoveEnd].
  const MapEventCameraMoveEnd({required this.camera, required this.reason});

  /// The camera that the move ended at.
  final CameraPosition camera;

  /// Why the camera moved.
  final CameraChangeReason reason;

  @override
  String toString() =>
      'MapEventCameraMoveEnd(camera: $camera, reason: $reason)';
}

// User input

/// The user tapped, clicked, dragged or hovered the map. Use this class if you don't
/// care about the kind of input.
///
/// {@category Events}
sealed class MapEventUserInput extends MapEvent {
  /// Creates a [MapEventUserInput].
  const MapEventUserInput({required this.point, required this.screenPoint});

  /// The location that the user tapped, clicked or dragged.
  final Geographic point;

  /// Where the user tapped, clicked or dragged, in logical pixels of the map.
  final Offset screenPoint;

  String get _name;

  @override
  String toString() => '$_name(point: $point, screenPoint: $screenPoint)';
}

/// The user tapped or clicked the map, see [MapLibreMap.onClick].
///
/// {@category Events}
final class MapEventClick extends MapEventUserInput {
  /// Creates a [MapEventClick].
  const MapEventClick({required super.point, required super.screenPoint});

  @override
  String get _name => 'MapEventClick';
}

/// The user tapped or clicked the map twice in quick succession, see
/// [MapLibreMap.onDoubleClick].
///
/// {@category Events}
final class MapEventDoubleClick extends MapEventUserInput {
  /// Creates a [MapEventDoubleClick].
  MapEventDoubleClick({required super.point, required super.screenPoint});

  var _defaultPrevented = false;

  /// Whether [preventDefault] was called.
  bool get defaultPrevented => _defaultPrevented;

  /// Keeps the map from zooming in on this double tap, or from zooming with
  /// the drag that follows it, as in MapLibre GL JS.
  ///
  /// Call it in [MapLibreMap.onDoubleClick], or before the [Future] that the
  /// callback returns completes.
  void preventDefault() => _defaultPrevented = true;

  @override
  String get _name => 'MapEventDoubleClick';
}

/// The user clicked the map with the secondary mouse button, usually the
/// right one, see [MapLibreMap.onSecondaryClick].
///
/// {@category Events}
final class MapEventSecondaryClick extends MapEventUserInput {
  /// Creates a [MapEventSecondaryClick].
  const MapEventSecondaryClick({
    required super.point,
    required super.screenPoint,
  });

  @override
  String get _name => 'MapEventSecondaryClick';
}

/// The user pressed the map at one location for a while, see
/// [MapLibreMap.onLongClick].
///
/// {@category Events}
final class MapEventLongClick extends MapEventUserInput {
  /// Creates a [MapEventLongClick].
  const MapEventLongClick({required super.point, required super.screenPoint});

  @override
  String get _name => 'MapEventLongClick';
}

/// The mouse or a stylus moved over the map without a pressed button, see
/// [MapLibreMap.onPointerMove]. Touches don't hover, so this is reported
/// for mice and styluses only.
///
/// {@category Events}
final class MapEventPointerMove extends MapEventUserInput {
  /// Creates a [MapEventPointerMove].
  const MapEventPointerMove({required super.point, required super.screenPoint});

  @override
  String get _name => 'MapEventPointerMove';
}

/// The mouse or a stylus left the map, see [MapLibreMap.onPointerLeave].
///
/// {@category Events}
final class MapEventPointerLeave extends MapEvent {
  /// Creates a [MapEventPointerLeave].
  const MapEventPointerLeave();

  @override
  String toString() => 'MapEventPointerLeave()';
}

/// The user started to drag the map with one finger or the primary mouse
/// button, see [MapLibreMap.onDragStart].
///
/// [point] and [screenPoint] are where the drag went down.
///
/// {@category Events}
final class MapEventDragStart extends MapEventUserInput {
  /// Creates a [MapEventDragStart].
  MapEventDragStart({required super.point, required super.screenPoint});

  var _defaultPrevented = false;

  /// Whether [preventDefault] was called.
  bool get defaultPrevented => _defaultPrevented;

  /// Keeps this drag from panning the map, for example to move a feature
  /// instead. [MapLibreMap.onDrag] and [MapLibreMap.onDragEnd] still follow.
  ///
  /// Call it in [MapLibreMap.onDragStart], or before the [Future] that the
  /// callback returns completes. A layer with [Layer.onDrag] calls it when
  /// the drag starts on one of its features.
  void preventDefault() => _defaultPrevented = true;

  @override
  String get _name => 'MapEventDragStart';
}

/// The pointer of a drag moved, see [MapLibreMap.onDrag].
///
/// {@category Events}
final class MapEventDrag extends MapEventUserInput {
  /// Creates a [MapEventDrag].
  const MapEventDrag({required super.point, required super.screenPoint});

  @override
  String get _name => 'MapEventDrag';
}

/// A drag ended, see [MapLibreMap.onDragEnd].
///
/// [point] and [screenPoint] are where the pointer was last.
///
/// {@category Events}
final class MapEventDragEnd extends MapEventUserInput {
  /// Creates a [MapEventDragEnd].
  const MapEventDragEnd({required super.point, required super.screenPoint});

  @override
  String get _name => 'MapEventDragEnd';
}

// Loading and errors

/// The map is idle, see [MapLibreMap.onIdle].
///
/// {@category Events}
final class MapEventIdle extends MapEvent {
  /// Creates a [MapEventIdle].
  const MapEventIdle();

  @override
  String toString() => 'MapEventIdle()';
}

/// What failed, see [MapEventError].
///
/// {@category Events}
enum MapErrorKind {
  /// The style failed to load.
  style,

  /// A source, or one of its tiles, failed to load.
  source,

  /// Glyphs of a font failed to load or parse.
  glyphs,

  /// A sprite failed to load or parse.
  sprite,

  /// The map failed to render.
  render,

  /// Any other failure.
  other,
}

/// Something failed to load or render, see [MapLibreMap.onError].
///
/// {@category Events}
final class MapEventError extends MapEvent {
  /// Creates a [MapEventError].
  const MapEventError({
    required this.kind,
    required this.message,
    this.sourceId,
  });

  /// What failed.
  final MapErrorKind kind;

  /// The error text of the platform.
  final String message;

  /// The source that failed, if the platform names one.
  final String? sourceId;

  @override
  String toString() =>
      'MapEventError(kind: $kind, message: $message, sourceId: $sourceId)';
}

/// A layer uses an image that the style doesn't have, see
/// [MapLibreMap.onStyleImageMissing].
///
/// {@category Events}
final class MapEventStyleImageMissing extends MapEvent {
  /// Creates a [MapEventStyleImageMissing].
  const MapEventStyleImageMissing({required this.id});

  /// The id of the missing image.
  final String id;

  @override
  String toString() => 'MapEventStyleImageMissing(id: $id)';
}

/// The map starts to load a style, see [MapLibreMap.onLoadingStarted].
///
/// {@category Events}
final class MapEventLoadingStarted extends MapEvent {
  /// Creates a [MapEventLoadingStarted].
  const MapEventLoadingStarted();

  @override
  String toString() => 'MapEventLoadingStarted()';
}

/// The map loaded its style and what the view needs, see
/// [MapLibreMap.onLoadingFinished].
///
/// {@category Events}
final class MapEventLoadingFinished extends MapEvent {
  /// Creates a [MapEventLoadingFinished].
  const MapEventLoadingFinished();

  @override
  String toString() => 'MapEventLoadingFinished()';
}

/// A source of the style changed, see [MapLibreMap.onSourceChanged].
///
/// {@category Events}
final class MapEventSourceChanged extends MapEvent {
  /// Creates a [MapEventSourceChanged].
  const MapEventSourceChanged({required this.sourceId});

  /// The id of the source.
  final String sourceId;

  @override
  String toString() => 'MapEventSourceChanged(sourceId: $sourceId)';
}

/// A step of loading a tile, see [MapEventTile].
///
/// {@category Events}
enum MapTileOperation {
  /// The tile is requested from the cache.
  requestedFromCache,

  /// The tile is requested from the network.
  requestedFromNetwork,

  /// The tile arrived from the network.
  loadFromNetwork,

  /// The tile arrived from the cache.
  loadFromCache,

  /// The tile starts to be parsed.
  startParse,

  /// The tile was parsed.
  endParse,

  /// The tile failed to load or parse.
  error,

  /// The tile request was cancelled.
  cancelled,
}

/// A tile moved to another step of loading, see [MapLibreMap.onTile].
///
/// {@category Events}
final class MapEventTile extends MapEvent {
  /// Creates a [MapEventTile].
  const MapEventTile({
    required this.operation,
    required this.sourceId,
    required this.z,
    required this.x,
    required this.y,
    required this.overscaledZ,
    required this.wrap,
  });

  /// The step that the tile reached.
  final MapTileOperation operation;

  /// The source that the tile belongs to.
  final String sourceId;

  /// The zoom level of the tile in the source's grid.
  final int z;

  /// The column of the tile in the source's grid.
  final int x;

  /// The row of the tile in the source's grid.
  final int y;

  /// The zoom that the map draws the tile at. Greater than [z] when the
  /// source has no tiles that deep.
  final int overscaledZ;

  /// The copy of the world that holds the tile: 0 for the main one, negative
  /// to the west, positive to the east.
  final int wrap;

  @override
  String toString() =>
      'MapEventTile(operation: $operation, sourceId: $sourceId, '
      'tile: $z/$x/$y, overscaledZ: $overscaledZ, wrap: $wrap)';
}

/// Statistics of a rendered frame, see [MapEventRenderFrame].
///
/// {@category Events}
final class MapRenderingStats {
  /// Creates [MapRenderingStats].
  const MapRenderingStats({
    required this.encodingTime,
    required this.renderingTime,
    required this.drawCalls,
  });

  /// The time spent encoding the frame's GPU commands.
  final Duration encodingTime;

  /// The time spent rendering the frame.
  final Duration renderingTime;

  /// The number of draw calls of the frame.
  final int drawCalls;

  @override
  String toString() =>
      'MapRenderingStats(encodingTime: $encodingTime, '
      'renderingTime: $renderingTime, drawCalls: $drawCalls)';
}

/// The map rendered a frame, see [MapLibreMap.onRenderFrame].
///
/// {@category Events}
final class MapEventRenderFrame extends MapEvent {
  /// Creates a [MapEventRenderFrame].
  const MapEventRenderFrame({this.fullyRendered, this.stats});

  /// Whether the frame shows everything the view needs, or null where the
  /// platform doesn't tell. A frame is partial while tiles still load.
  final bool? fullyRendered;

  /// The frame's statistics, or null where the platform has none.
  final MapRenderingStats? stats;

  @override
  String toString() =>
      'MapEventRenderFrame(fullyRendered: $fullyRendered, stats: $stats)';
}

/// The map finished rendering a view, see [MapLibreMap.onRenderMap].
///
/// {@category Events}
final class MapEventRenderMap extends MapEvent {
  /// Creates a [MapEventRenderMap].
  const MapEventRenderMap({required this.fullyRendered});

  /// Whether the map rendered everything the view needs.
  final bool fullyRendered;

  @override
  String toString() => 'MapEventRenderMap(fullyRendered: $fullyRendered)';
}

/// The state of a glyph or sprite request.
///
/// {@category Events}
enum MapResourceState {
  /// The map requested the resource.
  requested,

  /// The resource arrived and was parsed.
  loaded,
}

/// The map requested or loaded glyphs of a font, see [MapLibreMap.onGlyphs].
///
/// {@category Events}
final class MapEventGlyphs extends MapEvent {
  /// Creates a [MapEventGlyphs].
  const MapEventGlyphs({
    required this.state,
    required this.fontStack,
    required this.first,
    required this.last,
  });

  /// Whether the glyphs were requested or loaded.
  final MapResourceState state;

  /// The fonts that the glyphs come from, in the style's order.
  final List<String> fontStack;

  /// The first glyph of the range.
  final int first;

  /// The last glyph of the range, inclusive.
  final int last;

  @override
  String toString() =>
      'MapEventGlyphs(state: $state, fontStack: $fontStack, '
      'first: $first, last: $last)';
}

/// The map requested or loaded a sprite, see [MapLibreMap.onSprite].
///
/// {@category Events}
final class MapEventSprite extends MapEvent {
  /// Creates a [MapEventSprite].
  const MapEventSprite({
    required this.state,
    required this.id,
    required this.url,
  });

  /// Whether the sprite was requested or loaded.
  final MapResourceState state;

  /// The id of the sprite in the style, `default` if the style names one
  /// sprite URL, or empty if it has none.
  final String id;

  /// The sprite URL as the style names it.
  final String url;

  @override
  String toString() => 'MapEventSprite(state: $state, id: $id, url: $url)';
}

// Map state

/// The map stops or resumes rendering, see [MapLibreMap.onRenderingChanged].
///
/// {@category Events}
final class MapEventRenderingChanged extends MapEvent {
  /// Creates a [MapEventRenderingChanged].
  const MapEventRenderingChanged({required this.paused});

  /// Whether the map stopped rendering.
  final bool paused;

  @override
  String toString() => 'MapEventRenderingChanged(paused: $paused)';
}

/// The map changed its size, see [MapLibreMap.onResize].
///
/// {@category Events}
final class MapEventResize extends MapEvent {
  /// Creates a [MapEventResize].
  const MapEventResize({required this.size});

  /// The new size of the map in logical pixels.
  final Size size;

  @override
  String toString() => 'MapEventResize(size: $size)';
}

/// The browser took the map's WebGL context away, see
/// [MapLibreMap.onContextLost].
///
/// {@category Events}
final class MapEventContextLost extends MapEvent {
  /// Creates a [MapEventContextLost].
  const MapEventContextLost();

  @override
  String toString() => 'MapEventContextLost()';
}

/// The browser gave the map's WebGL context back, see
/// [MapLibreMap.onContextRestored].
///
/// {@category Events}
final class MapEventContextRestored extends MapEvent {
  /// Creates a [MapEventContextRestored].
  const MapEventContextRestored();

  @override
  String toString() => 'MapEventContextRestored()';
}

/// The map switched its projection, see [MapLibreMap.onProjectionChanged].
///
/// {@category Events}
final class MapEventProjectionChanged extends MapEvent {
  /// Creates a [MapEventProjectionChanged].
  const MapEventProjectionChanged({required this.projection});

  /// The projection that the map uses now.
  final MapProjection projection;

  @override
  String toString() => 'MapEventProjectionChanged(projection: $projection)';
}
