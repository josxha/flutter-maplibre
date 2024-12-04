import 'package:maplibre/maplibre.dart';

/// Base class for all the events emitted by the [MapLibreMap].
sealed class MapEvent {
  const MapEvent();
}

/// Emitted when the map style has been loaded.
final class MapEventStyleLoaded extends MapEvent {
  /// Create a new [MapEventStyleLoaded] object.
  const MapEventStyleLoaded(this.style);

  /// The loaded style.
  final StyleController style;
}

/// Emitted when the native map view has been created.
final class MapEventMapCreated extends MapEvent {
  /// Create a new [MapEventMapCreated] object.
  const MapEventMapCreated({required this.mapController});

  /// The [MapController] of the map. Use it to manipulate the map
  /// programmatically.
  final MapController mapController;
}

/// Emitted when the map camera changes.
final class MapEventMoveCamera extends MapEvent {
  /// Create a new [MapEventMoveCamera] object.
  const MapEventMoveCamera({required this.camera});

  /// The new [MapCamera].
  final MapCamera camera;
}

/// Emitted when the map camera changes.
final class MapEventStartMoveCamera extends MapEvent {
  /// Create a new [MapEventStartMoveCamera] object.
  const MapEventStartMoveCamera({required this.reason});

  /// The reason the camera is changed.
  final CameraChangeReason reason;
}

/// The reason the camera is changing.
enum CameraChangeReason {
  /// The developer programmatically caused the change of the camera.
  developerAnimation,

  /// The camera change is caused by the SDK.
  apiAnimation,

  /// The user caused the camera change by a gesture input.
  apiGesture;
}

/// Emitted when the user interact with the map using pointer events.
final class MapEventUserPointerInput extends MapEvent {
  /// Create a new [MapEventUserPointerInput] object.
  const MapEventUserPointerInput({
    required this.eventType,
    required this.position,
  });

  /// The type of the drag event.
  final PointerEventType eventType;

  /// The position of the drag event.
  final Position position;
}

/// The pointer events that can be performed by a user.
enum PointerEventType {
  /// The user pressed down on the screen.
  down,

  /// The user is moving the pointer.
  move,

  /// The user released the pointer.
  up,
}

/// Emitted when the user interacts with the map in any way. Use this class if
/// you don't care about the type of gesture.
sealed class MapEventUserInput extends MapEvent {
  /// Create a new [MapEventUserInput] object.
  const MapEventUserInput({required this.point});

  /// The [Position] of where the user clicked at.
  final Position point;

  @override
  String toString() => 'MapEventUserInput(point: $point)';
}

/// Emitted when the user clicks on the map.
final class MapEventClick extends MapEventUserInput {
  /// Create a new [MapEventClick] object.
  const MapEventClick({required super.point});

  @override
  String toString() => 'MapEventClick(point: $point)';
}

/// Emitted when the user clicks twice in a short amount of time on the map.
final class MapEventDoubleClick extends MapEventUserInput {
  /// Create a new [MapEventDoubleClick] object.
  const MapEventDoubleClick({required super.point});

  @override
  String toString() => 'MapEventDoubleClick(point: $point)';
}

/// Emitted when the user clicks with the secondary button on the map. This
/// would be classically the right mouse button.
final class MapEventSecondaryClick extends MapEventUserInput {
  /// Create a new [MapEventSecondaryClick] object.
  const MapEventSecondaryClick({required super.point});

  @override
  String toString() => 'MapEventSecondaryClick(point: $point)';
}

/// Emitted when the user clicks on the map and holds button down at the same
/// location for some time.
final class MapEventLongClick extends MapEventUserInput {
  /// Create a new [MapEventLongClick] object.
  const MapEventLongClick({required super.point});

  @override
  String toString() => 'MapEventLongClick(point: $point)';
}

/// Emitted when the map enters an idle state.
///
/// No camera transitions are in progress, all currently requested tiles have
/// loaded and all fade/transition animations have completed.
final class MapEventIdle extends MapEvent {
  /// Create a new [MapEventIdle] object.
  const MapEventIdle();
}

/// Emitted when the map camera enters an idle state.
///
/// No changes to the map camera though gestures or camera transitions are
/// in progress.
final class MapEventCameraIdle extends MapEvent {
  /// Create a new [MapEventCameraIdle] object.
  const MapEventCameraIdle();
}
