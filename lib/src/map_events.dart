import 'dart:ui';

import 'package:maplibre/maplibre.dart';

/// Base class for all the events emitted by the [MapLibreMap].
///
/// {@category Events}
sealed class MapEvent {
  const MapEvent();
}

/// Emitted when the map style has been loaded.
///
/// {@category Events}
final class MapEventStyleLoaded extends MapEvent {
  /// Create a new [MapEventStyleLoaded] object.
  const MapEventStyleLoaded(this.style);

  /// The loaded style.
  final StyleController style;
}

/// Emitted when the native map view has been created.
///
/// {@category Events}
final class MapEventMapCreated extends MapEvent {
  /// Create a new [MapEventMapCreated] object.
  const MapEventMapCreated({required this.mapController});

  /// The [MapController] of the map. Use it to manipulate the map
  /// programmatically.
  final MapController mapController;
}

/// Emitted when the map camera changes.
///
/// {@category Events}
final class MapEventMoveCamera extends MapEvent {
  /// Create a new [MapEventMoveCamera] object.
  const MapEventMoveCamera({required this.camera});

  /// The new [MapCamera].
  final MapCamera camera;
}

/// Emitted when the map camera changes.
///
/// {@category Events}
final class MapEventStartMoveCamera extends MapEvent {
  /// Create a new [MapEventStartMoveCamera] object.
  const MapEventStartMoveCamera({required this.reason});

  /// The reason the camera is changed.
  final CameraChangeReason reason;
}

/// The reason the camera is changing.
///
/// {@category Events}
enum CameraChangeReason {
  /// The developer programmatically caused the change of the camera.
  developerAnimation,

  /// The camera change is caused by the SDK.
  apiAnimation,

  /// The user caused the camera change by a gesture input.
  apiGesture,
}

/// Emitted when the user interacts with the map in any way. Use this class if
/// you don't care about the type of gesture.
///
/// {@category Events}
sealed class MapEventUserInput extends MapEvent {
  /// Create a new [MapEventUserInput] object.
  const MapEventUserInput({required this.point, required this.screenPoint});

  /// The [Position] of where the user clicked at.
  final Position point;

  /// The screen coordinates in logical pixels where the user interacted with the map.
  final Offset screenPoint;

  @override
  String toString() => 'MapEventUserInput(point: $point)';
}

/// Emitted when the user clicks on the map.
///
/// Supported platforms: all
///
/// {@category Events}
final class MapEventClick extends MapEventUserInput {
  /// Create a new [MapEventClick] object.
  const MapEventClick({required super.point, required super.screenPoint});

  @override
  String toString() => 'MapEventClick(point: $point)';
}

/// Emitted when the user clicks twice in a short amount of time on the map.
///
/// Supported platforms: iOS
///
/// {@category Events}
final class MapEventDoubleClick extends MapEventUserInput {
  /// Create a new [MapEventDoubleClick] object.
  const MapEventDoubleClick({required super.point, required super.screenPoint});

  @override
  String toString() => 'MapEventDoubleClick(point: $point)';
}

/// Emitted when the user clicks with the secondary button on the map. This
/// would be classically the right mouse button.
///
/// Supported platforms: iOS >=13.4, web
///
/// {@category Events}
final class MapEventSecondaryClick extends MapEventUserInput {
  /// Create a new [MapEventSecondaryClick] object.
  const MapEventSecondaryClick({
    required super.point,
    required super.screenPoint,
  });

  @override
  String toString() => 'MapEventSecondaryClick(point: $point)';
}

/// Emitted when the user clicks on the map and holds button down at the same
/// location for some time.
///
/// Supported platforms: Android, iOS
///
/// {@category Events}
final class MapEventLongClick extends MapEventUserInput {
  /// Create a new [MapEventLongClick] object.
  const MapEventLongClick({required super.point, required super.screenPoint});

  @override
  String toString() => 'MapEventLongClick(point: $point)';
}

/// Emitted when the map enters an idle state.
///
/// No camera transitions are in progress, all currently requested tiles have
/// loaded and all fade/transition animations have completed.
///
/// {@category Events}
final class MapEventIdle extends MapEvent {
  /// Create a new [MapEventIdle] object.
  const MapEventIdle();
}

/// Emitted when the map camera enters an idle state.
///
/// No changes to the map camera though gestures or camera transitions are
/// in progress.
///
/// {@category Events}
final class MapEventCameraIdle extends MapEvent {
  /// Create a new [MapEventCameraIdle] object.
  const MapEventCameraIdle();
}
