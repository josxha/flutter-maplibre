import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/interaction/interaction_handler.dart';
import 'package:maplibre/src/map_camera_tween.dart';

/// Handles tap and double-tap interactions on the map.
class TapHandler extends InteractionHandler {
  /// Creates a [TapHandler] instance.
  TapHandler(super.controller);

  TapDownDetails? _tapDownDetails;
  TapDownDetails? _secondaryTapDownDetails;

  /// [GestureDetector.onDoubleTap]
  void onDoubleTap() {
    // debugPrint('Double tap detected');
    final details = controller.doubleTapDownDetails;
    controller.doubleTapDownDetails = null;
    if (details == null) return;

    final event = MapEventDoubleClick(
      point: controller.toLngLat(details.localPosition),
      screenPoint: details.localPosition,
    );
    controller.widget.onEvent?.call(event);

    if (options.gestures.zoom) {
      final camera = this.camera;
      final newCenter = (controller.targetCamera?.center ?? camera.center)
          .intermediatePointTo(
            controller.toLngLat(details.localPosition),
            fraction: 0.5,
          );

      // zoom in on double tap
      final tweens = MapCameraTween(
        begin: camera,
        end: camera.copyWith(
          zoom: camera.zoom + 1,
          center: newCenter,
        ),
      );
      controller.animation = tweens.animate(
        CurvedAnimation(
          parent: controller.animationController,
          curve: Curves.easeInOut,
        ),
      );
      emitMoveStartEvent();
      controller.animationController
        ..duration = const Duration(milliseconds: 300)
        ..forward(from: 0);
    }
  }

  /// [GestureDetector.onDoubleTapDown]
  // ignore: use_setters_to_change_properties
  void onDoubleTapDown(TapDownDetails details) {
    // zoom in or out on double tap down
    // debugPrint('Double tap down at position: ${details.localPosition}');
    controller.doubleTapDownDetails = details;
  }

  /// [GestureDetector.onDoubleTapCancel]
  void onDoubleTapCancel() {
    // debugPrint('Double tap cancelled');
  }

  /// [GestureDetector.onTapDown]
  // ignore: use_setters_to_change_properties
  void onTapDown(TapDownDetails details) {
    _tapDownDetails = details;
  }

  /// [GestureDetector.onTap]
  void onTap() {
    debugPrint('Tap detected');
    final details = _tapDownDetails;
    if (details == null) return;
    controller.widget.onEvent?.call(
      MapEventClick(
        point: controller.toLngLat(details.localPosition),
        screenPoint: details.localPosition,
      ),
    );
  }

  /// [GestureDetector.onTapCancel]
  void onTapCancel() {
    debugPrint('Tap cancelled');
  }

  /// [GestureDetector.onSecondaryTapDown]
  // ignore: use_setters_to_change_properties
  void onSecondaryTapDown(TapDownDetails details) {
    _secondaryTapDownDetails = details;
  }

  /// [GestureDetector.onSecondaryTap]
  void onSecondaryTap() {
    final details = _secondaryTapDownDetails;
    if (details == null) return;
    final event = MapEventClick(
      point: controller.toLngLat(details.localPosition),
      screenPoint: details.localPosition,
    );
    controller.widget.onEvent?.call(event);
  }
}
