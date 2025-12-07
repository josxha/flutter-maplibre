import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:maplibre/src/interaction/interaction_handler.dart';
import 'package:maplibre/src/map_camera_tween.dart';
import 'package:maplibre/src/map_state.dart';

/// Handles keyboard interactions.
class KeyboardHandler extends InteractionHandler {
  /// Creates a keyboard interaction handler with the given [controller].
  KeyboardHandler(super.controller);

  /// [MapLibreMapState.initState]
  void initState() {
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
  }

  /// [MapLibreMapState.dispose]
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
  }

  /// Called when the animation status is completed.
  void onAnimationStatusCompleted() {
    // restart animation if arrow keys are still pressed
    _updateKeyboardAnimation();
  }

  bool _handleKeyEvent(KeyEvent event) {
    // debugPrint('Keyboard event: $event');
    final arrowKeys = {
      PhysicalKeyboardKey.arrowUp,
      PhysicalKeyboardKey.arrowDown,
      PhysicalKeyboardKey.arrowLeft,
      PhysicalKeyboardKey.arrowRight,
    };
    if (arrowKeys.contains(event.physicalKey)) {
      switch (event) {
        case KeyDownEvent():
          _updateKeyboardAnimation();
          return true;
        case KeyUpEvent():
          _updateKeyboardAnimation();
          return true;
      }
    }
    return false;
  }

  void _updateKeyboardAnimation() {
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
      controller.animationController.stop();
      return;
    }

    // normalize direction
    direction = Offset.fromDirection(direction.direction);
    final camera = this.camera!;
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
  }
}
