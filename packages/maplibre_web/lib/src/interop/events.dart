part of 'interop.dart';

/// The base event for MapLibre
@JS()
extension type MapLibreEvent<T extends JSObject>._(JSObject _)
    implements JSObject {
  external JsMap target;
  external JSString type;
  external T? originalEvent;
}

/// A mouse event on the map.
@JS()
extension type MapMouseEvent._(MapLibreEvent _) implements MapLibreEvent {
  /// Create a new [MapMouseEvent].
  external MapMouseEvent();

  external LngLat lngLat;
  external JSObject originalEvent;
  external Point point;
}

/// Abstract class for type safe event types.
abstract class MapEventType {
  /// Fired when a pointing device (usually a mouse) is pressed and released at
  /// the same point on the map.
  static const click = 'click';

  /// Fired when the right button of the mouse is clicked or the context menu
  /// key is pressed within the map.
  static const contextmenu = 'contextmenu';

  /// Fired when a pointing device (usually a mouse) is pressed and released
  /// twice at the same point on the map in rapid succession.
  ///
  /// Note: Under normal conditions, this event will be preceded by two click
  /// events.
  static const dblclick = 'dblclick';

  /// Fired when the style has been loaded.
  static const load = 'load';

  /// Fired repeatedly during an animated transition from one camera position
  /// to another caused either by flyTo() or user interaction.
  static const move = 'move';

  /// Fired once the map stops moving.
  static const moveEnd = 'moveend';

  /// Fired once the map starts moving.
  static const moveStart = 'movestart';

  /// Fired after the last frame rendered before the map enters an "idle" state:
  //
  // No camera transitions are in progress
  // All currently requested tiles have loaded
  // All fade/transition animations have completed
  static const idle = 'idle';

  /// Called once the style has loaded.
  static const styleLoad = 'style.load';

  /// Fired when any map data (style, source, tile, etc) begins loading or
  /// changing.
  static const data = 'data';

  /// Fired when an error occurs, such as a style change that fails
  /// validation.
  static const error = 'error';

  /// Fired after every frame the map renders.
  static const render = 'render';

  /// Fired when a layer uses an image that the style doesn't have.
  static const styleImageMissing = 'styleimagemissing';

  /// Fired when the WebGL context is lost.
  static const webglContextLost = 'webglcontextlost';

  /// Fired when the WebGL context is restored.
  static const webglContextRestored = 'webglcontextrestored';

  /// Fired when the map switches its projection.
  static const projectionTransition = 'projectiontransition';
}

/// An error event of the map, see [MapEventType.error].
@JS()
extension type MapErrorEvent._(MapLibreEvent _) implements MapLibreEvent {
  /// The error, usually a JS `Error`.
  external JSObject? error;

  /// The source that failed, if a source or tile failed.
  external String? sourceId;
}

/// A JS `Error`.
@JS()
extension type JsError._(JSObject _) implements JSObject {
  /// The error text.
  external String? message;
}

/// A missing image event, see [MapEventType.styleImageMissing].
@JS()
extension type MapStyleImageMissingEvent._(MapLibreEvent _)
    implements MapLibreEvent {
  /// The id of the missing image.
  external String id;
}

/// A projection change, see [MapEventType.projectionTransition].
@JS()
extension type MapProjectionEvent._(MapLibreEvent _) implements MapLibreEvent {
  /// The projection that the map switched to, such as `mercator` or `globe`.
  external JSAny? newProjection;
}

/// A data event of the map, see [MapEventType.data].
@JS()
extension type MapDataEvent._(MapLibreEvent _) implements MapLibreEvent {
  /// The type of data that has changed, `style` or `source`.
  external String dataType;

  /// What changed of a source: `metadata`, `content`, `visibility` or
  /// `idle`.
  external String? sourceDataType;

  /// The source that changed, for a source data event.
  external String? sourceId;
}
