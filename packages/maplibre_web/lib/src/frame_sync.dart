import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:web/web.dart';

/// Applies gesture steps at the start of the next Flutter frame, so that
/// MapLibre GL JS draws them one browser frame later, together with the
/// widgets that Flutter positions for them.
///
/// Multi-threaded skwasm, which a wasm build uses on a cross-origin isolated
/// page, draws Flutter's frames on a web worker and shows a frame in the
/// browser frame after the one it was built in. A camera change from a
/// pointer event made GL JS draw in the browser frame that builds the
/// Flutter frame, so widgets over the map trailed it by a frame. GL JS draws
/// a camera change from within a frame in the next browser frame.
final class FrameAlignedGestureCamera implements GestureCameraSink {
  /// Pass the gesture steps on to [_sink].
  FrameAlignedGestureCamera(this._sink);

  /// Whether Flutter's frames reach the screen a browser frame after GL JS
  /// draws a camera change from a pointer event.
  static bool get isNeeded =>
      const bool.fromEnvironment('dart.tool.dart2wasm') &&
      window.crossOriginIsolated;

  final GestureCameraSink _sink;
  final _pending = <void Function()>[];

  void _queue(void Function() call) {
    _pending.add(call);
    if (_pending.length > 1) return;
    SchedulerBinding.instance.scheduleFrameCallback((_) {
      final calls = List.of(_pending);
      _pending.clear();
      for (final call in calls) {
        call();
      }
    });
  }

  @override
  void gestureStart() => _queue(_sink.gestureStart);

  @override
  void gestureUpdate(GestureCameraUpdate update) =>
      _queue(() => _sink.gestureUpdate(update));

  @override
  void gestureEnd({Velocity velocity = Velocity.zero}) =>
      _queue(() => _sink.gestureEnd(velocity: velocity));

  @override
  void zoomBy(
    double levels,
    Offset around, {
    Duration duration = Duration.zero,
  }) => _queue(() => _sink.zoomBy(levels, around, duration: duration));
}
