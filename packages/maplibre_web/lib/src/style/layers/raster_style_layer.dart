part of 'style_layer.dart';

/// Web implementation of [RasterStyleLayer].
class RasterStyleLayerWeb extends StyleLayerWeb implements RasterStyleLayer {
  /// Default constructor for a [RasterStyleLayerWeb] instance.
  RasterStyleLayerWeb({
    required String id,
    required String sourceId,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<double> opacity,
    required PropertyValue<double> hueRotate,
    required PropertyValue<double> brightnessMin,
    required PropertyValue<double> brightnessMax,
    required PropertyValue<double> saturation,
    required PropertyValue<double> contrast,
    required PropertyValue<RasterResampling> resampling,
    required PropertyValue<double> fadeDuration,
  }) : super.fromNativeLayer(
          jsLayer: js.LayerSpecification(
            id: id,
            type: 'raster',
            maxzoom: maxZoom,
            minzoom: minZoom,
            source: sourceId,
            layout: createRasterLayout(visible: visible).jsify(),
            paint: createRasterPaint(
              opacity: opacity,
              hueRotate: hueRotate,
              brightnessMin: brightnessMin,
              brightnessMax: brightnessMax,
              saturation: saturation,
              contrast: contrast,
              resampling: resampling,
              fadeDuration: fadeDuration,
            ).jsify(),
          ),
        );

  @override
  PropertyValue<double> get opacity =>
      requireMap.getPaintProperty(id, 'raster-opacity').toPropertyValue<double>() ??
      RasterStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> property) => requireMap.setPaintProperty(
        id,
        'raster-opacity',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<double> get hueRotate =>
      requireMap
              .getPaintProperty(id, 'raster-hue-rotate')
              .toPropertyValue<double>() ??
      RasterStyleLayer.defaultHueRotate;

  @override
  set hueRotate(PropertyValue<double> property) => requireMap.setPaintProperty(
        id,
        'raster-hue-rotate',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<double> get brightnessMin =>
      requireMap
              .getPaintProperty(id, 'raster-brightness-min')
              .toPropertyValue<double>() ??
      RasterStyleLayer.defaultBrightnessMin;

  @override
  set brightnessMin(PropertyValue<double> property) => requireMap.setPaintProperty(
        id,
        'raster-brightness-min',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<double> get brightnessMax =>
      requireMap
              .getPaintProperty(id, 'raster-brightness-max')
              .toPropertyValue<double>() ??
      RasterStyleLayer.defaultBrightnessMax;

  @override
  set brightnessMax(PropertyValue<double> property) => requireMap.setPaintProperty(
        id,
        'raster-brightness-max',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<double> get saturation =>
      requireMap
              .getPaintProperty(id, 'raster-saturation')
              .toPropertyValue<double>() ??
      RasterStyleLayer.defaultSaturation;

  @override
  set saturation(PropertyValue<double> property) => requireMap.setPaintProperty(
        id,
        'raster-saturation',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<double> get contrast =>
      requireMap.getPaintProperty(id, 'raster-contrast').toPropertyValue<double>() ??
      RasterStyleLayer.defaultContrast;

  @override
  set contrast(PropertyValue<double> property) => requireMap.setPaintProperty(
        id,
        'raster-contrast',
        property.toJson().jsify(),
      );

  @override
  PropertyValue<RasterResampling> get resampling =>
      requireMap
              .getPaintProperty(id, 'raster-resampling')
              .toEnumPropertyValue(RasterResampling.values) ??
      RasterStyleLayer.defaultResampling;

  @override
  set resampling(PropertyValue<RasterResampling> property) => requireMap
      .setPaintProperty(id, 'raster-resampling', property.toJson().jsify());

  @override
  PropertyValue<double> get fadeDuration =>
      requireMap
              .getPaintProperty(id, 'raster-fade-duration')
              .toPropertyValue<double>() ??
      RasterStyleLayer.defaultFadeDuration;

  @override
  set fadeDuration(PropertyValue<double> property) => requireMap.setPaintProperty(
        id,
        'raster-fade-duration',
        property.toJson().jsify(),
      );

  @override
  String get sourceId => jsLayer.source!;
}
