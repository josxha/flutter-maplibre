import 'package:maplibre/src/platform/ios/registry.dart';
import 'package:maplibre_ios/maplibre_ffi.dart' as ffi;

/// Call dart from native swift code.
void createFlutterApi() => ffi.FlutterApi.implement(
  createPlatformViewWithViewId_: (viewId) {
    final view = ffi.FlutterPlatformView();
    Registry.platformViews[viewId] = view;
    return view;
  },
);
