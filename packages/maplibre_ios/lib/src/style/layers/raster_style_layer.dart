part of 'style_layer.dart';

/// iOS implementation of [RasterStyleLayer].
class RasterStyleLayerIos extends StyleLayerIos<MLNRasterStyleLayer>
    implements RasterStyleLayer {
  /// Default constructor for a [RasterStyleLayerIos] instance.
  factory RasterStyleLayerIos({
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
  }) {
    final layer = RasterStyleLayerIos.fromNativeLayer(
      MLNRasterStyleLayer.new$()..initWithIdentifier(
        id.toNSString(),
        source: MLNSource()..initWithIdentifier(sourceId.toNSString()),
      ),
    );

    layer.minZoom = minZoom;
    layer.maxZoom = maxZoom;
    layer.visible = visible;
    layer.opacity = opacity;
    layer.hueRotate = hueRotate;
    layer.brightnessMin = brightnessMin;
    layer.brightnessMax = brightnessMax;
    layer.saturation = saturation;
    layer.contrast = contrast;
    layer.resampling = resampling;
    layer.fadeDuration = fadeDuration;
    return layer;
  }

  /// Construct a [RasterStyleLayerIos] from a ObjC layer.
  RasterStyleLayerIos.fromNativeLayer(super.ffiLayer) : super.fromNativeLayer();

  @override
  PropertyValue<double> get opacity =>
      ffiLayer.rasterOpacity.toPropertyValue() ??
      RasterStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.rasterOpacity = property.expression.toNSExpression();
    } else {
      ffiLayer.rasterOpacity = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double> get hueRotate =>
      ffiLayer.rasterHueRotation.toPropertyValue() ??
      RasterStyleLayer.defaultHueRotate;

  @override
  set hueRotate(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.rasterHueRotation = property.expression.toNSExpression();
    } else {
      ffiLayer.rasterHueRotation = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double> get brightnessMin =>
      ffiLayer.minimumRasterBrightness.toPropertyValue() ??
      RasterStyleLayer.defaultBrightnessMin;

  @override
  set brightnessMin(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.minimumRasterBrightness = property.expression.toNSExpression();
    } else {
      ffiLayer.minimumRasterBrightness =
          NSExpression.expressionForConstantValue(property.value.toNSNumber());
    }
  }

  @override
  PropertyValue<double> get brightnessMax =>
      ffiLayer.maximumRasterBrightness.toPropertyValue() ??
      RasterStyleLayer.defaultBrightnessMax;

  @override
  set brightnessMax(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.maximumRasterBrightness = property.expression.toNSExpression();
    } else {
      ffiLayer.maximumRasterBrightness =
          NSExpression.expressionForConstantValue(property.value.toNSNumber());
    }
  }

  @override
  PropertyValue<double> get saturation =>
      ffiLayer.rasterSaturation.toPropertyValue() ??
      RasterStyleLayer.defaultSaturation;

  @override
  set saturation(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.rasterSaturation = property.expression.toNSExpression();
    } else {
      ffiLayer.rasterSaturation = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double> get contrast =>
      ffiLayer.rasterContrast.toPropertyValue() ??
      RasterStyleLayer.defaultContrast;

  @override
  set contrast(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.rasterContrast = property.expression.toNSExpression();
    } else {
      ffiLayer.rasterContrast = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<RasterResampling> get resampling =>
      ffiLayer.rasterResamplingMode.toEnumPropertyValue(
        RasterResampling.values,
      ) ??
      RasterStyleLayer.defaultResampling;

  @override
  set resampling(PropertyValue<RasterResampling> property) {
    if (property.isExpression) {
      ffiLayer.rasterResamplingMode = property.expression.toNSExpression();
    } else {
      ffiLayer.rasterResamplingMode = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<double> get fadeDuration =>
      ffiLayer.rasterFadeDuration.toPropertyValue() ??
      RasterStyleLayer.defaultFadeDuration;

  @override
  set fadeDuration(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.rasterFadeDuration = property.expression.toNSExpression();
    } else {
      ffiLayer.rasterFadeDuration = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  String get sourceId => ffiLayer.sourceIdentifier!.toDartString();
}
