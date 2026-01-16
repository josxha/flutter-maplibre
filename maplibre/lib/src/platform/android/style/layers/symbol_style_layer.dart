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
    // NOTE: These are passed by the public factory but the current
    // SymbolStyleLayer interface does not expose them.
    required PropertyValue<Offset> translate,
    required PropertyValue<ReferenceSpace> translateAnchor,
    required PropertyValue<SymbolPlacement> placement,
    required PropertyValue<double> spacing,
    required PropertyValue<bool> avoidEdges,
    required PropertyValue<SymbolZOrder> zOrder,
    required PropertyValue<bool> iconAllowOverlap,
    required PropertyValue<SymbolOverlap> iconOverlap,
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
    required PropertyValue<List<Object>>? textVariableAnchorOffset,
    required PropertyValue<TextAnchor> textAnchor,
    required PropertyValue<double> textMaxAngle,
    required PropertyValue<List<TextWritingMode>>? textWritingMode,
    required PropertyValue<double> textRotate,
    required PropertyValue<double> textPadding,
    required PropertyValue<bool> textKeepUpright,
    required PropertyValue<TextTransform> textTransform,
    required PropertyValue<Offset> textOffset,
    PropertyValue<bool> textAllowOverlap =
        SymbolStyleLayer.defaultTextAllowOverlap,
    required PropertyValue<SymbolOverlap>? textOverlap,
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
  }) => using((arena) {
    final layer =
        SymbolStyleLayerAndroid.fromNativeLayer(
            jni.SymbolLayer(
              id.toJString()..releasedBy(arena),
              sourceId.toJString()..releasedBy(arena),
            )..releasedBy(arena),
          )
          ..minZoom = minZoom
          ..maxZoom = maxZoom
          ..visible = visible
          ..filter = filter
          ..sortKey = sortKey
          ..placement = placement
          ..spacing = spacing
          ..avoidEdges = avoidEdges
          ..zOrder = zOrder
          ..iconAllowOverlap = iconAllowOverlap
          ..iconOverlap = iconOverlap
          ..iconIgnorePlacement = iconIgnorePlacement
          ..iconOptional = iconOptional
          ..iconRotationAlignment = iconRotationAlignment
          ..iconSize = iconSize
          ..iconTextFit = iconTextFit
          ..iconTextFitPadding = iconTextFitPadding
          ..iconImage = iconImage
          ..iconRotate = iconRotate
          ..iconPadding = iconPadding
          ..iconKeepUpright = iconKeepUpright
          ..iconOffset = iconOffset
          ..iconAnchor = iconAnchor
          ..iconPitchAlignment = iconPitchAlignment
          ..textPitchAlignment = textPitchAlignment
          ..textRotationAlignment = textRotationAlignment
          ..textField = textField
          ..textFont = textFont
          ..textSize = textSize
          ..textMaxWidth = textMaxWidth
          ..textLineHeight = textLineHeight
          ..textLetterSpacing = textLetterSpacing
          ..textJustify = textJustify
          ..textRadialOffset = textRadialOffset
          ..textVariableAnchor = textVariableAnchor
          ..textVariableAnchorOffset = textVariableAnchorOffset
          ..textAnchor = textAnchor
          ..textMaxAngle = textMaxAngle
          ..textWritingMode = textWritingMode
          ..textRotate = textRotate
          ..textPadding = textPadding
          ..textKeepUpright = textKeepUpright
          ..textTransform = textTransform
          ..textOffset = textOffset
          ..textAllowOverlap = textAllowOverlap
          ..textOverlap = textOverlap
          ..textIgnorePlacement = textIgnorePlacement
          ..textOptional = textOptional
          ..iconOpacity = iconOpacity
          ..iconColor = iconColor
          ..iconHaloColor = iconHaloColor
          ..iconHaloWidth = iconHaloWidth
          ..iconHaloBlur = iconHaloBlur
          ..iconTranslate = iconTranslate
          ..iconTranslateAnchor = iconTranslateAnchor
          ..textOpacity = textOpacity
          ..textColor = textColor
          ..textHaloColor = textHaloColor
          ..textHaloWidth = textHaloWidth
          ..textHaloBlur = textHaloBlur
          ..textTranslate = textTranslate
          ..textTranslateAnchor = translateAnchor;
    if (sourceLayerId != null) layer.sourceLayerId = sourceLayerId;
    return layer;
  });

  /// Construct a [SymbolStyleLayerAndroid] from a JNI layer.
  SymbolStyleLayerAndroid.fromNativeLayer(super.jLayer)
    : super.fromNativeLayer();

  PropertyValue<SymbolOverlap> _iconOverlap =
      SymbolStyleLayer.defaultIconOverlap;
  PropertyValue<SymbolOverlap>? _textOverlap;
  PropertyValue<String> _textField = SymbolStyleLayer.defaultTextField;
  PropertyValue<List<Object>>? _textVariableAnchorOffset;
  static const _defaultTextVariableAnchorOffset =
      PropertyValue<List<Object>>.value(<Object>[]);

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

  PropertyValue<List<String>>? _stringArrayProperty(
    jni.PropertyValue<JArray<JString?>?> jProperty,
  ) => using((arena) {
    jProperty.releasedBy(arena);
    if (jProperty.isNull$1()) return null;
    if (jProperty.isExpression()) {
      final jExpression = jProperty.getExpression()?..releasedBy(arena);
      final expression = jExpression?.toDart(releaseOriginal: true);
      return expression == null ? null : PropertyValue.expression(expression);
    }
    final jArray = jProperty.getValue();
    if (jArray == null) return null;
    final values = <String>[];
    for (var i = 0; i < jArray.length; i++) {
      final entry = jArray[i];
      if (entry != null) values.add(entry.toDartString(releaseOriginal: true));
    }
    return PropertyValue.value(values);
  });

  PropertyValue<EdgeInsets>? _edgeInsetsProperty(
    jni.PropertyValue<JArray<JFloat?>?> jProperty,
  ) => using((arena) {
    jProperty.releasedBy(arena);
    if (jProperty.isNull$1()) return null;
    if (jProperty.isExpression()) {
      final jExpression = jProperty.getExpression()?..releasedBy(arena);
      final expression = jExpression?.toDart(releaseOriginal: true);
      return expression == null ? null : PropertyValue.expression(expression);
    }
    final jArray = jProperty.getValue();
    if (jArray == null) return null;
    double readOr(double fallback, int index) {
      if (index < 0 || index >= jArray.length) return fallback;
      final entry = jArray[index];
      return entry?.doubleValue(releaseOriginal: true) ?? fallback;
    }

    // Spec order: [top, right, bottom, left]
    final top = readOr(0, 0);
    final right = readOr(top, 1);
    final bottom = readOr(top, 2);
    final left = readOr(right, 3);
    return PropertyValue.value(EdgeInsets.fromLTRB(left, top, right, bottom));
  });

  PropertyValue<List<Object>>? _objectArrayProperty(
    jni.PropertyValue<JArray<JObject?>?> jProperty,
  ) => using((arena) {
    jProperty.releasedBy(arena);
    if (jProperty.isNull$1()) return null;
    if (jProperty.isExpression()) {
      final jExpression = jProperty.getExpression()?..releasedBy(arena);
      final expression = jExpression?.toDart(releaseOriginal: true);
      return expression == null ? null : PropertyValue.expression(expression);
    }
    final jArray = jProperty.getValue();
    if (jArray == null) return null;
    final values = <Object>[];
    for (var i = 0; i < jArray.length; i++) {
      final entry = jArray[i];
      if (entry == null) continue;
      final dynamic dynamicEntry = entry;
      switch (dynamicEntry) {
        case final JString s:
          values.add(s.toDartString(releaseOriginal: true));
        case final JDouble d:
          values.add(d.doubleValue(releaseOriginal: true));
        case final JFloat f:
          values.add(f.doubleValue(releaseOriginal: true));
        case final JLong l:
          values.add(l.longValue(releaseOriginal: true));
        case final JBoolean b:
          values.add(b.booleanValue(releaseOriginal: true));
        default:
          // Fallback: keep an opaque string representation.
          values.add(dynamicEntry.toString());
      }
    }
    return PropertyValue.value(values);
  });

  JArray<JFloat?> _edgeInsetsToJFloatArray(EdgeInsets insets, Arena arena) {
    // Spec order: [top, right, bottom, left]
    final values = <JFloat?>[
      insets.top.toJFloat()..releasedBy(arena),
      insets.right.toJFloat()..releasedBy(arena),
      insets.bottom.toJFloat()..releasedBy(arena),
      insets.left.toJFloat()..releasedBy(arena),
    ];
    return JArray.of(JFloat.nullableType, values)..releasedBy(arena);
  }

  JArray<JString?> _stringListToJStringArray(List<String> values, Arena arena) {
    final jValues = values
        .map((v) => v.toJString()..releasedBy(arena))
        .toList(growable: false);
    return JArray.of(JString.nullableType, jValues)..releasedBy(arena);
  }

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
  set filter(Expression? value) => using((arena) {
    if (value == null) {
      throw UnsupportedError(
        'Android does not support clearing a layer filter (null).',
      );
    }
    final jFilter = value.toJExpression(arena);
    if (jFilter == null) {
      throw ArgumentError.value(value, 'filter', 'Failed to convert filter');
    }
    jLayer.setFilter(jFilter);
  });

  @override
  PropertyValue<double>? get sortKey =>
      jLayer.getSymbolSortKey().toDart(releaseOriginal: true);

  @override
  set sortKey(PropertyValue<double>? value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value == null) {
      jProperty = jni.PropertyFactory.symbolSortKey(null);
    } else if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.symbolSortKey$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.symbolSortKey(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<SymbolPlacement> get placement => _enumProperty(
    jLayer.getSymbolPlacement(),
    SymbolPlacement.values,
    SymbolStyleLayer.defaultPlacement,
  );

  @override
  set placement(PropertyValue<SymbolPlacement> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.symbolPlacement$1(jExpression);
    } else {
      final jValue = value.value.name.toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.symbolPlacement(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get spacing =>
      jLayer.getSymbolSpacing().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultSpacing;

  @override
  set spacing(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.symbolSpacing$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.symbolSpacing(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<bool> get avoidEdges =>
      jLayer.getSymbolAvoidEdges().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultAvoidEdges;

  @override
  set avoidEdges(PropertyValue<bool> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.symbolAvoidEdges$1(jExpression);
    } else {
      final jValue = value.value.toJBoolean()..releasedBy(arena);
      jProperty = jni.PropertyFactory.symbolAvoidEdges(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<SymbolZOrder> get zOrder => _enumProperty(
    jLayer.getSymbolZOrder(),
    SymbolZOrder.values,
    SymbolStyleLayer.defaultZOrder,
  );

  @override
  set zOrder(PropertyValue<SymbolZOrder> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.symbolZOrder$1(jExpression);
    } else {
      final jValue = value.value.name.toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.symbolZOrder(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<bool> get iconAllowOverlap =>
      jLayer.getIconAllowOverlap().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconAllowOverlap;

  @override
  set iconAllowOverlap(PropertyValue<bool> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconAllowOverlap$1(jExpression);
    } else {
      final jValue = value.value.toJBoolean()..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconAllowOverlap(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<SymbolOverlap> get iconOverlap => _iconOverlap;

  @override
  set iconOverlap(PropertyValue<SymbolOverlap> value) {
    _iconOverlap = value;
    if (value.isExpression) {
      throw UnsupportedError(
        'Android SymbolLayer does not expose iconOverlap; use iconAllowOverlap instead.',
      );
    }
    if (value.value == SymbolOverlap.cooperative) {
      throw UnsupportedError(
        'Android SymbolLayer does not support cooperative overlap mode.',
      );
    }
    iconAllowOverlap = PropertyValue.value(value.value == SymbolOverlap.always);
  }

  @override
  PropertyValue<bool> get iconIgnorePlacement =>
      jLayer.getIconIgnorePlacement().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconIgnorePlacement;

  @override
  set iconIgnorePlacement(PropertyValue<bool> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconIgnorePlacement$1(jExpression);
    } else {
      final jValue = value.value.toJBoolean()..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconIgnorePlacement(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<bool> get iconOptional =>
      jLayer.getIconOptional().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconOptional;

  @override
  set iconOptional(PropertyValue<bool> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconOptional$1(jExpression);
    } else {
      final jValue = value.value.toJBoolean()..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconOptional(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<IconRotationAlignment> get iconRotationAlignment =>
      _enumProperty(
        jLayer.getIconRotationAlignment(),
        IconRotationAlignment.values,
        SymbolStyleLayer.defaultIconRotationAlignment,
      );

  @override
  set iconRotationAlignment(PropertyValue<IconRotationAlignment> value) =>
      using((arena) {
        final jni.PropertyValue? jProperty;
        if (value.isExpression) {
          final jExpression = value.expression.toJExpression(arena)
            ?..releasedBy(arena);
          jProperty = jni.PropertyFactory.iconRotationAlignment$1(jExpression);
        } else {
          final jValue = value.value.name.toJString()..releasedBy(arena);
          jProperty = jni.PropertyFactory.iconRotationAlignment(jValue);
        }
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<double> get iconSize =>
      jLayer.getIconSize().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconSize;

  @override
  set iconSize(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconSize$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconSize(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<IconTextFit> get iconTextFit => _enumProperty(
    jLayer.getIconTextFit(),
    IconTextFit.values,
    SymbolStyleLayer.defaultIconTextFit,
  );

  @override
  set iconTextFit(PropertyValue<IconTextFit> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconTextFit$1(jExpression);
    } else {
      final jValue = value.value.name.toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconTextFit(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<EdgeInsets> get iconTextFitPadding =>
      _edgeInsetsProperty(jLayer.getIconTextFitPadding()) ??
      SymbolStyleLayer.defaultIconTextFitPadding;

  @override
  set iconTextFitPadding(PropertyValue<EdgeInsets> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconTextFitPadding$1(jExpression);
    } else {
      final floats = _edgeInsetsToJFloatArray(value.value, arena);
      jProperty = jni.PropertyFactory.iconTextFitPadding(floats);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<String>? get iconImage =>
      jLayer.getIconImage().toDart(releaseOriginal: true);

  @override
  set iconImage(PropertyValue<String>? value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value == null) {
      jProperty = jni.PropertyFactory.iconImage(null);
    } else if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconImage$1(jExpression);
    } else {
      final jValue = value.value.toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconImage(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get iconRotate =>
      jLayer.getIconRotate().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconRotate;

  @override
  set iconRotate(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconRotate$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconRotate(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<EdgeInsets> get iconPadding =>
      _edgeInsetsProperty(jLayer.getIconPadding()) ??
      SymbolStyleLayer.defaultIconPadding;

  @override
  set iconPadding(PropertyValue<EdgeInsets> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconPadding$2(jExpression);
    } else {
      final floats = _edgeInsetsToJFloatArray(value.value, arena);
      jProperty = jni.PropertyFactory.iconPadding$1(floats);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<bool> get iconKeepUpright =>
      jLayer.getIconKeepUpright().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconKeepUpright;

  @override
  set iconKeepUpright(PropertyValue<bool> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconKeepUpright$1(jExpression);
    } else {
      final jValue = value.value.toJBoolean()..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconKeepUpright(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Offset> get iconOffset =>
      jLayer.getIconOffset().toDartOffset(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconOffset;

  @override
  set iconOffset(PropertyValue<Offset> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconOffset$1(jExpression);
    } else {
      final floats = value.value.toJFloatArray(arena);
      jProperty = jni.PropertyFactory.iconOffset(floats);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<IconAnchor> get iconAnchor => _enumProperty(
    jLayer.getIconAnchor(),
    IconAnchor.values,
    SymbolStyleLayer.defaultIconAnchor,
  );

  @override
  set iconAnchor(PropertyValue<IconAnchor> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconAnchor$1(jExpression);
    } else {
      final jValue = value.value.name.toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconAnchor(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<IconPitchAlignment> get iconPitchAlignment => _enumProperty(
    jLayer.getIconPitchAlignment(),
    IconPitchAlignment.values,
    SymbolStyleLayer.defaultIconPitchAlignment,
  );

  @override
  set iconPitchAlignment(PropertyValue<IconPitchAlignment> value) =>
      using((arena) {
        final jni.PropertyValue? jProperty;
        if (value.isExpression) {
          final jExpression = value.expression.toJExpression(arena)
            ?..releasedBy(arena);
          jProperty = jni.PropertyFactory.iconPitchAlignment$1(jExpression);
        } else {
          final jValue = value.value.name.toJString()..releasedBy(arena);
          jProperty = jni.PropertyFactory.iconPitchAlignment(jValue);
        }
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<TextPitchAlignment> get textPitchAlignment => _enumProperty(
    jLayer.getTextPitchAlignment(),
    TextPitchAlignment.values,
    SymbolStyleLayer.defaultTextPitchAlignment,
  );

  @override
  set textPitchAlignment(PropertyValue<TextPitchAlignment> value) =>
      using((arena) {
        final jni.PropertyValue? jProperty;
        if (value.isExpression) {
          final jExpression = value.expression.toJExpression(arena)
            ?..releasedBy(arena);
          jProperty = jni.PropertyFactory.textPitchAlignment$1(jExpression);
        } else {
          final jValue = value.value.name.toJString()..releasedBy(arena);
          jProperty = jni.PropertyFactory.textPitchAlignment(jValue);
        }
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<TextRotationAlignment> get textRotationAlignment =>
      _enumProperty(
        jLayer.getTextRotationAlignment(),
        TextRotationAlignment.values,
        SymbolStyleLayer.defaultTextRotationAlignment,
      );

  @override
  set textRotationAlignment(PropertyValue<TextRotationAlignment> value) =>
      using((arena) {
        final jni.PropertyValue? jProperty;
        if (value.isExpression) {
          final jExpression = value.expression.toJExpression(arena)
            ?..releasedBy(arena);
          jProperty = jni.PropertyFactory.textRotationAlignment$1(jExpression);
        } else {
          final jValue = value.value.name.toJString()..releasedBy(arena);
          jProperty = jni.PropertyFactory.textRotationAlignment(jValue);
        }
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<String> get textField => using((arena) {
    final jProperty = jLayer.getTextField()..releasedBy(arena);
    if (jProperty.isExpression()) {
      final jExpression = jProperty.getExpression()?..releasedBy(arena);
      final expression = jExpression?.toDart(releaseOriginal: true);
      return expression == null
          ? _textField
          : PropertyValue.expression(expression);
    }
    // The Android SDK returns a `Formatted` Java object, which is not
    // currently wrapped in our generated bindings. Keep a Dart-side mirror.
    return _textField;
  });

  @override
  set textField(PropertyValue<String> value) {
    _textField = value;
    using((arena) {
      final jni.PropertyValue? jProperty;
      if (value.isExpression) {
        final jExpression = value.expression.toJExpression(arena)
          ?..releasedBy(arena);
        jProperty = jni.PropertyFactory.textField$2(jExpression);
      } else {
        final jValue = value.value.toJString()..releasedBy(arena);
        jProperty = jni.PropertyFactory.textField(jValue);
      }
      jProperty?.releasedBy(arena);
      jLayer.setProperty(jProperty);
    });
  }

  @override
  PropertyValue<List<String>> get textFont =>
      _stringArrayProperty(jLayer.getTextFont()) ??
      SymbolStyleLayer.defaultTextFont;

  @override
  set textFont(PropertyValue<List<String>> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textFont$1(jExpression);
    } else {
      final strings = _stringListToJStringArray(value.value, arena);
      jProperty = jni.PropertyFactory.textFont(strings);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get textSize =>
      jLayer.getTextSize().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextSize;

  @override
  set textSize(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textSize$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.textSize(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get textMaxWidth =>
      jLayer.getTextMaxWidth().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextMaxWidth;

  @override
  set textMaxWidth(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textMaxWidth$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.textMaxWidth(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get textLineHeight =>
      jLayer.getTextLineHeight().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextLineHeight;

  @override
  set textLineHeight(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textLineHeight$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.textLineHeight(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get textLetterSpacing =>
      jLayer.getTextLetterSpacing().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextLetterSpacing;

  @override
  set textLetterSpacing(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textLetterSpacing$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.textLetterSpacing(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<TextJustify> get textJustify => _enumProperty(
    jLayer.getTextJustify(),
    TextJustify.values,
    SymbolStyleLayer.defaultTextJustify,
  );

  @override
  set textJustify(PropertyValue<TextJustify> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textJustify$1(jExpression);
    } else {
      final jValue = value.value.name.toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.textJustify(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get textRadialOffset =>
      jLayer.getTextRadialOffset().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextRadialOffset;

  @override
  set textRadialOffset(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textRadialOffset$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.textRadialOffset(jValue);
    }
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
        final jni.PropertyValue? jProperty;
        if (value == null) {
          jProperty = jni.PropertyFactory.textVariableAnchor(null);
        } else if (value.isExpression) {
          final jExpression = value.expression.toJExpression(arena)
            ?..releasedBy(arena);
          jProperty = jni.PropertyFactory.textVariableAnchor$1(jExpression);
        } else {
          final strings = _stringListToJStringArray(
            value.value.map((e) => e.name).toList(growable: false),
            arena,
          );
          jProperty = jni.PropertyFactory.textVariableAnchor(strings);
        }
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<List<Object>> get textVariableAnchorOffset =>
      _objectArrayProperty(jLayer.getTextVariableAnchorOffset()) ??
      _textVariableAnchorOffset ??
      _defaultTextVariableAnchorOffset;

  @override
  set textVariableAnchorOffset(PropertyValue<List<Object>>? value) {
    _textVariableAnchorOffset = value;
    using((arena) {
      final jni.PropertyValue? jProperty;
      if (value == null) {
        jProperty = jni.PropertyFactory.textVariableAnchorOffset(null);
      } else if (value.isExpression) {
        final jExpression = value.expression.toJExpression(arena)
          ?..releasedBy(arena);
        jProperty = jni.PropertyFactory.textVariableAnchorOffset$1(jExpression);
      } else {
        final objects = JArray.of(
          JObject.nullableType,
          value.value
              .map((e) => e.toJObject(arena)..releasedBy(arena))
              .toList(growable: false),
        )..releasedBy(arena);
        jProperty = jni.PropertyFactory.textVariableAnchorOffset(objects);
      }
      jProperty?.releasedBy(arena);
      jLayer.setProperty(jProperty);
    });
  }

  @override
  PropertyValue<TextAnchor> get textAnchor => _enumProperty(
    jLayer.getTextAnchor(),
    TextAnchor.values,
    SymbolStyleLayer.defaultTextAnchor,
  );

  @override
  set textAnchor(PropertyValue<TextAnchor> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textAnchor$1(jExpression);
    } else {
      final jValue = value.value.name.toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.textAnchor(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get textMaxAngle =>
      jLayer.getTextMaxAngle().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextMaxAngle;

  @override
  set textMaxAngle(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textMaxAngle$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.textMaxAngle(jValue);
    }
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
        orElse: () => TextWritingMode.horizontal,
      );
      values.add(match);
    }
    return PropertyValue.value(values);
  });

  @override
  set textWritingMode(PropertyValue<List<TextWritingMode>>? value) =>
      using((arena) {
        final jni.PropertyValue? jProperty;
        if (value == null) {
          jProperty = jni.PropertyFactory.textWritingMode(null);
        } else if (value.isExpression) {
          final jExpression = value.expression.toJExpression(arena)
            ?..releasedBy(arena);
          jProperty = jni.PropertyFactory.textWritingMode$1(jExpression);
        } else {
          final strings = _stringListToJStringArray(
            value.value.map((e) => e.name).toList(growable: false),
            arena,
          );
          jProperty = jni.PropertyFactory.textWritingMode(strings);
        }
        jProperty?.releasedBy(arena);
        jLayer.setProperty(jProperty);
      });

  @override
  PropertyValue<double> get textRotate =>
      jLayer.getTextRotate().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextRotate;

  @override
  set textRotate(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textRotate$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.textRotate(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get textPadding =>
      jLayer.getTextPadding().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextPadding;

  @override
  set textPadding(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textPadding$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.textPadding(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<bool> get textKeepUpright =>
      jLayer.getTextKeepUpright().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextKeepUpright;

  @override
  set textKeepUpright(PropertyValue<bool> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textKeepUpright$1(jExpression);
    } else {
      final jValue = value.value.toJBoolean()..releasedBy(arena);
      jProperty = jni.PropertyFactory.textKeepUpright(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<TextTransform> get textTransform => _enumProperty(
    jLayer.getTextTransform(),
    TextTransform.values,
    SymbolStyleLayer.defaultTextTransform,
  );

  @override
  set textTransform(PropertyValue<TextTransform> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textTransform$1(jExpression);
    } else {
      final jValue = value.value.name.toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.textTransform(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Offset> get textOffset =>
      jLayer.getTextOffset().toDartOffset(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextOffset;

  @override
  set textOffset(PropertyValue<Offset> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textOffset$1(jExpression);
    } else {
      final floats = value.value.toJFloatArray(arena);
      jProperty = jni.PropertyFactory.textOffset(floats);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<bool> get textAllowOverlap =>
      jLayer.getTextAllowOverlap().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextAllowOverlap;

  @override
  set textAllowOverlap(PropertyValue<bool> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textAllowOverlap$1(jExpression);
    } else {
      final jValue = value.value.toJBoolean()..releasedBy(arena);
      jProperty = jni.PropertyFactory.textAllowOverlap(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<SymbolOverlap>? get textOverlap => _textOverlap;

  @override
  set textOverlap(PropertyValue<SymbolOverlap>? value) {
    _textOverlap = value;
    if (value == null) return;
    if (value.isExpression) {
      throw UnsupportedError(
        'Android SymbolLayer does not expose textOverlap; use textAllowOverlap instead.',
      );
    }
    if (value.value == SymbolOverlap.cooperative) {
      throw UnsupportedError(
        'Android SymbolLayer does not support cooperative overlap mode.',
      );
    }
    textAllowOverlap = PropertyValue.value(value.value == SymbolOverlap.always);
  }

  @override
  PropertyValue<bool> get textIgnorePlacement =>
      jLayer.getTextIgnorePlacement().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextIgnorePlacement;

  @override
  set textIgnorePlacement(PropertyValue<bool> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textIgnorePlacement$1(jExpression);
    } else {
      final jValue = value.value.toJBoolean()..releasedBy(arena);
      jProperty = jni.PropertyFactory.textIgnorePlacement(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<bool> get textOptional =>
      jLayer.getTextOptional().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextOptional;

  @override
  set textOptional(PropertyValue<bool> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textOptional$1(jExpression);
    } else {
      final jValue = value.value.toJBoolean()..releasedBy(arena);
      jProperty = jni.PropertyFactory.textOptional(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get iconOpacity =>
      jLayer.getIconOpacity().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconOpacity;

  @override
  set iconOpacity(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconOpacity$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconOpacity(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get iconColor =>
      jLayer.getIconColor().toDartColor(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconColor;

  @override
  set iconColor(PropertyValue<Color> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena);
      jProperty = jni.PropertyFactory.iconColor$2(jExpression);
    } else {
      jProperty = jni.PropertyFactory.iconColor(value.value.toARGB32());
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get iconHaloColor =>
      jLayer.getIconHaloColor().toDartColor(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconHaloColor;

  @override
  set iconHaloColor(PropertyValue<Color> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena);
      jProperty = jni.PropertyFactory.iconHaloColor$2(jExpression);
    } else {
      jProperty = jni.PropertyFactory.iconHaloColor(value.value.toARGB32());
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get iconHaloWidth =>
      jLayer.getIconHaloWidth().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconHaloWidth;

  @override
  set iconHaloWidth(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconHaloWidth$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconHaloWidth(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get iconHaloBlur =>
      jLayer.getIconHaloBlur().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconHaloBlur;

  @override
  set iconHaloBlur(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconHaloBlur$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconHaloBlur(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Offset> get iconTranslate =>
      jLayer.getIconTranslate().toDartOffset(releaseOriginal: true) ??
      SymbolStyleLayer.defaultIconTranslate;

  @override
  set iconTranslate(PropertyValue<Offset> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.iconTranslate$1(jExpression);
    } else {
      final floats = value.value.toJFloatArray(arena);
      jProperty = jni.PropertyFactory.iconTranslate(floats);
    }
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
  set textOpacity(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textOpacity$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.textOpacity(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get textColor =>
      jLayer.getTextColor().toDartColor(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextColor;

  @override
  set textColor(PropertyValue<Color> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena);
      jProperty = jni.PropertyFactory.textColor$2(jExpression);
    } else {
      jProperty = jni.PropertyFactory.textColor(value.value.toARGB32());
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get textHaloColor =>
      jLayer.getTextHaloColor().toDartColor(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextHaloColor;

  @override
  set textHaloColor(PropertyValue<Color> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena);
      jProperty = jni.PropertyFactory.textHaloColor$2(jExpression);
    } else {
      jProperty = jni.PropertyFactory.textHaloColor(value.value.toARGB32());
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get textHaloWidth =>
      jLayer.getTextHaloWidth().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextHaloWidth;

  @override
  set textHaloWidth(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textHaloWidth$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.textHaloWidth(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<double> get textHaloBlur =>
      jLayer.getTextHaloBlur().toDart(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextHaloBlur;

  @override
  set textHaloBlur(PropertyValue<double> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textHaloBlur$1(jExpression);
    } else {
      final jValue = value.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.textHaloBlur(jValue);
    }
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Offset> get textTranslate =>
      jLayer.getTextTranslate().toDartOffset(releaseOriginal: true) ??
      SymbolStyleLayer.defaultTextTranslate;

  @override
  set textTranslate(PropertyValue<Offset> value) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (value.isExpression) {
      final jExpression = value.expression.toJExpression(arena)
        ?..releasedBy(arena);
      jProperty = jni.PropertyFactory.textTranslate$1(jExpression);
    } else {
      final floats = value.value.toJFloatArray(arena);
      jProperty = jni.PropertyFactory.textTranslate(floats);
    }
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
