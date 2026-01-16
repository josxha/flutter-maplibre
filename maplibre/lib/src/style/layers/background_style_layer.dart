part of 'style_layer.dart';

/// A simple background layer.
///
/// https://maplibre.org/maplibre-style-spec/layers/#background
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract interface class BackgroundStyleLayer implements StyleLayer {
  /// Create a platform-specific implementation of [BackgroundStyleLayer].
  factory BackgroundStyleLayer({
    required String id,
    bool visible = StyleLayer.defaultVisible,
    PropertyValue<Color> color = defaultColor,
    PropertyValue<String>? pattern,
    PropertyValue<double> opacity = defaultOpacity,
    double minZoom = StyleLayer.defaultMinZoom,
    double maxZoom = StyleLayer.defaultMaxZoom,
  }) => switch (kIsWeb) {
    true => BackgroundStyleLayerWeb(
      id: id,
      visible: visible,
      color: color,
      pattern: pattern,
      opacity: opacity,
      minZoom: minZoom,
      maxZoom: maxZoom,
    ),
    false => switch (defaultTargetPlatform) {
      TargetPlatform.android => BackgroundStyleLayerAndroid(
        id: id,
        visible: visible,
        color: color,
        pattern: pattern,
        opacity: opacity,
        minZoom: minZoom,
        maxZoom: maxZoom,
      ),
      TargetPlatform.iOS => BackgroundStyleLayerIos(
        id: id,
        visible: visible,
        color: color,
        pattern: pattern,
        opacity: opacity,
        minZoom: minZoom,
        maxZoom: maxZoom,
      ),
      _ => throw UnsupportedError(
        'BackgroundStyleLayer is not supported for the current platform.',
      ),
    },
  };

  /// The color with which the background will be drawn.
  ///
  /// Paint property. Optional color. Defaults to `#000000` (black).
  /// Disabled by [pattern]. Supports [interpolate] expressions. Transitionable.
  PropertyValue<Color> get color;

  set color(PropertyValue<Color> value);

  /// Default value of [color].
  static const defaultColor = PropertyValue<Color>.value(Color(0xFF000000));

  /// Name of image in sprite to use for drawing an image background. For
  /// seamless patterns, image width and height must be a factor of two
  /// (2, 4, 8, ..., 512). Note that zoom-dependent expressions will be
  /// evaluated only at integer zoom levels.
  ///
  /// Paint property. Optional resolvedImage. Transitionable.
  PropertyValue<String>? get pattern;

  set pattern(PropertyValue<String>? value);

  /// The opacity at which the background will be drawn.
  ///
  /// Paint property. Optional number in range `0,1`. Defaults to `1.0`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<double> get opacity;

  set opacity(PropertyValue<double> value);

  /// Default value of [opacity].
  static const defaultOpacity = PropertyValue<double>.value(1);
}
