part of 'style_layer.dart';

/// A layer that contains markers.
///
/// https://maplibre.org/maplibre-style-spec/layers/#symbol
///
/// {@category Style}
/// {@subCategory Style Layers}
abstract interface class RasterStyleLayer implements StyleLayerWithSource {
  /// Default constructor for a [RasterStyleLayer] instance.
  factory RasterStyleLayer({
    required String id,
    required String sourceId,
    bool visible = StyleLayer.defaultVisible,
    double minZoom = StyleLayer.defaultMinZoom,
    double maxZoom = StyleLayer.defaultMaxZoom,
    PropertyValue<double> opacity = defaultOpacity,
    PropertyValue<double> hueRotate = defaultHueRotate,
    PropertyValue<double> brightnessMin = defaultBrightnessMin,
    PropertyValue<double> brightnessMax = defaultBrightnessMax,
    PropertyValue<double> saturation = defaultSaturation,
    PropertyValue<double> contrast = defaultContrast,
    PropertyValue<RasterResampling> resampling = defaultResampling,
    PropertyValue<double> fadeDuration = defaultFadeDuration,
  }) => switch (kIsWeb) {
    true => RasterStyleLayerWeb(
      id: id,
      sourceId: sourceId,
      visible: visible,
      minZoom: minZoom,
      maxZoom: maxZoom,
      opacity: opacity,
      hueRotate: hueRotate,
      brightnessMin: brightnessMin,
      brightnessMax: brightnessMax,
      saturation: saturation,
      contrast: contrast,
      resampling: resampling,
      fadeDuration: fadeDuration,
    ),
    false => switch (defaultTargetPlatform) {
      TargetPlatform.android => RasterStyleLayerAndroid(
        id: id,
        sourceId: sourceId,
        visible: visible,
        minZoom: minZoom,
        maxZoom: maxZoom,
        opacity: opacity,
        hueRotate: hueRotate,
        brightnessMin: brightnessMin,
        brightnessMax: brightnessMax,
        saturation: saturation,
        contrast: contrast,
        resampling: resampling,
        fadeDuration: fadeDuration,
      ),
      TargetPlatform.iOS => RasterStyleLayerIos(
        id: id,
        sourceId: sourceId,
        visible: visible,
        minZoom: minZoom,
        maxZoom: maxZoom,
        opacity: opacity,
        hueRotate: hueRotate,
        brightnessMin: brightnessMin,
        brightnessMax: brightnessMax,
        saturation: saturation,
        contrast: contrast,
        resampling: resampling,
        fadeDuration: fadeDuration,
      ),
      _ => throw UnsupportedError(
        'RasterStyleLayer is not supported for the current platform.',
      ),
    },
  };

  /// The opacity at which the image will be drawn.
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `1`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<double> get opacity;

  set opacity(PropertyValue<double> value);

  /// Default value for [opacity] property.
  static const defaultOpacity = PropertyValue<double>.value(1);

  /// Rotates hues around the color wheel.
  ///
  /// Paint property. Optional number. Units in degrees. Defaults to `0`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<double> get hueRotate;

  set hueRotate(PropertyValue<double> value);

  /// Default value for [hueRotate] property.
  static const defaultHueRotate = PropertyValue<double>.value(0);

  /// Increase or reduce the brightness of the image. The value is the minimum
  /// brightness.
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `0`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<double> get brightnessMin;

  set brightnessMin(PropertyValue<double> value);

  /// Default value for [brightnessMin] property.
  static const defaultBrightnessMin = PropertyValue<double>.value(0);

  /// Increase or reduce the brightness of the image. The value is the maximum
  /// brightness.
  ///
  /// Paint property. Optional number in range `[0, 1]`. Defaults to `1`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<double> get brightnessMax;

  set brightnessMax(PropertyValue<double> value);

  /// Default value for [brightnessMax] property.
  static const defaultBrightnessMax = PropertyValue<double>.value(1);

  /// Increase or reduce the saturation of the image.
  ///
  /// Paint property. Optional number in range `[-1, 1]`. Defaults to `0`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<double> get saturation;

  set saturation(PropertyValue<double> value);

  /// Default value for [saturation] property.
  static const defaultSaturation = PropertyValue<double>.value(0);

  /// Increase or reduce the contrast of the image.
  ///
  /// Paint property. Optional number in range `[-1, 1]`. Defaults to `0`.
  /// Supports [interpolate] expressions. Transitionable.
  PropertyValue<double> get contrast;

  set contrast(PropertyValue<double> value);

  /// Default value for [contrast] property.
  static const defaultContrast = PropertyValue<double>.value(0);

  /// {@macro raster-resampling}
  ///
  /// Paint property. Optional enum. Defaults to "linear".
  PropertyValue<RasterResampling> get resampling;

  set resampling(PropertyValue<RasterResampling> value);

  /// Default value for [resampling] property.
  static const defaultResampling = PropertyValue<RasterResampling>.value(
    RasterResampling.linear,
  );

  /// Fade duration when a new tile is added, or when a video is started or its
  /// coordinates are updated.
  ///
  /// Paint property. Optional number in range `[0, ∞)`. Units in milliseconds.
  /// Defaults to `300`. Supports [interpolate] expressions.
  PropertyValue<double> get fadeDuration;

  set fadeDuration(PropertyValue<double> value);

  /// Default value for [fadeDuration] property.
  static const defaultFadeDuration = PropertyValue<double>.value(300);
}

/// {@template raster-resampling}
/// The resampling/interpolation method to use for overscaling, also known as
/// texture magnification filter.
/// {@endtemplate}
enum RasterResampling {
  /// (Bi)linear filtering interpolates pixel values using the weighted average
  /// of the four closest original source pixels creating a smooth but blurry
  /// look when overscaled.
  linear,

  /// Nearest neighbor filtering interpolates pixel values using the nearest
  /// original source pixel creating a sharp but pixelated look when overscaled.
  nearest,
}
