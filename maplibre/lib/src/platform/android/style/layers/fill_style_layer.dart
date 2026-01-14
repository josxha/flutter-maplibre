part of 'style_layer.dart';

/// Android implementation of [FillStyleLayer].
class FillStyleLayerAndroid extends StyleLayerAndroid<jni.FillLayer>
    implements FillStyleLayer {
  /// Default constructor for [FillStyleLayerAndroid].
  factory FillStyleLayerAndroid({
    required String layerId,
    required String sourceId,
    required double minZoom,
    required double maxZoom,
    required bool visible,
    required Expression? filter,
    required String? sourceLayerId,
    required PropertyValue<double> opacity,
    required PropertyValue<Color> color,
    required PropertyValue<String>? pattern,
    required PropertyValue<Offset> translate,
    required PropertyValue<ReferenceSpace> translateAnchor,
    required PropertyValue<bool> antialias,
    required PropertyValue<Color> outlineColor,
  }) => using((arena) {
    final layer = FillStyleLayerAndroid.fromNativeLayer(
      jni.FillLayer(
        layerId.toJString()..releasedBy(arena),
        sourceId.toJString()..releasedBy(arena),
      )..releasedBy(arena),
    );
    layer.minZoom = minZoom;
    layer.maxZoom = maxZoom;
    layer.visible = visible;
    layer.filter = filter;
    if (sourceLayerId != null) layer.sourceLayerId = sourceLayerId;
    layer.opacity = opacity;
    layer.color = color;
    layer.pattern = pattern;
    layer.translate = translate;
    layer.translateAnchor = translateAnchor;
    layer.antialias = antialias;
    layer.outlineColor = outlineColor;
    return layer;
  });

  /// Construct an [FillStyleLayerAndroid] from a JNI layer.
  FillStyleLayerAndroid.fromNativeLayer(super.jLayer) : super.fromNativeLayer();

  @override
  PropertyValue<bool> get antialias =>
      jLayer.getFillAntialias().toDart(releaseOriginal: true) ??
      FillStyleLayer.defaultAntialias;

  @override
  set antialias(PropertyValue<bool> value) => using((arena) {
    throw UnimplementedError('Setting properties is not implemented yet.');
  });

  @override
  PropertyValue<Color> get color =>
      jLayer.getFillColor().toDartColor(releaseOriginal: true) ??
      FillStyleLayer.defaultColor;

  @override
  set color(PropertyValue<Color> value) => using((arena) {
    throw UnimplementedError('Setting properties is not implemented yet.');
  });

  @override
  PropertyValue<double> get opacity =>
      jLayer.getFillOpacity().toDart(releaseOriginal: true) ??
      FillStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> value) => using((arena) {
    throw UnimplementedError('Setting properties is not implemented yet.');
  });

  @override
  PropertyValue<Color> get outlineColor =>
      jLayer.getFillOutlineColor().toDartColor(releaseOriginal: true) ??
      FillStyleLayer.defaultOutlineColor;

  @override
  set outlineColor(PropertyValue<Color> value) => using((arena) {
    throw UnimplementedError('Setting properties is not implemented yet.');
  });

  @override
  PropertyValue<String>? get pattern =>
      jLayer.getFillPattern().toDart(releaseOriginal: true);

  @override
  set pattern(PropertyValue<String>? value) => using((arena) {
    throw UnimplementedError('Setting properties is not implemented yet.');
  });

  @override
  PropertyValue<Offset> get translate =>
      jLayer.getFillTranslate().toDartOffset(releaseOriginal: true) ??
      StyleLayerWithTranslate.defaultTranslate;

  @override
  set translate(PropertyValue<Offset> value) => using((arena) {
    throw UnimplementedError('Setting properties is not implemented yet.');
  });

  @override
  PropertyValue<ReferenceSpace> get translateAnchor =>
      jLayer.getFillTranslateAnchor().toDartReferenceSpace(
        releaseOriginal: true,
      ) ??
      StyleLayerWithTranslate.defaultTranslateAnchor;

  @override
  set translateAnchor(PropertyValue<ReferenceSpace> value) => using((arena) {
    throw UnimplementedError('Setting translateAnchor is not implemented yet.');
  });

  @override
  String? get sourceLayerId =>
      jLayer.getSourceLayer().toDartString(releaseOriginal: true);

  @override
  set sourceLayerId(String? sourceLayerId) => using((arena) {
    throw UnimplementedError('Setting sourceLayerId is not implemented yet.');
  });

  @override
  PropertyValue<double>? get sortKey =>
      jLayer.getFillSortKey().toDart(releaseOriginal: true);

  @override
  String get sourceId =>
      jLayer.getSourceId().toDartString(releaseOriginal: true);

  @override
  Expression? filter;

  @override
  set sortKey(PropertyValue<double>? value) => using((arena) {
    throw UnimplementedError('Setting properties is not implemented yet.');
  });
}
