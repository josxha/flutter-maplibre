part of 'interop.dart';

/// The base event for MapLibre
@JS()
extension type MapLibreEvent<T extends JSObject>._(JSObject _)
    implements JSObject {
  external Map target;
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

  /// Fired once the map stops moving.
  static const moveEnd = 'moveend';
}
