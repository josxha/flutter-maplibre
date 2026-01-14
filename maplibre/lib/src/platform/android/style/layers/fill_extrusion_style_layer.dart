part of 'style_layer.dart';

/// Android implementation of [FillExtrusionStyleLayer].
class FillExtrusionStyleLayerAndroid
    extends StyleLayerAndroid<jni.FillExtrusionLayer>
    implements FillExtrusionStyleLayer {
  /// Default constructor for [FillExtrusionStyleLayerAndroid].
  factory FillExtrusionStyleLayerAndroid({
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
    required PropertyValue<double> height,
    required PropertyValue<double> base,
    required PropertyValue<bool> verticalGradient,
    required PropertyValue<Offset> translate,
    required PropertyValue<ReferenceSpace> translateAnchor,
  }) => using((arena) {
    final layer = FillExtrusionStyleLayerAndroid.fromNativeLayer(jni.FillExtrusionLayer(
      layerId.toJString()..releasedBy(arena),
      sourceId.toJString()..releasedBy(arena),
    )..releasedBy(arena));
    layer.minZoom = minZoom;
    layer.maxZoom = maxZoom;
    layer.visible = visible;
    layer.filter = filter;
    layer.sourceLayerId = sourceLayerId;
    layer.opacity = opacity;
    layer.color = color;
    layer.pattern = pattern;
    layer.height = height;
    layer.base = base;
    layer.verticalGradient = verticalGradient;
    layer.translate = translate;
    layer.translateAnchor = translateAnchor;
    return layer;
  });

  /// Construct an [FillExtrusionStyleLayerAndroid] from a JNI layer.
  FillExtrusionStyleLayerAndroid.fromNativeLayer(super.jLayer)
    : super.fromNativeLayer();

  @override
  PropertyValue<double> get base =>
      jLayer.getFillExtrusionBase().toDart(releaseOriginal: true) ??
      FillExtrusionStyleLayer.defaultBase;

  @override
  set base(PropertyValue<double> value) => using((arena) {
    throw UnimplementedError('Setting properties is not implemented yet.');
  });

  @override
  PropertyValue<Color> get color =>
      jLayer.getFillExtrusionColor().toDartColor(releaseOriginal: true) ??
      FillExtrusionStyleLayer.defaultColor;

  @override
  set color(PropertyValue<Color> value) => using((arena) {
    throw UnimplementedError('Setting properties is not implemented yet.');
  });

  @override
  Expression? get filter => using((arena) {
    final jFilter = jLayer.getFilter()?..releasedBy(arena);
    if (jFilter == null) return null;
    return jFilter.toDart(releaseOriginal: true);
  });

  @override
  set filter(Expression? expression) => using((arena) {
    if (expression == null) {
      throw UnsupportedError(
        'Setting filter for FillExtrusionStyleLayer to null '
        'is not implemented yet.',
      );
    }
    final jFilter = expression.toJExpression(arena)?..releasedBy(arena);
    if (jFilter != null) jLayer.setFilter(jFilter);
  });

  @override
  PropertyValue<double> get height =>
      jLayer.getFillExtrusionHeight().toDart(releaseOriginal: true) ??
      FillExtrusionStyleLayer.defaultHeight;

  @override
  set height(PropertyValue<double> value) => using((arena) {
    throw UnimplementedError('Setting properties is not implemented yet.');
  });

  @override
  PropertyValue<double> get opacity =>
      jLayer.getFillExtrusionOpacity().toDart(releaseOriginal: true) ??
      FillExtrusionStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> value) => using((arena) {
    throw UnimplementedError('Setting properties is not implemented yet.');
  });

  @override
  PropertyValue<String>? get pattern =>
      jLayer.getFillExtrusionPattern().toDart(releaseOriginal: true);

  @override
  set pattern(PropertyValue<String>? value) => using((arena) {
    throw UnimplementedError('Setting properties is not implemented yet.');
  });

  @override
  String? get sourceLayerId =>
      jLayer.getSourceLayer().toDartString(releaseOriginal: true);

  @override
  set sourceLayerId(String? sourceLayerId) => using((arena) {
    throw UnimplementedError('Setting sourceLayerId is not implemented yet.');
  });

  @override
  PropertyValue<Offset> get translate =>
      jLayer.getFillExtrusionTranslate().toDartOffset(releaseOriginal: true) ??
      StyleLayerWithTranslate.defaultTranslate;

  @override
  set translate(PropertyValue<Offset> value) => using((arena) {
    throw UnimplementedError('Setting translate is not implemented yet.');
  });

  @override
  PropertyValue<ReferenceSpace> get translateAnchor =>
      jLayer.getFillExtrusionTranslateAnchor().toDartReferenceSpace(
        releaseOriginal: true,
      ) ??
      StyleLayerWithTranslate.defaultTranslateAnchor;

  @override
  set translateAnchor(PropertyValue<ReferenceSpace> value) => using((arena) {
    throw UnimplementedError('Setting translateAnchor is not implemented yet.');
  });

  @override
  PropertyValue<bool> get verticalGradient =>
      jLayer.getFillExtrusionVerticalGradient().toDart(releaseOriginal: true) ??
      FillExtrusionStyleLayer.defaultVerticalGradient;

  @override
  set verticalGradient(PropertyValue<bool> value) => using((arena) {
    throw UnimplementedError('Setting properties is not implemented yet.');
  });

  @override
  String get sourceId =>
      jLayer.getSourceId().toDartString(releaseOriginal: true);
}
