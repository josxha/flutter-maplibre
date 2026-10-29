import 'dart:async';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:flutter/scheduler.dart';
import 'package:web/web.dart';

/// Shows the MapLibre GL JS frames together with the Flutter frames that
/// position widgets for them.
///
/// Multi-threaded skwasm, which a wasm build uses on a cross-origin isolated
/// page, draws Flutter's frames on a web worker. The browser shows them a
/// frame or more after the GL JS canvas, which draws on the main thread right
/// away, so widgets over the map trail it while the camera moves.
///
/// The GL JS canvas stays hidden. Every frame it draws is copied into a
/// snapshot, and the snapshot for the camera of a Flutter frame is shown on a
/// display canvas when skwasm shows that Flutter frame. GL JS frames for a
/// camera that Flutter shows already, such as loaded tiles, show at once.
final class MapFrameSync {
  /// Create the display canvas over [_glCanvas].
  MapFrameSync(this._glCanvas) {
    _display.style
      ..position = 'absolute'
      ..left = '0'
      ..top = '0'
      ..pointerEvents = 'none';
    _glCanvas.after(_display);
    _glCanvas.style.opacity = '0';
    _FlutterFrames.instance.add(this);
  }

  /// Whether Flutter's frames reach the screen later than the GL JS canvas.
  static bool get isNeeded =>
      const bool.fromEnvironment('dart.tool.dart2wasm') &&
      window.crossOriginIsolated;

  final HTMLCanvasElement _glCanvas;
  final _display = HTMLCanvasElement();
  late final _displayContext =
      _display.getContext('2d', {'alpha': true}.jsify())!
          as CanvasRenderingContext2D;

  /// The newest GL JS frames, oldest first, at most 3.
  final _snapshots = <_Snapshot>[];

  /// Counts the camera changes.
  var _camera = 0;

  /// The camera of the Flutter frames that skwasm hasn't shown yet.
  final _frameCameras = <int, int>{};

  /// The camera of the newest Flutter frame on the screen.
  var _shownCamera = 0;

  /// Shows the newest GL JS frame if skwasm doesn't show a Flutter frame.
  Timer? _fallback;

  /// Call when the camera of the map changes.
  void cameraChanged() => _camera++;

  /// Call when GL JS has drawn a frame, while its canvas still holds it.
  void glRendered() {
    final width = _glCanvas.width;
    final height = _glCanvas.height;
    if (width == 0 || height == 0) return;
    final _Snapshot snapshot;
    if (_snapshots.isNotEmpty && _snapshots.last.camera == _camera) {
      snapshot = _snapshots.last;
    } else if (_snapshots.length < 3) {
      snapshot = _Snapshot(OffscreenCanvas(width, height));
      _snapshots.add(snapshot);
    } else {
      snapshot = _snapshots.removeAt(0);
      _snapshots.add(snapshot);
    }
    snapshot
      ..camera = _camera
      ..draw(_glCanvas);
    if (_camera == _shownCamera) {
      _show(snapshot);
    } else {
      _fallback ??= Timer(const Duration(milliseconds: 100), () {
        _fallback = null;
        _frameCameras.clear();
        _shownCamera = _camera;
        _show(_snapshots.last);
      });
    }
  }

  void _flutterFrameBuilt(int frame) => _frameCameras[frame] = _camera;

  void _flutterFrameShown(int frame) {
    // Skwasm still shows frames, so a wait for one isn't stuck.
    _fallback?.cancel();
    _fallback = null;
    final camera = _frameCameras.remove(frame);
    _frameCameras.removeWhere((key, _) => key < frame);
    if (camera == null) return;
    _shownCamera = camera;
    if (_snapshots.isEmpty) return;
    // The newest GL JS frame for that camera or an older one.
    var snapshot = _snapshots.first;
    for (final candidate in _snapshots) {
      if (candidate.camera > camera) break;
      snapshot = candidate;
    }
    _show(snapshot);
  }

  void _show(_Snapshot snapshot) {
    final canvas = snapshot.canvas;
    if (_display.width != canvas.width || _display.height != canvas.height) {
      _display
        ..width = canvas.width
        ..height = canvas.height;
    }
    _display.style
      ..width = _glCanvas.style.width
      ..height = _glCanvas.style.height;
    _displayContext
      ..clearRect(0, 0, canvas.width, canvas.height)
      ..drawImage(canvas, 0, 0);
  }

  /// Remove the display canvas.
  void dispose() {
    _FlutterFrames.instance.remove(this);
    _fallback?.cancel();
    _display.remove();
  }
}

final class _Snapshot {
  _Snapshot(this.canvas);

  final OffscreenCanvas canvas;
  late final _context =
      canvas.getContext('2d', {'alpha': true}.jsify())!
          as OffscreenCanvasRenderingContext2D;
  int camera = 0;

  void draw(HTMLCanvasElement source) {
    if (canvas.width != source.width || canvas.height != source.height) {
      canvas
        ..width = source.width
        ..height = source.height;
    }
    _context
      ..clearRect(0, 0, canvas.width, canvas.height)
      ..drawImage(source, 0, 0);
  }
}

/// Follows which Flutter frame skwasm shows.
///
/// skwasm draws one frame at a time and of the frames that come in meanwhile
/// keeps only the newest, as the engine's render queue does. A frame reaches
/// the screen when skwasm transfers its bitmaps to the page's canvases.
final class _FlutterFrames {
  _FlutterFrames._() {
    SchedulerBinding.instance.addPersistentFrameCallback(_onFrame);
    _patchTransferFromImageBitmap();
  }

  static final instance = _FlutterFrames._();

  final _listeners = <MapFrameSync>{};
  var _frame = 0;
  int? _drawing;
  int? _next;
  var _shownScheduled = false;
  Timer? _reset;

  void add(MapFrameSync listener) => _listeners.add(listener);

  void remove(MapFrameSync listener) => _listeners.remove(listener);

  /// Runs after the frame's scene went to the engine.
  void _onFrame(Duration _) {
    if (_listeners.isEmpty) return;
    final frame = ++_frame;
    for (final listener in _listeners) {
      listener._flutterFrameBuilt(frame);
    }
    if (_drawing == null) {
      _drawing = frame;
    } else {
      _next = frame;
    }
    // A frame without bitmaps never reaches the canvases.
    _reset?.cancel();
    _reset = Timer(const Duration(milliseconds: 100), () {
      _drawing = null;
      _next = null;
    });
  }

  void _onTransfer(JSObject context) {
    if (_shownScheduled || !context['canvas'].isA<HTMLCanvasElement>()) {
      return;
    }
    // A frame transfers one bitmap per canvas in one go.
    _shownScheduled = true;
    window.queueMicrotask(_onShown.toJS);
  }

  void _onShown() {
    _shownScheduled = false;
    final frame = _drawing;
    _drawing = _next;
    _next = null;
    if (frame == null) return;
    for (final listener in _listeners) {
      listener._flutterFrameShown(frame);
    }
  }

  void _patchTransferFromImageBitmap() {
    final prototype = globalContext
        .getProperty<JSObject>('ImageBitmapRenderingContext'.toJS)
        .getProperty<JSObject>('prototype'.toJS);
    final original = prototype.getProperty<JSFunction>(
      'transferFromImageBitmap'.toJS,
    );
    prototype.setProperty(
      'transferFromImageBitmap'.toJS,
      ((JSObject self, JSAny? bitmap) {
        original.callAsFunction(self, bitmap);
        _onTransfer(self);
      }).toJSCaptureThis,
    );
  }
}
