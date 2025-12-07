import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/interaction/interaction_handler.dart';
import 'package:maplibre/src/map_camera_tween.dart';
import 'package:maplibre/src/map_state.dart';

/// Handles keyboard interactions.
class KeyboardHandler extends InteractionHandler {
  /// Creates a keyboard interaction handler with the given [controller].
  KeyboardHandler(super.controller) {
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
  }

  final _arrowKeys = <PhysicalKeyboardKey>{
    PhysicalKeyboardKey.arrowUp,
    PhysicalKeyboardKey.arrowDown,
    PhysicalKeyboardKey.arrowLeft,
    PhysicalKeyboardKey.arrowRight,
  };

  /// [MapLibreMapState.dispose]
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
  }

  /// Called when the animation status is completed. Returns true if the
  /// interation is still ongoing.
  bool onAnimationStatusCompleted() {
    // restart animation if arrow keys are still pressed
    return _updateKeyboardAnimation();
  }

  /// Handles keyboard events. Returns weather the event was handled.
  bool _handleKeyEvent(KeyEvent event) {
    // debugPrint('Keyboard event: $event');
    if (_arrowKeys.contains(event.physicalKey) &&
        (event is KeyDownEvent || event is KeyUpEvent)) {
      _updateKeyboardAnimation();
      return true;
    }
    return false;
  }

  bool _updateKeyboardAnimation() {
    var direction = Offset.zero;
    if (HardwareKeyboard.instance.isPhysicalKeyPressed(
      PhysicalKeyboardKey.arrowUp,
    )) {
      direction += const Offset(0, -1);
    }
    if (HardwareKeyboard.instance.isPhysicalKeyPressed(
      PhysicalKeyboardKey.arrowDown,
    )) {
      direction += const Offset(0, 1);
    }
    if (HardwareKeyboard.instance.isPhysicalKeyPressed(
      PhysicalKeyboardKey.arrowLeft,
    )) {
      direction += const Offset(-1, 0);
    }
    if (HardwareKeyboard.instance.isPhysicalKeyPressed(
      PhysicalKeyboardKey.arrowRight,
    )) {
      direction += const Offset(1, 0);
    }
    if (direction == Offset.zero) {
      controller.animation = null;
      controller.animationController.stop(canceled: false);
      emitCameraIdleEvent();
      return false;
    }

    // normalize direction
    direction = Offset.fromDirection(direction.direction);
    final camera = this.camera;
    if (controller.animation == null) {
      emitMoveStartEvent();
    }
    controller.animation =
        MapCameraTween(
          begin: camera,
          end: camera.copyWith(
            center: controller.toLngLat(
              controller.toScreenLocation(camera.center) + direction * 300,
            ),
          ),
        ).animate(
          CurvedAnimation(
            parent: controller.animationController,
            curve: Curves.linear,
          ),
        );
    controller.animationController
      ..duration = const Duration(seconds: 1)
      ..forward(from: 0);
    return true;
  }
}
