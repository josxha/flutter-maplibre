import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/src/interaction/interaction_handler.dart';
import 'package:maplibre/src/map_camera_tween.dart';

/// Handles mouse scroll wheel zooming.
class ScrollWheelZoomHandler extends InteractionHandler {
  /// Creates a scroll wheel zoom handler with the given [controller].
  ScrollWheelZoomHandler(super.controller);

  /// [Listener.onPointerSignal]
  void onPointerScrollSignal(PointerScrollEvent event) {
    // debugPrint('Scroll wheel event: ${event.scrollDelta.dy}');
    if (!options.gestures.zoom) return;

    final currCamera = camera;
    final zoomChange = -event.scrollDelta.dy / 300; // sensitivity
    final prevTarget = controller.targetCamera ?? currCamera;

    var targetZoom = prevTarget.zoom;
    if (options.gestures.zoom) {
      targetZoom = prevTarget.zoom + zoomChange;
    }
    var targetCenter = prevTarget.center;
    if (options.gestures.pan) {
      targetCenter = prevTarget.center.intermediatePointTo(
        controller.toLngLat(event.localPosition),
        fraction: zoomChange > 0 ? 0.2 : -0.2,
      );
    }
    final targetCamera = controller.targetCamera = currCamera.copyWith(
      zoom: targetZoom,
      center: targetCenter,
    );
    final tweens = MapCameraTween(begin: currCamera, end: targetCamera);
    if (!controller.animationController.isAnimating) {
      emitMoveStartEvent();
    }
    controller.animation = tweens.animate(
      CurvedAnimation(
        parent: controller.animationController,
        curve: Curves.easeOut,
      ),
    );
    controller.animationController.forward(from: 0);
  }
}
