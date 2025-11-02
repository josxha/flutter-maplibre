import 'package:maplibre/src/platform/ios/registry.dart';
import 'package:maplibre_ios/maplibre_ffi.dart' as ffi;

/// Call dart from native swift code.
ffi.FlutterApi createFlutterApi() => ffi.FlutterApi.implement(
  createPlatformViewWithViewId_: (viewId) {
    final view = ffi.UIView();
    Registry.platformViews[viewId] = view;
    return ffi.Helpers.createMapLibrePlatformViewWithView(view);
  },
);
