part of 'style_layer.dart';

/// Android implementation of [RasterStyleLayer].
class RasterStyleLayerAndroid extends StyleLayerAndroid<jni.RasterLayer>
    implements RasterStyleLayer {
  /// Factory for a [RasterStyleLayerAndroid] instance.
  factory RasterStyleLayerAndroid({
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
  }) => using((arena) {
    return RasterStyleLayerAndroid.fromNativeLayer(
        jni.RasterLayer(
          id.toJString()..releasedBy(arena),
          sourceId.toJString()..releasedBy(arena),
        )..releasedBy(arena),
      )
      ..minZoom = minZoom
      ..maxZoom = maxZoom
      ..visible = visible
      ..opacity = opacity
      ..hueRotate = hueRotate
      ..brightnessMin = brightnessMin
      ..brightnessMax = brightnessMax
      ..saturation = saturation
      ..contrast = contrast
      ..resampling = resampling
      ..fadeDuration = fadeDuration;
  });

  /// Construct a [RasterStyleLayerAndroid] from a JNI layer.
  RasterStyleLayerAndroid.fromNativeLayer(super.jLayer)
    : super.fromNativeLayer();

  PropertyValue<T> _enumProperty<T extends Enum>(
    jni.PropertyValue<JString?> jProperty,
    List<T> values,
    PropertyValue<T> fallback,
  ) => using((arena) {
    jProperty.releasedBy(arena);
    if (jProperty.isExpression()) {
      final jExpression = jProperty.getExpression()?..releasedBy(arena);
      final expression = jExpression?.toDart(releaseOriginal: true);
      if (expression == null) return fallback;
      return PropertyValue.expression(expression);
    }
    final jValue = jProperty.getValue();
    if (jValue == null) return fallback;
    final value = jValue.toDartString(releaseOriginal: true);
    final match = values.firstWhere(
      (v) => v.name == value,
      orElse: () => fallback.value,
    );
    return PropertyValue.value(match);
  });

  @override
  PropertyValue<double> get opacity =>
      jLayer.getRasterOpacity().toDart(releaseOriginal: true) ??
      RasterStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.rasterOpacity$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.rasterOpacity(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get hueRotate =>
      jLayer.getRasterHueRotate().toDart(releaseOriginal: true) ??
      RasterStyleLayer.defaultHueRotate;

  @override
  set hueRotate(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.rasterHueRotate$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.rasterHueRotate(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get brightnessMin =>
      jLayer.getRasterBrightnessMin().toDart(releaseOriginal: true) ??
      RasterStyleLayer.defaultBrightnessMin;

  @override
  set brightnessMin(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.rasterBrightnessMin$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.rasterBrightnessMin(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get brightnessMax =>
      jLayer.getRasterBrightnessMax().toDart(releaseOriginal: true) ??
      RasterStyleLayer.defaultBrightnessMax;

  @override
  set brightnessMax(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.rasterBrightnessMax$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.rasterBrightnessMax(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get saturation =>
      jLayer.getRasterSaturation().toDart(releaseOriginal: true) ??
      RasterStyleLayer.defaultSaturation;

  @override
  set saturation(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.rasterSaturation$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.rasterSaturation(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get contrast =>
      jLayer.getRasterContrast().toDart(releaseOriginal: true) ??
      RasterStyleLayer.defaultContrast;

  @override
  set contrast(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.rasterContrast$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.rasterContrast(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<RasterResampling> get resampling => _enumProperty(
    jLayer.getRasterResampling(),
    RasterResampling.values,
    RasterStyleLayer.defaultResampling,
  );

  @override
  set resampling(PropertyValue<RasterResampling> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.rasterResampling$1(jExpression);
    } else {
      final jValue = value.value.name.toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.rasterResampling(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get fadeDuration =>
      jLayer.getRasterFadeDuration().toDart(releaseOriginal: true) ??
      RasterStyleLayer.defaultFadeDuration;

  @override
  set fadeDuration(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.rasterFadeDuration$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.rasterFadeDuration(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  String get sourceId =>
      jLayer.getSourceId().toDartString(releaseOriginal: true);

  @override
  String? get sourceLayerId => null;

  @override
  set sourceLayerId(String? value) {
    if (value != null) {
      throw UnsupportedError(
        'sourceLayerId is not supported for raster layers',
      );
    }
  }

  @override
  Expression? get filter => null;

  @override
  set filter(Expression? expression) {
    if (expression != null) {
      throw UnsupportedError('filter is not supported for raster layers');
    }
  }
}
