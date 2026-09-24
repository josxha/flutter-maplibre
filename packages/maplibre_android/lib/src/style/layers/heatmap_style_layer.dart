part of 'style_layer.dart';

/// Android implementation of [HeatmapStyleLayer].
class HeatmapStyleLayerAndroid extends StyleLayerAndroid<jni.HeatmapLayer>
    implements HeatmapStyleLayer {
  /// Factory for a [HeatmapStyleLayerAndroid] instance.
  factory HeatmapStyleLayerAndroid({
    required String id,
    required String sourceId,
    required String? sourceLayerId,
    required Expression? filter,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<double> radius,
    required PropertyValue<double> weight,
    required PropertyValue<double> intensity,
    required PropertyValue<Color>? color,
    required PropertyValue<double> opacity,
  }) => using((arena) {
    final layer = HeatmapStyleLayerAndroid.fromNativeLayer(
      jni.HeatmapLayer(
        id.toJString()..releasedBy(arena),
        sourceId.toJString()..releasedBy(arena),
      ),
    );
    layer.minZoom = minZoom;
    layer.maxZoom = maxZoom;
    layer.visible = visible;
    layer.radius = radius;
    layer.weight = weight;
    layer.intensity = intensity;
    layer.color = color;
    layer.opacity = opacity;
    if (filter != null) layer.filter = filter;
    if (sourceLayerId != null) layer.sourceLayerId = sourceLayerId;
    return layer;
  });

  /// Construct a [HeatmapStyleLayerAndroid] from a JNI layer.
  HeatmapStyleLayerAndroid.fromNativeLayer(super.jLayer)
    : super.fromNativeLayer();

  @override
  PropertyValue<double> get radius =>
      jLayer.heatmapRadius.toDart(releaseOriginal: true) ??
      HeatmapStyleLayer.defaultRadius;

  @override
  set radius(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.heatmapRadius$1,
      onValue: (value) => jni.PropertyFactory.heatmapRadius(
        value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get weight =>
      jLayer.heatmapWeight.toDart(releaseOriginal: true) ??
      HeatmapStyleLayer.defaultWeight;

  @override
  set weight(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.heatmapWeight$1,
      onValue: (value) => jni.PropertyFactory.heatmapWeight(
        value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get intensity =>
      jLayer.heatmapIntensity.toDart(releaseOriginal: true) ??
      HeatmapStyleLayer.defaultIntensity;

  @override
  set intensity(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.heatmapIntensity$1,
      onValue: (value) => jni.PropertyFactory.heatmapIntensity(
        value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color>? get color =>
      jLayer.heatmapColor.toDartColor(releaseOriginal: true);

  @override
  set color(PropertyValue<Color>? property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.heatmapColor$2,
      onValue: (value) => jni.PropertyFactory.heatmapColor$1(
        value.toHexString().toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get opacity =>
      jLayer.heatmapOpacity.toDart(releaseOriginal: true) ??
      HeatmapStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.heatmapOpacity$1,
      onValue: (value) => jni.PropertyFactory.heatmapOpacity(
        value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  Expression? get filter => using((arena) {
    final jFilter = jLayer.filter?..releasedBy(arena);
    if (jFilter == null) return null;
    return jFilter.toDart(releaseOriginal: true);
  });

  @override
  set filter(Expression expression) => using((arena) {
    final jFilter = expression.toJExpression(arena)?..releasedBy(arena);
    if (jFilter != null) jLayer.filter = jFilter;
  });

  @override
  String get sourceId => jLayer.sourceId.toDartString(releaseOriginal: true);

  @override
  String? get sourceLayerId =>
      jLayer.sourceLayer.toDartString(releaseOriginal: true);

  @override
  set sourceLayerId(String? value) => using((arena) {
    final jValue = value?.toJString();
    jValue?.releasedBy(arena);
    jLayer.sourceLayer = jValue;
  });
}
