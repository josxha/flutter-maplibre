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
        ),
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

  @override
  PropertyValue<double> get opacity =>
      jLayer.rasterOpacity.toDart(releaseOriginal: true) ??
      RasterStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.rasterOpacity$1,
      onValue: (value) => jni.PropertyFactory.rasterOpacity(
        property.value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get hueRotate =>
      jLayer.rasterHueRotate.toDart(releaseOriginal: true) ??
      RasterStyleLayer.defaultHueRotate;

  @override
  set hueRotate(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.rasterHueRotate$1,
      onValue: (value) => jni.PropertyFactory.rasterHueRotate(
        property.value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get brightnessMin =>
      jLayer.rasterBrightnessMin.toDart(releaseOriginal: true) ??
      RasterStyleLayer.defaultBrightnessMin;

  @override
  set brightnessMin(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.rasterBrightnessMin$1,
      onValue: (value) => jni.PropertyFactory.rasterBrightnessMin(
        property.value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get brightnessMax =>
      jLayer.rasterBrightnessMax.toDart(releaseOriginal: true) ??
      RasterStyleLayer.defaultBrightnessMax;

  @override
  set brightnessMax(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.rasterBrightnessMax$1,
      onValue: (value) => jni.PropertyFactory.rasterBrightnessMax(
        property.value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get saturation =>
      jLayer.rasterSaturation.toDart(releaseOriginal: true) ??
      RasterStyleLayer.defaultSaturation;

  @override
  set saturation(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.rasterSaturation$1,
      onValue: (value) => jni.PropertyFactory.rasterSaturation(
        property.value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get contrast =>
      jLayer.rasterContrast.toDart(releaseOriginal: true) ??
      RasterStyleLayer.defaultContrast;

  @override
  set contrast(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.rasterContrast$1,
      onValue: (value) => jni.PropertyFactory.rasterContrast(
        property.value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<RasterResampling> get resampling =>
      jLayer.rasterResampling.toDartEnum(
        values: RasterResampling.values,
        releaseOriginal: true,
      ) ??
      RasterStyleLayer.defaultResampling;

  @override
  set resampling(PropertyValue<RasterResampling> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.rasterResampling$1,
      onValue: (value) => jni.PropertyFactory.rasterResampling(
        property.value.name.toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get fadeDuration =>
      jLayer.rasterFadeDuration.toDart(releaseOriginal: true) ??
      RasterStyleLayer.defaultFadeDuration;

  @override
  set fadeDuration(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.rasterFadeDuration$1,
      onValue: (value) => jni.PropertyFactory.rasterFadeDuration(
        property.value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  String get sourceId => jLayer.sourceId.toDartString(releaseOriginal: true);
}
