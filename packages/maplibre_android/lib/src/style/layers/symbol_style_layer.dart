part of 'style_layer.dart';

/// Android implementation of [SymbolStyleLayer].
class SymbolStyleLayerAndroid extends StyleLayerAndroid<jni.SymbolLayer>
    implements SymbolStyleLayer {
  /// Factory for a [SymbolStyleLayerAndroid] instance.
  factory SymbolStyleLayerAndroid({
    required String id,
    required String sourceId,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required String? sourceLayerId,
    required Expression? filter,
    required PropertyValue<double>? sortKey,
    required PropertyValue<SymbolPlacement> placement,
    required PropertyValue<double> spacing,
    required PropertyValue<bool> avoidEdges,
    required PropertyValue<SymbolZOrder> zOrder,
    required PropertyValue<bool> iconAllowOverlap,
    // required PropertyValue<SymbolOverlap> iconOverlap,
    required PropertyValue<bool> iconIgnorePlacement,
    required PropertyValue<bool> iconOptional,
    required PropertyValue<IconRotationAlignment> iconRotationAlignment,
    required PropertyValue<double> iconSize,
    required PropertyValue<IconTextFit> iconTextFit,
    required PropertyValue<EdgeInsets> iconTextFitPadding,
    required PropertyValue<String>? iconImage,
    required PropertyValue<double> iconRotate,
    required PropertyValue<EdgeInsets> iconPadding,
    required PropertyValue<bool> iconKeepUpright,
    required PropertyValue<Offset> iconOffset,
    required PropertyValue<IconAnchor> iconAnchor,
    required PropertyValue<IconPitchAlignment> iconPitchAlignment,
    required PropertyValue<TextPitchAlignment> textPitchAlignment,
    required PropertyValue<TextRotationAlignment> textRotationAlignment,
    required PropertyValue<String> textField,
    required PropertyValue<List<String>> textFont,
    required PropertyValue<double> textSize,
    required PropertyValue<double> textMaxWidth,
    required PropertyValue<double> textLineHeight,
    required PropertyValue<double> textLetterSpacing,
    required PropertyValue<TextJustify> textJustify,
    required PropertyValue<double> textRadialOffset,
    required PropertyValue<List<IconAnchor>>? textVariableAnchor,
    required PropertyValue<Map<String, Offset>>? textVariableAnchorOffset,
    required PropertyValue<TextAnchor> textAnchor,
    required PropertyValue<double> textMaxAngle,
    required PropertyValue<List<TextWritingMode>>? textWritingMode,
    required PropertyValue<double> textRotate,
    required PropertyValue<double> textPadding,
    required PropertyValue<bool> textKeepUpright,
    required PropertyValue<TextTransform> textTransform,
    required PropertyValue<Offset> textOffset,
    // required PropertyValue<SymbolOverlap>? textOverlap,
    required PropertyValue<bool> textIgnorePlacement,
    required PropertyValue<bool> textOptional,
    required PropertyValue<double> iconOpacity,
    required PropertyValue<Color> iconColor,
    required PropertyValue<Color> iconHaloColor,
    required PropertyValue<double> iconHaloWidth,
    required PropertyValue<double> iconHaloBlur,
    required PropertyValue<Offset> iconTranslate,
    required PropertyValue<ReferenceSpace> iconTranslateAnchor,
    required PropertyValue<double> textOpacity,
    required PropertyValue<Color> textColor,
    required PropertyValue<Color> textHaloColor,
    required PropertyValue<double> textHaloWidth,
    required PropertyValue<double> textHaloBlur,
    required PropertyValue<Offset> textTranslate,
    required PropertyValue<ReferenceSpace> textTranslateAnchor,
    PropertyValue<bool> textAllowOverlap =
        SymbolStyleLayer.defaultTextAllowOverlap,
  }) => using((arena) {
    final layer = SymbolStyleLayerAndroid.fromNativeLayer(
      jni.SymbolLayer(
        id.toJString()..releasedBy(arena),
        sourceId.toJString()..releasedBy(arena),
      ),
    );
    layer.minZoom = minZoom;
    layer.maxZoom = maxZoom;
    layer.visible = visible;
    if (filter != null) layer.filter = filter;
    layer.sortKey = sortKey;
    layer.placement = placement;
    layer.spacing = spacing;
    layer.avoidEdges = avoidEdges;
    layer.zOrder = zOrder;
    layer.iconAllowOverlap = iconAllowOverlap;
    // layer.iconOverlap = iconOverlap;
    layer.iconIgnorePlacement = iconIgnorePlacement;
    layer.iconOptional = iconOptional;
    layer.iconRotationAlignment = iconRotationAlignment;
    layer.iconSize = iconSize;
    layer.iconTextFit = iconTextFit;
    layer.iconTextFitPadding = iconTextFitPadding;
    layer.iconImage = iconImage;
    layer.iconRotate = iconRotate;
    layer.iconPadding = iconPadding;
    layer.iconKeepUpright = iconKeepUpright;
    layer.iconOffset = iconOffset;
    layer.iconAnchor = iconAnchor;
    layer.iconPitchAlignment = iconPitchAlignment;
    layer.textPitchAlignment = textPitchAlignment;
    layer.textRotationAlignment = textRotationAlignment;
    layer.textField = textField;
    layer.textFont = textFont;
    layer.textSize = textSize;
    layer.textMaxWidth = textMaxWidth;
    layer.textLineHeight = textLineHeight;
    layer.textLetterSpacing = textLetterSpacing;
    layer.textJustify = textJustify;
    layer.textRadialOffset = textRadialOffset;
    layer.textVariableAnchor = textVariableAnchor;
    layer.textVariableAnchorOffset = textVariableAnchorOffset;
    layer.textAnchor = textAnchor;
    layer.textMaxAngle = textMaxAngle;
    layer.textWritingMode = textWritingMode;
    layer.textRotate = textRotate;
    layer.textPadding = textPadding;
    layer.textKeepUpright = textKeepUpright;
    layer.textTransform = textTransform;
    layer.textOffset = textOffset;
    layer.textAllowOverlap = textAllowOverlap;
    // layer.textOverlap = textOverlap;
    layer.textIgnorePlacement = textIgnorePlacement;
    layer.textOptional = textOptional;
    layer.iconOpacity = iconOpacity;
    layer.iconColor = iconColor;
    layer.iconHaloColor = iconHaloColor;
    layer.iconHaloWidth = iconHaloWidth;
    layer.iconHaloBlur = iconHaloBlur;
    layer.iconTranslate = iconTranslate;
    layer.iconTranslateAnchor = iconTranslateAnchor;
    layer.textOpacity = textOpacity;
    layer.textColor = textColor;
    layer.textHaloColor = textHaloColor;
    layer.textHaloWidth = textHaloWidth;
    layer.textHaloBlur = textHaloBlur;
    layer.textTranslate = textTranslate;
    layer.textTranslateAnchor = textTranslateAnchor;
    if (sourceLayerId != null) layer.sourceLayerId = sourceLayerId;
    return layer;
  });

  /// Construct a [SymbolStyleLayerAndroid] from a JNI layer.
  SymbolStyleLayerAndroid.fromNativeLayer(super.jLayer)
    : super.fromNativeLayer();

  @override
  String get sourceId =>
      jLayer.getSourceId().toDartString(releaseOriginal: true);

  @override
  String? get sourceLayerId =>
      jLayer.getSourceLayer().toDartString(releaseOriginal: true);

  @override
  set sourceLayerId(String value) => using((arena) {
    jLayer.setSourceLayer(value.toJString()..releasedBy(arena));
  });

  @override
  Expression? get filter => using((arena) {
    final jFilter = jLayer.getFilter()?..releasedBy(arena);
    return jFilter?.toDart(releaseOriginal: true);
  });

  @override
  set filter(Expression expression) => using((arena) {
    final jFilter = expression.toJExpression(arena);
    if (jFilter == null) return;
    jLayer.setFilter(jFilter);
  });

  @override
  PropertyValue<double>? get sortKey =>
      jLayer.getSymbolSortKey().toDart(releaseOriginal: true);

  @override
  set sortKey(PropertyValue<double>? property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.symbolSortKey$1,
      onValue: (value) => jni.PropertyFactory.symbolSortKey(
        value.toJFloat()..releasedBy(arena),
      ),
      onNull: () => jni.PropertyFactory.symbolSortKey(null),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<SymbolPlacement> get placement =>
      jLayer.getSymbolPlacement().toDartEnum(
        values: SymbolPlacement.values,
        releaseOriginal: true,
      ) ??
      SymbolStyleLayer.defaultPlacement;

  @override
  set placement(PropertyValue<SymbolPlacement> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.symbolPlacement$1,
      onValue: (value) => jni.PropertyFactory.symbolPlacement(
        value.name.toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get spacing =>
      jLayer.getSymbolSpacing().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultSpacing;

  @override
  set spacing(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.symbolSpacing$1,
      onValue: (value) => jni.PropertyFactory.symbolSpacing(
        value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<bool> get avoidEdges =>
      jLayer.getSymbolAvoidEdges().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultAvoidEdges;

  @override
  set avoidEdges(PropertyValue<bool> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.symbolAvoidEdges$1,
      onValue: (value) => jni.PropertyFactory.symbolAvoidEdges(
        value.toJBoolean()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<SymbolZOrder> get zOrder =>
      jLayer.getSymbolZOrder().toDartEnum(
        values: SymbolZOrder.values,
        releaseOriginal: true,
      ) ??
      SymbolStyleLayer.defaultZOrder;

  @override
  set zOrder(PropertyValue<SymbolZOrder> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.symbolZOrder$1,
      onValue: (value) => jni.PropertyFactory.symbolZOrder(
        value.name.toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<bool> get iconAllowOverlap =>
      jLayer.getIconAllowOverlap().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconAllowOverlap;

  @override
  set iconAllowOverlap(PropertyValue<bool> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.iconAllowOverlap$1,
      onValue: (value) => jni.PropertyFactory.iconAllowOverlap(
        value.toJBoolean()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<SymbolOverlap> get iconOverlap => throw UnsupportedError(
    'Getting iconOverlap is not supported on Android. '
    'https://github.com/maplibre/maplibre-native/issues/251',
  );

  @override
  set iconOverlap(PropertyValue<SymbolOverlap> value) => using((arena) {
    throw UnsupportedError(
      'Setting iconOverlap is not supported on Android. '
      'https://github.com/maplibre/maplibre-native/issues/251',
    );
  });

  @override
  PropertyValue<bool> get iconIgnorePlacement =>
      jLayer.getIconIgnorePlacement().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconIgnorePlacement;

  @override
  set iconIgnorePlacement(PropertyValue<bool> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.iconIgnorePlacement$1,
      onValue: (value) => jni.PropertyFactory.iconIgnorePlacement(
        value.toJBoolean()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<bool> get iconOptional =>
      jLayer.getIconOptional().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconOptional;

  @override
  set iconOptional(PropertyValue<bool> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.iconOptional$1,
      onValue: (value) => jni.PropertyFactory.iconOptional(
        value.toJBoolean()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<IconRotationAlignment> get iconRotationAlignment =>
      jLayer.getIconRotationAlignment().toDartEnum(
        values: IconRotationAlignment.values,
        releaseOriginal: true,
      ) ??
      SymbolStyleLayer.defaultIconRotationAlignment;

  @override
  set iconRotationAlignment(PropertyValue<IconRotationAlignment> value) =>
      using((arena) {
        final jProperty = value.apply(
          arena: arena,
          onExpression: jni.PropertyFactory.iconRotationAlignment$1,
          onValue: (value) => jni.PropertyFactory.iconRotationAlignment(
            value.name.toJString()..releasedBy(arena),
          ),
        );
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<double> get iconSize =>
      jLayer.getIconSize().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconSize;

  @override
  set iconSize(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.iconSize$1,
      onValue: (value) =>
          jni.PropertyFactory.iconSize(value.toJFloat()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<IconTextFit> get iconTextFit =>
      jLayer.getIconTextFit().toDartEnum(
        values: IconTextFit.values,
        releaseOriginal: true,
      ) ??
      SymbolStyleLayer.defaultIconTextFit;

  @override
  set iconTextFit(PropertyValue<IconTextFit> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.iconTextFit$1,
      onValue: (value) => jni.PropertyFactory.iconTextFit(
        value.name.toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<EdgeInsets> get iconTextFitPadding =>
      jLayer.getIconTextFitPadding().toDartEdgeInsets(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconTextFitPadding;

  @override
  set iconTextFitPadding(PropertyValue<EdgeInsets> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.iconTextFitPadding$1,
      onValue: (value) {
        final floats = value.toJFloatArray(arena);
        return jni.PropertyFactory.iconTextFitPadding(floats);
      },
    );
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<String>? get iconImage =>
      jLayer.getIconImage().toDart(releaseOriginal: true);

  @override
  set iconImage(PropertyValue<String>? property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.iconImage$1,
      onValue: (value) =>
          jni.PropertyFactory.iconImage(value.toJString()..releasedBy(arena)),
      onNull: () => jni.PropertyFactory.iconImage(null),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get iconRotate =>
      jLayer.getIconRotate().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconRotate;

  @override
  set iconRotate(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.iconRotate$1,
      onValue: (value) =>
          jni.PropertyFactory.iconRotate(value.toJFloat()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<EdgeInsets> get iconPadding =>
      jLayer.getIconPadding().toDartEdgeInsets(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconPadding;

  @override
  set iconPadding(PropertyValue<EdgeInsets> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.iconPadding$2,
      onValue: (value) {
        final floats = value.toJFloatArray(arena);
        return jni.PropertyFactory.iconPadding$1(floats);
      },
    );
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<bool> get iconKeepUpright =>
      jLayer.getIconKeepUpright().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconKeepUpright;

  @override
  set iconKeepUpright(PropertyValue<bool> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.iconKeepUpright$1,
      onValue: (value) => jni.PropertyFactory.iconKeepUpright(
        value.toJBoolean()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Offset> get iconOffset =>
      jLayer.getIconOffset().toDartOffset(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconOffset;

  @override
  set iconOffset(PropertyValue<Offset> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.iconOffset$1,
      onValue: (value) {
        final floats = value.toJFloatArray(arena);
        return jni.PropertyFactory.iconOffset(floats);
      },
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<IconAnchor> get iconAnchor =>
      jLayer.getIconAnchor().toDartEnum(
        values: IconAnchor.values,
        releaseOriginal: true,
      ) ??
      SymbolStyleLayer.defaultIconAnchor;

  @override
  set iconAnchor(PropertyValue<IconAnchor> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.iconAnchor$1,
      onValue: (value) => jni.PropertyFactory.iconAnchor(
        value.name.toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<IconPitchAlignment> get iconPitchAlignment =>
      jLayer.getIconPitchAlignment().toDartEnum(
        values: IconPitchAlignment.values,
        releaseOriginal: true,
      ) ??
      SymbolStyleLayer.defaultIconPitchAlignment;

  @override
  set iconPitchAlignment(PropertyValue<IconPitchAlignment> value) =>
      using((arena) {
        final jProperty = value.apply(
          arena: arena,
          onExpression: jni.PropertyFactory.iconPitchAlignment$1,
          onValue: (value) => jni.PropertyFactory.iconPitchAlignment(
            value.name.toJString()..releasedBy(arena),
          ),
        );
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<TextPitchAlignment> get textPitchAlignment =>
      jLayer.getTextPitchAlignment().toDartEnum(
        values: TextPitchAlignment.values,
        releaseOriginal: true,
      ) ??
      SymbolStyleLayer.defaultTextPitchAlignment;

  @override
  set textPitchAlignment(PropertyValue<TextPitchAlignment> value) =>
      using((arena) {
        final jProperty = value.apply(
          arena: arena,
          onExpression: jni.PropertyFactory.textPitchAlignment$1,
          onValue: (value) => jni.PropertyFactory.textPitchAlignment(
            value.name.toJString()..releasedBy(arena),
          ),
        );
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<TextRotationAlignment> get textRotationAlignment =>
      jLayer.getTextRotationAlignment().toDartEnum(
        values: TextRotationAlignment.values,
        releaseOriginal: true,
      ) ??
      SymbolStyleLayer.defaultTextRotationAlignment;

  @override
  set textRotationAlignment(PropertyValue<TextRotationAlignment> value) =>
      using((arena) {
        final jProperty = value.apply(
          arena: arena,
          onExpression: jni.PropertyFactory.textRotationAlignment$1,
          onValue: (value) => jni.PropertyFactory.textRotationAlignment(
            value.name.toJString()..releasedBy(arena),
          ),
        );
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<String> get textField => using((arena) {
    final jProperty = jLayer.getTextField()..releasedBy(arena);
    if (jProperty.isExpression()) {
      final jExpression = jProperty.getExpression()?..releasedBy(arena);
      final expression = jExpression!.toDart(releaseOriginal: true);
      return PropertyValue.expression(expression);
    }
    // Android always returns a Formatted, we treat this as an Expression
    throw Exception(
      'Getting textField as a literal value is not supported on Android.',
    );
  });

  @override
  set textField(PropertyValue<String> value) => using((arena) {
    final jProperty = value.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textField$2,
      onValue: (value) =>
          jni.PropertyFactory.textField(value.toJString()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<List<String>> get textFont =>
      jLayer.getTextFont().toDartStringList(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextFont;

  @override
  set textFont(PropertyValue<List<String>> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textFont$1,
      onValue: (value) {
        final jArray = value.toJStringArray(arena);
        return jni.PropertyFactory.textFont(jArray);
      },
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get textSize =>
      jLayer.getTextSize().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextSize;

  @override
  set textSize(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textSize$1,
      onValue: (value) =>
          jni.PropertyFactory.textSize(value.toJFloat()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get textMaxWidth =>
      jLayer.getTextMaxWidth().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextMaxWidth;

  @override
  set textMaxWidth(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textMaxWidth$1,
      onValue: (value) =>
          jni.PropertyFactory.textMaxWidth(value.toJFloat()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get textLineHeight =>
      jLayer.getTextLineHeight().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextLineHeight;

  @override
  set textLineHeight(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textLineHeight$1,
      onValue: (value) => jni.PropertyFactory.textLineHeight(
        value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get textLetterSpacing =>
      jLayer.getTextLetterSpacing().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextLetterSpacing;

  @override
  set textLetterSpacing(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textLetterSpacing$1,
      onValue: (value) => jni.PropertyFactory.textLetterSpacing(
        value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<TextJustify> get textJustify =>
      jLayer.getTextJustify().toDartEnum(
        values: TextJustify.values,
        releaseOriginal: true,
      ) ??
      SymbolStyleLayer.defaultTextJustify;

  @override
  set textJustify(PropertyValue<TextJustify> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textJustify$1,
      onValue: (value) => jni.PropertyFactory.textJustify(
        value.name.toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get textRadialOffset =>
      jLayer.getTextRadialOffset().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextRadialOffset;

  @override
  set textRadialOffset(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textRadialOffset$1,
      onValue: (value) => jni.PropertyFactory.textRadialOffset(
        value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<List<IconAnchor>>? get textVariableAnchor => using((arena) {
    final jProperty = jLayer.getTextVariableAnchor()..releasedBy(arena);
    if (jProperty.isNull$1()) return null;
    if (jProperty.isExpression()) {
      final jExpression = jProperty.getExpression()?..releasedBy(arena);
      final expression = jExpression?.toDart(releaseOriginal: true);
      return expression == null ? null : PropertyValue.expression(expression);
    }
    final jArray = jProperty.getValue();
    if (jArray == null) return null;
    final values = <IconAnchor>[];
    for (var i = 0; i < jArray.length; i++) {
      final entry = jArray[i];
      if (entry == null) continue;
      final name = entry.toDartString(releaseOriginal: true);
      final match = IconAnchor.values.firstWhere(
        (e) => e.name == name,
        orElse: () => SymbolStyleLayer.defaultTextAnchor.value as IconAnchor,
      );
      values.add(match);
    }
    return PropertyValue.value(values);
  });

  @override
  set textVariableAnchor(PropertyValue<List<IconAnchor>>? value) =>
      using((arena) {
        final jProperty = value.apply(
          arena: arena,
          onExpression: jni.PropertyFactory.textVariableAnchor$1,
          onValue: (value) {
            final jArray = JArray(JString.nullableType, value.length);
            for (var i = 0; i < value.length; i++) {
              jArray[i] = value[i].name.toJString()..releasedBy(arena);
            }
            return jni.PropertyFactory.textVariableAnchor(jArray);
          },
          onNull: () => jni.PropertyFactory.textVariableAnchor(null),
        );
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<Map<String, Offset>>? get textVariableAnchorOffset => using((
    arena,
  ) {
    final jProperty = jLayer.getTextVariableAnchorOffset()..releasedBy(arena);
    if (jProperty.isNull$1()) return null;
    if (jProperty.isExpression()) {
      final jExpression = jProperty.getExpression()?..releasedBy(arena);
      final expression = jExpression?.toDart(releaseOriginal: true);
      if (expression == null) return null;
      return PropertyValue.expression(expression);
    }
    final jArray = jProperty.getValue()?..releasedBy(arena);
    if (jArray == null) return null;
    final values = <String, Offset>{};
    for (var i = 0; i < jArray.length; i += 2) {
      final entry0 = jArray[i]?..releasedBy(arena);
      final entry1 = jArray[i + 1]?..releasedBy(arena);
      if (entry0 == null || entry1 == null) continue;
      final key = entry0.as(JString.type).toDartString(releaseOriginal: true);
      final jOffset = entry1.as(JArray.type(JFloat.nullableType));
      final offset = jOffset.toOffset(releaseOriginal: true);
      values[key] = offset;
    }
    return PropertyValue.value(values);
  });

  @override
  set textVariableAnchorOffset(PropertyValue<Map<String, Offset>>? value) =>
      using((arena) {
        final jProperty = value.apply(
          arena: arena,
          onExpression: jni.PropertyFactory.textVariableAnchorOffset$1,
          onValue: (value) {
            final jArray = JArray(JObject.nullableType, value.length * 2);
            var i = 0;
            for (final entry in value.entries) {
              jArray[i++] = entry.key.toJString()..releasedBy(arena);
              final jOffset = entry.value.toJFloatArray(arena);
              jArray[i++] = jOffset..releasedBy(arena);
            }
            return jni.PropertyFactory.textVariableAnchorOffset(jArray);
          },
          onNull: () => jni.PropertyFactory.textVariableAnchorOffset(null),
        );
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<TextAnchor> get textAnchor =>
      jLayer.getTextAnchor().toDartEnum(
        values: TextAnchor.values,
        releaseOriginal: true,
      ) ??
      SymbolStyleLayer.defaultTextAnchor;

  @override
  set textAnchor(PropertyValue<TextAnchor> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textAnchor$1,
      onValue: (value) => jni.PropertyFactory.textAnchor(
        value.name.toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get textMaxAngle =>
      jLayer.getTextMaxAngle().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextMaxAngle;

  @override
  set textMaxAngle(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textMaxAngle$1,
      onValue: (value) =>
          jni.PropertyFactory.textMaxAngle(value.toJFloat()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<List<TextWritingMode>>? get textWritingMode => using((arena) {
    final jProperty = jLayer.getTextWritingMode()..releasedBy(arena);
    if (jProperty.isNull$1()) return null;
    if (jProperty.isExpression()) {
      final jExpression = jProperty.getExpression()?..releasedBy(arena);
      final expression = jExpression?.toDart(releaseOriginal: true);
      return expression == null ? null : PropertyValue.expression(expression);
    }
    final jArray = jProperty.getValue();
    if (jArray == null) return null;
    final values = <TextWritingMode>[];
    for (var i = 0; i < jArray.length; i++) {
      final entry = jArray[i];
      if (entry == null) continue;
      final name = entry.toDartString(releaseOriginal: true);
      final match = TextWritingMode.values.firstWhere(
        (e) => e.name == name,
        orElse: () => .horizontal,
      );
      values.add(match);
    }
    return PropertyValue.value(values);
  });

  @override
  set textWritingMode(PropertyValue<List<TextWritingMode>>? value) =>
      using((arena) {
        final jProperty = value.apply(
          arena: arena,
          onExpression: jni.PropertyFactory.textWritingMode$1,
          onValue: (value) {
            final jArray = JArray(JString.nullableType, value.length);
            for (var i = 0; i < value.length; i++) {
              jArray[i] = value[i].name.toJString()..releasedBy(arena);
            }
            return jni.PropertyFactory.textWritingMode(jArray);
          },
          onNull: () => jni.PropertyFactory.textWritingMode(null),
        );
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<double> get textRotate =>
      jLayer.getTextRotate().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextRotate;

  @override
  set textRotate(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textRotate$1,
      onValue: (value) =>
          jni.PropertyFactory.textRotate(value.toJFloat()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get textPadding =>
      jLayer.getTextPadding().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextPadding;

  @override
  set textPadding(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textPadding$1,
      onValue: (value) =>
          jni.PropertyFactory.textPadding(value.toJFloat()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<bool> get textKeepUpright =>
      jLayer.getTextKeepUpright().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextKeepUpright;

  @override
  set textKeepUpright(PropertyValue<bool> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textKeepUpright$1,
      onValue: (value) => jni.PropertyFactory.textKeepUpright(
        value.toJBoolean()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<TextTransform> get textTransform =>
      jLayer.getTextTransform().toDartEnum(
        values: TextTransform.values,
        releaseOriginal: true,
      ) ??
      SymbolStyleLayer.defaultTextTransform;

  @override
  set textTransform(PropertyValue<TextTransform> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textTransform$1,
      onValue: (value) => jni.PropertyFactory.textTransform(
        value.name.toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Offset> get textOffset =>
      jLayer.getTextOffset().toDartOffset(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextOffset;

  @override
  set textOffset(PropertyValue<Offset> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textOffset$1,
      onValue: (value) {
        final floats = value.toJFloatArray(arena);
        return jni.PropertyFactory.textOffset(floats);
      },
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<bool> get textAllowOverlap =>
      jLayer.getTextAllowOverlap().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextAllowOverlap;

  @override
  set textAllowOverlap(PropertyValue<bool> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textAllowOverlap$1,
      onValue: (value) => jni.PropertyFactory.textAllowOverlap(
        value.toJBoolean()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<SymbolOverlap>? get textOverlap => throw UnsupportedError(
    'Getting textOverlap is not supported on Android '
    'https://github.com/maplibre/maplibre-native/issues/251',
  );

  @override
  set textOverlap(PropertyValue<SymbolOverlap>? value) {
    throw UnsupportedError(
      'Setting textOverlap is not supported on Android '
      'https://github.com/maplibre/maplibre-native/issues/251',
    );
  }

  @override
  PropertyValue<bool> get textIgnorePlacement =>
      jLayer.getTextIgnorePlacement().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextIgnorePlacement;

  @override
  set textIgnorePlacement(PropertyValue<bool> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textIgnorePlacement$1,
      onValue: (value) => jni.PropertyFactory.textIgnorePlacement(
        value.toJBoolean()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<bool> get textOptional =>
      jLayer.getTextOptional().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextOptional;

  @override
  set textOptional(PropertyValue<bool> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textOptional$1,
      onValue: (value) => jni.PropertyFactory.textOptional(
        value.toJBoolean()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get iconOpacity =>
      jLayer.getIconOpacity().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconOpacity;

  @override
  set iconOpacity(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.iconOpacity$1,
      onValue: (value) =>
          jni.PropertyFactory.iconOpacity(value.toJFloat()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get iconColor =>
      jLayer.getIconColor().toDartColor(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconColor;

  @override
  set iconColor(PropertyValue<Color> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.iconColor$2,
      onValue: (value) => jni.PropertyFactory.iconColor(value.toARGB32()),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get iconHaloColor =>
      jLayer.getIconHaloColor().toDartColor(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconHaloColor;

  @override
  set iconHaloColor(PropertyValue<Color> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.iconHaloColor$2,
      onValue: (value) => jni.PropertyFactory.iconHaloColor(value.toARGB32()),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get iconHaloWidth =>
      jLayer.getIconHaloWidth().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconHaloWidth;

  @override
  set iconHaloWidth(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.iconHaloWidth$1,
      onValue: (value) => jni.PropertyFactory.iconHaloWidth(
        value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get iconHaloBlur =>
      jLayer.getIconHaloBlur().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconHaloBlur;

  @override
  set iconHaloBlur(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.iconHaloBlur$1,
      onValue: (value) =>
          jni.PropertyFactory.iconHaloBlur(value.toJFloat()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Offset> get iconTranslate =>
      jLayer.getIconTranslate().toDartOffset(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconTranslate;

  @override
  set iconTranslate(PropertyValue<Offset> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.iconTranslate$1,
      onValue: (value) {
        final floats = value.toJFloatArray(arena);
        return jni.PropertyFactory.iconTranslate(floats);
      },
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<ReferenceSpace> get iconTranslateAnchor =>
      jLayer.getIconTranslateAnchor().toDartReferenceSpace(
        releaseOriginal: true,
      ) ??
      SymbolStyleLayer.defaultIconTranslateAnchor;

  @override
  set iconTranslateAnchor(PropertyValue<ReferenceSpace> value) =>
      using((arena) {
        final jni.PropertyValue? jProperty;
        if (value.isExpression) {
          final jExpression = value.expression.toJExpression(arena)
            ?..releasedBy(arena);
          jProperty = jni.PropertyFactory.iconTranslateAnchor$1(jExpression);
        } else {
          final jValue = value.value.name.toJString()..releasedBy(arena);
          jProperty = jni.PropertyFactory.iconTranslateAnchor(jValue);
        }
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<double> get textOpacity =>
      jLayer.getTextOpacity().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextOpacity;

  @override
  set textOpacity(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textOpacity$1,
      onValue: (value) =>
          jni.PropertyFactory.textOpacity(value.toJFloat()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get textColor =>
      jLayer.getTextColor().toDartColor(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextColor;

  @override
  set textColor(PropertyValue<Color> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textColor$2,
      onValue: (value) => jni.PropertyFactory.textColor(value.toARGB32()),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get textHaloColor =>
      jLayer.getTextHaloColor().toDartColor(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextHaloColor;

  @override
  set textHaloColor(PropertyValue<Color> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textHaloColor$2,
      onValue: (value) => jni.PropertyFactory.textHaloColor(value.toARGB32()),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get textHaloWidth =>
      jLayer.getTextHaloWidth().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextHaloWidth;

  @override
  set textHaloWidth(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textHaloWidth$1,
      onValue: (value) => jni.PropertyFactory.textHaloWidth(
        value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get textHaloBlur =>
      jLayer.getTextHaloBlur().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextHaloBlur;

  @override
  set textHaloBlur(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textHaloBlur$1,
      onValue: (value) =>
          jni.PropertyFactory.textHaloBlur(value.toJFloat()..releasedBy(arena)),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Offset> get textTranslate =>
      jLayer.getTextTranslate().toDartOffset(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextTranslate;

  @override
  set textTranslate(PropertyValue<Offset> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.textTranslate$1,
      onValue: (value) {
        final floats = value.toJFloatArray(arena);
        return jni.PropertyFactory.textTranslate(floats);
      },
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<ReferenceSpace> get textTranslateAnchor =>
      jLayer.getTextTranslateAnchor().toDartReferenceSpace(
        releaseOriginal: true,
      ) ??
      SymbolStyleLayer.defaultTextTranslateAnchor;

  @override
  set textTranslateAnchor(PropertyValue<ReferenceSpace> value) =>
      using((arena) {
        final jni.PropertyValue? jProperty;
        if (value.isExpression) {
          final jExpression = value.expression.toJExpression(arena)
            ?..releasedBy(arena);
          jProperty = jni.PropertyFactory.textTranslateAnchor$1(jExpression);
        } else {
          final jValue = value.value.name.toJString()..releasedBy(arena);
          jProperty = jni.PropertyFactory.textTranslateAnchor(jValue);
        }
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });
}
