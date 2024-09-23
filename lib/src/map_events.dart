import 'package:maplibre/maplibre.dart';

/// Base class for all the events emitted by the [MapLibreMap].
sealed class MapEvent {
  const MapEvent();
}

/// Emitted when the map style has been loaded.
final class MapEventStyleLoaded extends MapEvent {
  /// Create a new [MapEventStyleLoaded] object.
  const MapEventStyleLoaded();
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
final class MapEventCameraMoved extends MapEvent {
  /// Create a new [MapEventCameraMoved] object.
  const MapEventCameraMoved({required this.camera});

  /// The new [MapCamera].
  final MapCamera camera;
}

/// Emitted when the user interacts with the map in any way. Use this class if
/// you don't care about the type of gesture.
sealed class MapEventUserInput extends MapEvent {
  /// Create a new [MapEventUserInput] object.
  const MapEventUserInput({required this.point});

  /// The [Position] of where the user clicked at.
  final Position point;
}

/// Emitted when the user clicks on the map.
final class MapEventClicked extends MapEventUserInput {
  /// Create a new [MapEventClicked] object.
  const MapEventClicked({required super.point});
}

/// Emitted when the user clicks twice in a short amount of time on the map.
final class MapEventDoubleClicked extends MapEventUserInput {
  /// Create a new [MapEventDoubleClicked] object.
  const MapEventDoubleClicked({required super.point});
}

/// Emitted when the user clicks with the secondary button on the map. This
/// would be classically the right mouse button.
final class MapEventSecondaryClicked extends MapEventUserInput {
  /// Create a new [MapEventSecondaryClicked] object.
  const MapEventSecondaryClicked({required super.point});
}

/// Emitted when the user clicks on the map and holds button down at the same
/// location for some time.
final class MapEventLongClicked extends MapEventUserInput {
  /// Create a new [MapEventLongClicked] object.
  const MapEventLongClicked({required super.point});
}

/// Emitted when the map enters an idle state.
///
/// No camera transitions are in progress, all currently requested tiles have
/// loaded and all fade/transition animations have completed.
final class MapEventIdle extends MapEvent {
  /// Create a new [MapEventIdle] object.
  const MapEventIdle();
}
