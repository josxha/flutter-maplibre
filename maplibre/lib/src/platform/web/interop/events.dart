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
}

/// Event that fires for example when the context menu is triggered.
@JS()
extension type PointerEvent._(JSObject _) implements JSObject {
  /// Create a new [PointerEvent].
  external PointerEvent();

  /// Prevent the default action associated with the event.
  external JSFunction preventDefault();
}
