import 'package:maplibre_ios/maplibre_ffi.dart' as ffi;

/// Registry for platform views.
abstract class Registry {
  /// The platform views mapped by their view IDs.
  static final platformViews = <int, ffi.UIView>{};
}
