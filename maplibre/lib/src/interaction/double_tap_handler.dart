import 'package:flutter/widgets.dart';
import 'package:maplibre/src/interaction/interaction_handler.dart';
import 'package:maplibre/src/map_camera_tween.dart';

/// Handles double-tap interactions on the map.
class DoubleTapHandler extends InteractionHandler {
  /// Creates a [DoubleTapHandler] instance.
  DoubleTapHandler(super.controller);

  /// [GestureDetector.onDoubleTap]
  void onDoubleTap() {
    // debugPrint('Double tap detected');

    final details = controller.doubleTapDownDetails;
    controller.doubleTapDownDetails = null;
    if (details == null) return;

    if (options.gestures.zoom) {
      final camera = this.camera!;
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
        CurvedAnimation(parent: controller.animationController, curve: Curves.easeInOut),
      );
      controller.animationController
        ..duration = const Duration(milliseconds: 300)
        ..forward(from: 0);
    }
  }

  /// [GestureDetector.onDoubleTapDown]
  void onDoubleTapDown(TapDownDetails details) {
    // zoom in or out on double tap down
    debugPrint('Double tap down at position: ${details.localPosition}');
    controller.doubleTapDownDetails = details;
  }

  /// [GestureDetector.onDoubleTapCancel]
  void onDoubleTapCancel() {
    debugPrint('Double tap cancelled');
  }
}
