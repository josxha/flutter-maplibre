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

/// Emitted when the map movement comes to an end.
final class MapEventMovementStopped extends MapEvent {
  /// Create a new [MapEventMovementStopped] object.
  const MapEventMovementStopped();
}
