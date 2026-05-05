part of 'style_layer.dart';

/// WebView implementation of [RasterStyleLayer].
class RasterStyleLayerWebView extends StyleLayerWebView
    implements RasterStyleLayer {
  /// Creates a raster style layer.
  RasterStyleLayerWebView({
    required this.id,
    required this.sourceId,
    required this.visible,
    required this.minZoom,
    required this.maxZoom,
    required this.opacity,
    required this.hueRotate,
    required this.brightnessMin,
    required this.brightnessMax,
    required this.saturation,
    required this.contrast,
    required this.resampling,
    required this.fadeDuration,
  });

  @override
  Map<String, Object?> get layout => createRasterLayout(visible: visible);

  @override
  Map<String, Object?> get paint => createRasterPaint(
    opacity: opacity,
    hueRotate: hueRotate,
    brightnessMin: brightnessMin,
    brightnessMax: brightnessMax,
    saturation: saturation,
    contrast: contrast,
    resampling: resampling,
    fadeDuration: fadeDuration,
  );

  @override
  bool visible;

  @override
  double minZoom;

  @override
  double maxZoom;

  @override
  PropertyValue<double> opacity;

  @override
  PropertyValue<double> hueRotate;

  @override
  PropertyValue<double> brightnessMin;

  @override
  PropertyValue<double> brightnessMax;

  @override
  PropertyValue<double> saturation;

  @override
  PropertyValue<double> contrast;

  @override
  PropertyValue<RasterResampling> resampling;

  @override
  PropertyValue<double> fadeDuration;

  @override
  final String id;

  @override
  final String sourceId;
}
