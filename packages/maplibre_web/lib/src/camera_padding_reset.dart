import 'dart:js_interop';

import 'package:maplibre_web/src/interop/interop.dart' as interop;

@anonymous
@JS()
extension type _CameraPaddingResetEventData._(JSObject _) implements JSObject {
  external factory _CameraPaddingResetEventData({
    required bool flutterMapLibreInternalPaddingReset,
  });

  external bool? flutterMapLibreInternalPaddingReset;
}

/// Resets persistent camera padding without leaking the reset's events.
final class CameraPaddingReset {
  /// Reset only when MapLibre can fit the requested padding in the viewport.
  bool runBeforeFitBounds({
    required interop.Camera camera,
    required num viewportWidth,
    required num viewportHeight,
    required interop.PaddingOptions fitPadding,
  }) {
    if (fitPadding.left + fitPadding.right > viewportWidth ||
        fitPadding.top + fitPadding.bottom > viewportHeight) {
      return false;
    }
    run(
      camera: camera,
      padding: interop.PaddingOptions(top: 0, bottom: 0, right: 0, left: 0),
    );
    return true;
  }

  /// Whether a camera [event] should be forwarded to plugin users.
  bool shouldForward(JSObject event) {
    final eventData = _CameraPaddingResetEventData._(event);
    return eventData.flutterMapLibreInternalPaddingReset != true;
  }

  /// Stops a real movement before applying a tagged internal padding reset.
  void run({
    required interop.Camera camera,
    required interop.PaddingOptions padding,
  }) {
    camera.stop();
    camera.jumpTo(
      interop.JumpToOptions(padding: padding),
      _CameraPaddingResetEventData(flutterMapLibreInternalPaddingReset: true),
    );
  }
}
