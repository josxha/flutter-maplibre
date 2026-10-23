import 'dart:async';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';

/// Meters per degree of latitude.
const _metersPerDegree = 111320.0;

/// Shows the user location on the [MapLibreMap] by using it in
/// [MapLibreMap.children], and moves the camera with it while [tracking].
///
/// The layer takes its locations from a stream, so it works the same on
/// every platform and with any location source. It asks for no permission;
/// use a package such as `permission_handler` or `geolocator` for that, and
/// `maplibre_geolocator` to turn `geolocator` positions into locations.
///
/// A drag or scroll wheel zoom on the map stops the tracking and reports
/// [UserLocationTracking.none] to [onTrackingChanged].
///
/// {@category Location}
class UserLocationLayer extends StatefulWidget {
  /// Creates a layer that shows the latest of [locations].
  const UserLocationLayer({
    required this.locations,
    this.tracking = UserLocationTracking.none,
    this.onTrackingChanged,
    this.trackingZoom,
    this.trackingDuration = const Duration(milliseconds: 500),
    this.color = const Color(0xFF1A73E8),
    this.radius = 8,
    super.key,
  });

  /// The locations of the user. The layer shows the latest one.
  final Stream<UserLocation> locations;

  /// How the camera moves with the user location.
  final UserLocationTracking tracking;

  /// Called when the tracking changes because the user moved the map.
  final ValueChanged<UserLocationTracking>? onTrackingChanged;

  /// The zoom the camera moves to when the tracking starts, or null to keep
  /// the zoom.
  final double? trackingZoom;

  /// How long the camera takes to follow a new location.
  final Duration trackingDuration;

  /// The color of the location dot, its accuracy circle and its heading.
  final Color color;

  /// The radius of the location dot in logical pixels.
  final double radius;

  @override
  State<UserLocationLayer> createState() => _UserLocationLayerState();
}

class _UserLocationLayerState extends State<UserLocationLayer> {
  StreamSubscription<UserLocation>? _subscription;
  UserLocation? _location;
  late UserLocationTracking _tracking = widget.tracking;

  /// Whether the camera has moved to the location since the tracking
  /// started, so [UserLocationLayer.trackingZoom] applies only once.
  var _tracked = false;

  /// Where each pointer on the map went down, to tell a drag from a tap.
  final _downPositions = <int, Offset>{};

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  void didUpdateWidget(UserLocationLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.locations != oldWidget.locations) {
      unawaited(_subscription?.cancel());
      _subscribe();
    }
    if (widget.tracking != oldWidget.tracking) {
      _tracking = widget.tracking;
      _tracked = false;
      _follow();
    }
  }

  @override
  void dispose() {
    unawaited(_subscription?.cancel());
    super.dispose();
  }

  void _subscribe() {
    _subscription = widget.locations.listen((location) {
      if (!mounted) return;
      setState(() => _location = location);
      _follow();
    });
  }

  /// Moves the camera to the latest location while tracking.
  void _follow() {
    final location = _location;
    final controller = MapController.maybeOf(context);
    if (location == null ||
        controller == null ||
        _tracking == UserLocationTracking.none) {
      return;
    }
    final zoom = _tracked ? null : widget.trackingZoom;
    _tracked = true;
    unawaited(
      controller.animateCamera(
        center: location.position,
        zoom: zoom,
        bearing: _tracking == UserLocationTracking.positionAndHeading
            ? location.heading
            : null,
        nativeDuration: widget.trackingDuration,
        webMaxDuration: widget.trackingDuration,
      ),
    );
  }

  void _stopTracking() {
    if (_tracking == UserLocationTracking.none) return;
    _tracking = UserLocationTracking.none;
    widget.onTrackingChanged?.call(UserLocationTracking.none);
  }

  void _onPointerDown(PointerDownEvent event) =>
      _downPositions[event.pointer] = event.localPosition;

  void _onPointerMove(PointerMoveEvent event) {
    final down = _downPositions[event.pointer];
    if (down == null) return;
    if ((event.localPosition - down).distance > kTouchSlop) _stopTracking();
  }

  void _onPointerEnd(PointerEvent event) =>
      _downPositions.remove(event.pointer);

  void _onPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent || event is PointerScaleEvent) {
      _stopTracking();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = MapController.maybeOf(context);
    final camera = MapCamera.maybeOf(context);
    final location = _location;
    _UserLocationPainter? painter;
    if (controller != null && camera != null && location != null) {
      final accuracy = location.accuracy;
      // The screen distance to a point the accuracy north, so the circle
      // follows the zoom, the latitude and the projection.
      final points = controller.toScreenLocations([
        location.position,
        if (accuracy != null && accuracy > 0)
          Geographic(
            lon: location.position.lon,
            lat: min(90, location.position.lat + accuracy / _metersPerDegree),
          ),
      ]);
      final heading = location.heading;
      painter = _UserLocationPainter(
        center: points.first,
        accuracyRadius: points.length > 1
            ? (points[1] - points[0]).distance
            : 0,
        heading: heading == null ? null : heading - camera.bearing,
        color: widget.color,
        radius: widget.radius,
      );
    }
    // Translucent, so the map behind still gets every pointer.
    return Positioned.fill(
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _onPointerDown,
        onPointerMove: _onPointerMove,
        onPointerUp: _onPointerEnd,
        onPointerCancel: _onPointerEnd,
        onPointerSignal: _onPointerSignal,
        child: IgnorePointer(child: CustomPaint(painter: painter)),
      ),
    );
  }
}

class _UserLocationPainter extends CustomPainter {
  const _UserLocationPainter({
    required this.center,
    required this.accuracyRadius,
    required this.heading,
    required this.color,
    required this.radius,
  });

  final Offset center;
  final double accuracyRadius;

  /// The heading on screen, in degrees clockwise from up.
  final double? heading;
  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    if (accuracyRadius > radius) {
      canvas
        ..drawCircle(
          center,
          accuracyRadius,
          Paint()..color = color.withValues(alpha: 0.15),
        )
        ..drawCircle(
          center,
          accuracyRadius,
          Paint()
            ..color = color.withValues(alpha: 0.4)
            ..style = PaintingStyle.stroke,
        );
    }
    if (heading case final double heading) {
      // A cone of 60 degrees toward the heading.
      final direction = (heading - 90) * pi / 180;
      final length = radius * 4;
      final cone = Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(
          Rect.fromCircle(center: center, radius: length),
          direction - pi / 6,
          pi / 3,
          false,
        )
        ..close();
      canvas.drawPath(
        cone,
        Paint()
          ..shader = RadialGradient(
            colors: [color.withValues(alpha: 0.5), color.withValues(alpha: 0)],
          ).createShader(Rect.fromCircle(center: center, radius: length)),
      );
    }
    canvas
      ..drawCircle(center, radius + 2, Paint()..color = const Color(0xFFFFFFFF))
      ..drawCircle(center, radius, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_UserLocationPainter oldDelegate) =>
      center != oldDelegate.center ||
      accuracyRadius != oldDelegate.accuracyRadius ||
      heading != oldDelegate.heading ||
      color != oldDelegate.color ||
      radius != oldDelegate.radius;
}
