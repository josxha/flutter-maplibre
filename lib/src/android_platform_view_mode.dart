// ignore_for_file: constant_identifier_names

/// The different ways a MapLibre map can be displayed on Android.
///
/// https://docs.flutter.dev/platform-integration/android/platform-views
/// https://github.com/flutter/flutter/blob/master/docs/platforms/android/Android-Platform-Views.md
enum AndroidPlatformViewMode {
  /// [Texture Layer Hybrid Composition](https://github.com/flutter/flutter/blob/master/docs/platforms/android/Texture-Layer-Hybrid-Composition.md)
  /// with fallback to Virtual Display, when the current SDK version is <23
  /// or MapWidget.textureView is false.
  tlhc_vd,

  /// [Texture Layer Hybrid Composition](https://github.com/flutter/flutter/blob/master/docs/platforms/android/Texture-Layer-Hybrid-Composition.md)
  /// with fallback to Hybrid Composition, when the current SDK version is <23
  /// or MapWidget.textureView is false.
  tlhc_hc,

  /// Always use [Hybrid Composition](https://github.com/flutter/flutter/blob/master/docs/platforms/Hybrid-Composition.md).
  hc,

  /// Always use [Virtual Display](https://github.com/flutter/flutter/blob/master/docs/platforms/android/Virtual-Display.md).
  vd,
}
