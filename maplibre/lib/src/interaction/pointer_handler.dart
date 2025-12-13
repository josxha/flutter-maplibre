import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/interaction/interaction_handler.dart';
import 'package:maplibre/src/map_camera_tween.dart';

/// Handles multi-pointer gestures.
class PointerHandler extends InteractionHandler {
  /// Creates a multi-pointer gesture handler with the given [controller].
  PointerHandler(super.controller);

  bool? _isTwoPointerPitch;
  ScaleStartDetails? _onScaleStartEvent;
  ScaleUpdateDetails? _lastScaleUpdateDetails;
  ScaleUpdateDetails? _secondToLastScaleUpdateDetails;

  /// [GestureDetector.onScaleStart]
  void onScaleStart(ScaleStartDetails details) {
    // debugPrint('Scale start: $details');
    _onScaleStartEvent = details;
    emitMoveStartEvent();
  }

  /// [GestureDetector.onScaleUpdate]
  void onScaleUpdate(ScaleUpdateDetails details) {
    // debugPrint('Scale update: $details');
    final camera = this.camera;
    final startEvent = _onScaleStartEvent;
    final pointerDownEvent = controller.pointerDownEvent;
    if (startEvent == null || pointerDownEvent == null) return;
    final doubleTapDown = controller.doubleTapDownDetails;
    final lastEvent = _lastScaleUpdateDetails;
    _secondToLastScaleUpdateDetails = _lastScaleUpdateDetails;
    _lastScaleUpdateDetails = details;
    final ctrlPressed = HardwareKeyboard.instance.isControlPressed;
    final buttons = pointerDownEvent.buttons;
    final lastPointerOffset = lastEvent?.focalPoint ?? startEvent.focalPoint;

    if (doubleTapDown != null && options.gestures.zoom) {
      // double tap drag: zoom
      // debugPrint('Double tap drag zoom detected $doubleTapDown');
      final lastY = lastEvent?.focalPoint.dy ?? startEvent.focalPoint.dy;
      final iOS = Theme.of(controller.context).platform == TargetPlatform.iOS;
      var deltaY = details.focalPoint.dy - lastY;
      if (iOS) deltaY = -deltaY;
      final newZoom = camera.zoom + deltaY * 0.01; // sensitivity
      controller.moveCamera(
        zoom: newZoom.clamp(options.minZoom, options.maxZoom),
      );
    } else if ((buttons & kSecondaryMouseButton) != 0 || ctrlPressed) {
      // secondary button: pitch and bearing
      final delta = details.focalPoint - lastPointerOffset;
      var newBearing = camera.bearing;
      if (options.gestures.rotate) {
        newBearing = camera.bearing + delta.dx * 0.5; // sensitivity
      }
      var newPitch = camera.pitch;
      if (options.gestures.pitch) {
        newPitch = camera.pitch - delta.dy * 0.5; // sensitivity;
      }
      final newZoom = camera.zoom;
      if (options.gestures.zoom) {
        // TODO adjust newZoom for globe projection
      }
      controller.moveCamera(
        bearing: newBearing,
        pitch: newPitch,
        zoom: newZoom,
      );
    } else if ((buttons & kPrimaryMouseButton) != 0) {
      // primary button: pan, zoom, bearing, pinch
      if (_isTwoPointerPitch == null) {
        if (options.gestures.pitch && controller.pointers.length >= 2) {
          final pointers = controller.pointers.values
              .toList(growable: false)
              .take(2)
              .toList(growable: false);
          final delta = pointers.first - pointers.last;
          final pointersAlignedVertically = delta.dy.abs() < delta.dx.abs();
          final movingVertically =
              (details.focalPoint - lastPointerOffset).dy.abs() >
              (details.focalPoint - lastPointerOffset).dx.abs();
          _isTwoPointerPitch = pointersAlignedVertically && movingVertically;
        } else {
          _isTwoPointerPitch = false;
        }
      }
      final pitch = _isTwoPointerPitch!;

      // zoom
      var newZoom = camera.zoom;
      final lastScale = lastEvent?.scale ?? 1.0;
      const scaleSensitivity = 0.9;
      final scaleDelta = (details.scale - lastScale) * scaleSensitivity;
      if (scaleDelta != 0 && options.gestures.zoom && !pitch) {
        newZoom = camera.zoom + scaleDelta;
      }

      // bearing
      var newBearing = camera.bearing;
      final lastRotation = lastEvent?.rotation ?? 0.0;
      final rotationDelta = details.rotation - lastRotation;
      final rotationDegree = rotationDelta * radian2Degree;
      if (options.gestures.rotate && details.rotation != 0.0 && !pitch) {
        newBearing -= rotationDegree;
      }

      // center
      var newCenter = camera.center;
      if (options.gestures.pan && !pitch) {
        final delta = details.focalPoint - lastPointerOffset;
        final centerOffset = controller.toScreenLocation(camera.center);
        var newCenterOffset = centerOffset - delta;
        if (options.gestures.rotate) {
          // rotate around details.focalPoint
          newCenterOffset = Offset(
            cos(-rotationDelta) * (newCenterOffset.dx - details.focalPoint.dx) -
                sin(-rotationDelta) *
                    (newCenterOffset.dy - details.focalPoint.dy) +
                details.focalPoint.dx,
            sin(-rotationDelta) * (newCenterOffset.dx - details.focalPoint.dx) +
                cos(-rotationDelta) *
                    (newCenterOffset.dy - details.focalPoint.dy) +
                details.focalPoint.dy,
          );
        }
        newCenter = controller.toLngLat(newCenterOffset);
        if (options.gestures.zoom) {
          newCenter = newCenter.intermediatePointTo(
            controller.toLngLat(details.focalPoint),
            fraction: scaleDelta * 0.8, // zoom towards focal point
          );
        }
        if (controller.style?.projection == MapProjection.globe) {
          // on globe projection the planet gets rendered as a sphere. A
          // changed latitude affects zoom level so that the visual height of
          // the map remains the same. This represents the amount that the
          // tiles would be stretched horizontally in web mercator projection.
          // TODO implement zoom adjustment for globe projection
        }
      }

      // pitch
      var newPitch = camera.pitch;
      if (options.gestures.pitch && pitch) {
        final delta = details.focalPoint - lastPointerOffset;
        newPitch = camera.pitch - delta.dy * 0.5; // sensitivity;
      }

      controller.moveCamera(
        zoom: newZoom,
        center: newCenter,
        bearing: newBearing,
        pitch: newPitch,
      );
    }
  }

