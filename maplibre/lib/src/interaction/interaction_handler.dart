import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/map_state.dart';

/// Base class for gesture handlers.
abstract class InteractionHandler {
  /// Creates a gesture handler with the given [controller].
  const InteractionHandler(this.controller);

  /// Reference to the map controller.
  final MapLibreMapState controller;

  /// Accessor to the map options.
  MapOptions get options => controller.options;

  /// Accessor to the current map camera.
  MapCamera get camera => controller.camera ?? controller.getCamera();

  /// Accessor to the map gestures configuration.
  MapGestures get gestures => options.gestures;

  /// Emits a [MapEventStartMoveCamera].
  void emitMoveStartEvent() => controller.widget.onEvent?.call(
    const MapEventStartMoveCamera(reason: CameraChangeReason.apiGesture),
  );

  /// Emits a [MapEventCameraIdle].
  void emitCameraIdleEvent() =>
      controller.widget.onEvent?.call(const MapEventCameraIdle());
}
