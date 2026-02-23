part of 'style_layer.dart';

/// Android implementation of [FillExtrusionStyleLayer].
class FillExtrusionStyleLayerAndroid
    extends StyleLayerAndroid<jni.FillExtrusionLayer>
    implements FillExtrusionStyleLayer {
  /// Default constructor for [FillExtrusionStyleLayerAndroid].
  factory FillExtrusionStyleLayerAndroid({
    required String id,
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
  }) =>
      using((arena) {
        final layer = FillExtrusionStyleLayerAndroid.fromNativeLayer(
          jni.FillExtrusionLayer(
            id.toJString()
              ..releasedBy(arena),
            sourceId.toJString()
              ..releasedBy(arena),
          ),
        );
        layer.minZoom = minZoom;
        layer.maxZoom = maxZoom;
        layer.visible = visible;
        if (filter != null) layer.filter = filter;
        if (sourceLayerId != null)  layer.sourceLayerId = sourceLayerId;
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
  set base(PropertyValue<double> property) =>
      using((arena) {
        final jProperty = property.apply(
          arena: arena,
          onExpression: jni.PropertyFactory.fillExtrusionBase$1,
          onValue: (value) =>
              jni.PropertyFactory.fillExtrusionBase(
                value.toJFloat()
                  ..releasedBy(arena),
              ),
        );
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<Color> get color =>
      jLayer.getFillExtrusionColor().toDartColor(releaseOriginal: true) ??
          FillExtrusionStyleLayer.defaultColor;

  @override
  set color(PropertyValue<Color> property) =>
      using((arena) {
        final jProperty = property.apply(
          arena: arena,
          onExpression: jni.PropertyFactory.fillExtrusionColor$2,
          onValue: (value) =>
              jni.PropertyFactory.fillExtrusionColor$1(
                value.toHexString().toJString()
                  ..releasedBy(arena),
              ),
        );
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  Expression? get filter =>
      using((arena) {
        final jFilter = jLayer.getFilter()
          ?..releasedBy(arena);
        if (jFilter == null) return null;
        return jFilter.toDart(releaseOriginal: true);
      });

  @override
  set filter(Expression expression) =>
      using((arena) {
        final jFilter = expression.toJExpression(arena)
          ?..releasedBy(arena);
        if (jFilter != null) jLayer.setFilter(jFilter);
      });

  @override
  PropertyValue<double> get height =>
      jLayer.getFillExtrusionHeight().toDart(releaseOriginal: true) ??
          FillExtrusionStyleLayer.defaultHeight;

  @override
  set height(PropertyValue<double> property) =>
      using((arena) {
        final jProperty = property.apply(
          arena: arena,
          onExpression: jni.PropertyFactory.fillExtrusionHeight$1,
          onValue: (value) =>
              jni.PropertyFactory.fillExtrusionHeight(
                value.toJFloat()
                  ..releasedBy(arena),
              ),
        );
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<double> get opacity =>
      jLayer.getFillExtrusionOpacity().toDart(releaseOriginal: true) ??
          FillExtrusionStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> property) =>
      using((arena) {
        final jProperty = property.apply(
          arena: arena,
          onExpression: jni.PropertyFactory.fillExtrusionOpacity$1,
          onValue: (value) =>
              jni.PropertyFactory.fillExtrusionOpacity(
                value.toJFloat()
                  ..releasedBy(arena),
              ),
        );
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<String>? get pattern =>
      jLayer.getFillExtrusionPattern().toDart(releaseOriginal: true);

  @override
  set pattern(PropertyValue<String>? property) =>
      using((arena) {
        final jProperty = property.apply(
          arena: arena,
          onExpression: jni.PropertyFactory.fillExtrusionPattern$1,
          onValue: (value) =>
              jni.PropertyFactory.fillExtrusionPattern(
                value.toJString()
                  ..releasedBy(arena),
              ),
          onNull: () => jni.PropertyFactory.fillExtrusionPattern(null),
        );
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  String? get sourceLayerId =>
      jLayer.getSourceLayer().toDartString(releaseOriginal: true);

  @override
  set sourceLayerId(String? value) =>
      using((arena) {
        final jValue = value?.toJString();
        jValue?.releasedBy(arena);
        jLayer.setSourceLayer(jValue);
      });

  @override
  PropertyValue<Offset> get translate =>
      jLayer.getFillExtrusionTranslate().toDartOffset(releaseOriginal: true) ??
          StyleLayerWithTranslate.defaultTranslate;

  @override
  set translate(PropertyValue<Offset> property) =>
      using((arena) {
        final jProperty = property.apply(
          arena: arena,
          onExpression: jni.PropertyFactory.fillExtrusionTranslate$1,
          onValue: (value) =>
              jni.PropertyFactory.fillExtrusionTranslate(
                value.toJFloatArray(arena),
              ),
        );
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<ReferenceSpace> get translateAnchor =>
      jLayer.getFillExtrusionTranslateAnchor().toDartReferenceSpace(
        releaseOriginal: true,
      ) ??
          StyleLayerWithTranslate.defaultTranslateAnchor;

  @override
  set translateAnchor(PropertyValue<ReferenceSpace> property) =>
      using((arena) {
        final jProperty = property.apply(
          arena: arena,
          onExpression: jni.PropertyFactory.fillExtrusionTranslateAnchor$1,
          onValue: (value) =>
              jni.PropertyFactory.fillExtrusionTranslateAnchor(
                value.name.toJString()
                  ..releasedBy(arena),
              ),
        );
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<bool> get verticalGradient =>
      jLayer.getFillExtrusionVerticalGradient().toDart(releaseOriginal: true) ??
          FillExtrusionStyleLayer.defaultVerticalGradient;

  @override
  set verticalGradient(PropertyValue<bool> property) =>
      using((arena) {
        final jProperty = property.apply(
          arena: arena,
          onExpression: jni.PropertyFactory.fillExtrusionVerticalGradient$1,
          onValue: (value) =>
              jni.PropertyFactory.fillExtrusionVerticalGradient(
                value.toJBoolean()
                  ..releasedBy(arena),
              ),
        );
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  String get sourceId =>
      jLayer.getSourceId().toDartString(releaseOriginal: true);
}