  /// [GestureDetector.onScaleEnd]
  void onScaleEnd(ScaleEndDetails details) {
    // debugPrint('Scale end: $details');
    final camera = this.camera;
    final firstEvent = _onScaleStartEvent;
    final secondToLastEvent = _secondToLastScaleUpdateDetails;
    final lastEvent = _lastScaleUpdateDetails;
    if (firstEvent == null) return;

    // zoom out
    if (lastEvent == null &&
        options.gestures.zoom &&
        firstEvent.pointerCount == 2) {
      var newCenter = camera.center;
      if (options.gestures.pan) {
        newCenter = controller
            .toLngLat(
              firstEvent.focalPoint,
            )
            .intermediatePointTo(camera.center, fraction: 0.2);
      }
      emitMoveStartEvent();
      controller.animateCamera(zoom: camera.zoom - 1, center: newCenter);
    } else if (secondToLastEvent != null &&
        lastEvent != null &&
        options.gestures.pan) {
      // fling animation
      final velocity = details.velocity.pixelsPerSecond.distance;
      if (velocity >= 800) {
        final offset = secondToLastEvent.focalPoint - lastEvent.focalPoint;
        final distance = offset.distance;
        final direction =
            offset.direction * radian2Degree + 90 + camera.bearing;
        final tweens = MapCameraTween(
          begin: camera,
          end: camera.copyWith(
            center: camera.center.destinationPoint2D(
              distance: distance,
              bearing: direction,
            ),
          ),
        );
        controller.animation = tweens.animate(
          CurvedAnimation(
            parent: controller.animationController,
            curve: Curves.easeOut,
          ),
        );
        controller.animationController
          ..duration = Duration(
            milliseconds: (distance / velocity * 1000).round(),
          )
          ..value = 0
          ..fling(
            velocity: velocity / 2000,
            springDescription: SpringDescription.withDampingRatio(
              mass: 1,
              stiffness: 1000,
              ratio: 5,
            ),
          );
      } else {
        // interation ended without fling animation
        emitCameraIdleEvent();
      }
    }

    controller.doubleTapDownDetails = null;
    _onScaleStartEvent = null;
    _lastScaleUpdateDetails = null;
    _secondToLastScaleUpdateDetails = null;
    _isTwoPointerPitch = null;
  }
}
