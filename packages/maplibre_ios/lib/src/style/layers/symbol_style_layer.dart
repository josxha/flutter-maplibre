part of 'style_layer.dart';

/// iOS implementation of [SymbolStyleLayer].
class SymbolStyleLayerIos extends StyleLayerIos<MLNSymbolStyleLayer>
    implements SymbolStyleLayer {
  /// Default constructor for a [SymbolStyleLayerIos] instance.
  factory SymbolStyleLayerIos({
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
    required PropertyValue<List<OneOf2<String, Offset>>>?
    textVariableAnchorOffset,
    required PropertyValue<TextAnchor> textAnchor,
    required PropertyValue<double> textMaxAngle,
    required PropertyValue<List<TextWritingMode>>? textWritingMode,
    required PropertyValue<double> textRotate,
    required PropertyValue<double> textPadding,
    required PropertyValue<bool> textKeepUpright,
    required PropertyValue<TextTransform> textTransform,
    required PropertyValue<Offset> textOffset,
    required PropertyValue<bool> textAllowOverlap,
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
    required PropertyValue<ReferenceSpace> textTranslateAnchor,
  }) {
    final layer = SymbolStyleLayerIos.fromNativeLayer(
      MLNSymbolStyleLayer.new$()..initWithIdentifier(
        id.toNSString(),
        source: MLNSource()..initWithIdentifier(sourceId.toNSString()),
      ),
    );

    layer.minZoom = minZoom;
    layer.maxZoom = maxZoom;
    layer.visible = visible;
    if (filter != null) layer.filter = filter;
    if (sourceLayerId != null) layer.sourceLayerId = sourceLayerId;

    layer.sortKey = sortKey;
    layer.placement = placement;
    layer.spacing = spacing;
    layer.avoidEdges = avoidEdges;
    layer.zOrder = zOrder;
    layer.iconAllowOverlap = iconAllowOverlap;
    layer.iconOverlap = iconOverlap;
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
    layer.textOverlap = textOverlap;
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

    return layer;
  }

  /// Construct a [SymbolStyleLayerIos] from a ObjC layer.
  SymbolStyleLayerIos.fromNativeLayer(super.ffiLayer) : super.fromNativeLayer();

  @override
  PropertyValue<SymbolPlacement> get placement =>
      ffiLayer.symbolPlacement.toEnumPropertyValue(SymbolPlacement.values) ??
      SymbolStyleLayer.defaultPlacement;

  @override
  set placement(PropertyValue<SymbolPlacement> property) {
    if (property.isExpression) {
      ffiLayer.symbolPlacement = property.expression.toNSExpression();
    } else {
      ffiLayer.symbolPlacement = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<double> get spacing =>
      ffiLayer.symbolSpacing.toPropertyValue() ??
      SymbolStyleLayer.defaultSpacing;

  @override
  set spacing(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.symbolSpacing = property.expression.toNSExpression();
    } else {
      ffiLayer.symbolSpacing = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<bool> get avoidEdges =>
      ffiLayer.symbolAvoidsEdges.toPropertyValue() ??
      SymbolStyleLayer.defaultAvoidEdges;

  @override
  set avoidEdges(PropertyValue<bool> property) {
    if (property.isExpression) {
      ffiLayer.symbolAvoidsEdges = property.expression.toNSExpression();
    } else {
      ffiLayer.symbolAvoidsEdges = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<SymbolZOrder> get zOrder =>
      ffiLayer.symbolZOrder.toEnumPropertyValue(SymbolZOrder.values) ??
      SymbolStyleLayer.defaultZOrder;

  @override
  set zOrder(PropertyValue<SymbolZOrder> property) {
    if (property.isExpression) {
      ffiLayer.symbolZOrder = property.expression.toNSExpression();
    } else {
      ffiLayer.symbolZOrder = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<double>? get sortKey =>
      ffiLayer.symbolSortKey.toPropertyValue();

  @override
  set sortKey(PropertyValue<double>? property) {
    if (property == null) {
      ffiLayer.symbolSortKey = NSExpression.expressionForConstantValue(null);
    } else if (property.isExpression) {
      ffiLayer.symbolSortKey = property.expression.toNSExpression();
    } else {
      ffiLayer.symbolSortKey = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<bool> get iconAllowOverlap =>
      ffiLayer.iconAllowsOverlap.toPropertyValue() ??
      SymbolStyleLayer.defaultIconAllowOverlap;

  @override
  set iconAllowOverlap(PropertyValue<bool> property) {
    if (property.isExpression) {
      ffiLayer.iconAllowsOverlap = property.expression.toNSExpression();
    } else {
      ffiLayer.iconAllowsOverlap = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<SymbolOverlap> get iconOverlap =>
      ffiLayer.iconAllowOverlap.toEnumPropertyValue(SymbolOverlap.values) ??
      SymbolStyleLayer.defaultIconOverlap;

  @override
  set iconOverlap(PropertyValue<SymbolOverlap> property) {
    if (property.isExpression) {
      ffiLayer.iconAllowOverlap = property.expression.toNSExpression();
    } else {
      ffiLayer.iconAllowOverlap = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<bool> get iconIgnorePlacement =>
      ffiLayer.iconIgnoresPlacement.toPropertyValue() ??
      SymbolStyleLayer.defaultIconIgnorePlacement;

  @override
  set iconIgnorePlacement(PropertyValue<bool> property) {
    if (property.isExpression) {
      ffiLayer.iconIgnoresPlacement = property.expression.toNSExpression();
    } else {
      ffiLayer.iconIgnoresPlacement = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<bool> get iconOptional =>
      ffiLayer.isIconOptional.toPropertyValue() ??
      SymbolStyleLayer.defaultIconOptional;

  @override
  set iconOptional(PropertyValue<bool> property) {
    if (property.isExpression) {
      ffiLayer.isIconOptional = property.expression.toNSExpression();
    } else {
      ffiLayer.isIconOptional = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<IconRotationAlignment> get iconRotationAlignment =>
      ffiLayer.iconRotationAlignment.toEnumPropertyValue(
        IconRotationAlignment.values,
      ) ??
      SymbolStyleLayer.defaultIconRotationAlignment;

  @override
  set iconRotationAlignment(PropertyValue<IconRotationAlignment> property) {
    if (property.isExpression) {
      ffiLayer.iconRotationAlignment = property.expression.toNSExpression();
    } else {
      ffiLayer.iconRotationAlignment = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<double> get iconSize =>
      ffiLayer.iconScale.toPropertyValue() ?? SymbolStyleLayer.defaultIconSize;

  @override
  set iconSize(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.iconScale = property.expression.toNSExpression();
    } else {
      ffiLayer.iconScale = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<IconTextFit> get iconTextFit =>
      ffiLayer.iconTextFit.toEnumPropertyValue(IconTextFit.values) ??
      SymbolStyleLayer.defaultIconTextFit;

  @override
  set iconTextFit(PropertyValue<IconTextFit> property) {
    if (property.isExpression) {
      ffiLayer.iconTextFit = property.expression.toNSExpression();
    } else {
      ffiLayer.iconTextFit = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<EdgeInsets> get iconTextFitPadding =>
      ffiLayer.iconTextFitPadding.toEdgeInsetsPropertyValue() ??
      SymbolStyleLayer.defaultIconTextFitPadding;

  @override
  set iconTextFitPadding(PropertyValue<EdgeInsets> property) {
    if (property.isExpression) {
      ffiLayer.iconTextFitPadding = property.expression.toNSExpression();
    } else {
      ffiLayer.iconTextFitPadding = NSExpression.expressionForConstantValue(
        [
          property.value.top,
          property.value.left,
          property.value.bottom,
          property.value.right,
        ].toNSArray(),
      );
    }
  }

  @override
  PropertyValue<String>? get iconImage =>
      ffiLayer.iconImageName.toPropertyValue();

  @override
  set iconImage(PropertyValue<String>? property) {
    if (property == null) {
      ffiLayer.iconImageName = NSExpression.expressionForConstantValue(null);
    } else if (property.isExpression) {
      ffiLayer.iconImageName = property.expression.toNSExpression();
    } else {
      ffiLayer.iconImageName = NSExpression.expressionForConstantValue(
        property.value.toNSString(),
      );
    }
  }

  @override
  PropertyValue<double> get iconRotate =>
      ffiLayer.iconRotation.toPropertyValue() ??
      SymbolStyleLayer.defaultIconRotate;

  @override
  set iconRotate(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.iconRotation = property.expression.toNSExpression();
    } else {
      ffiLayer.iconRotation = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<EdgeInsets> get iconPadding =>
      ffiLayer.iconPadding.toEdgeInsetsPropertyValue() ??
      SymbolStyleLayer.defaultIconPadding;

  @override
  set iconPadding(PropertyValue<EdgeInsets> property) {
    if (property.isExpression) {
      ffiLayer.iconPadding = property.expression.toNSExpression();
    } else {
      ffiLayer.iconPadding = NSExpression.expressionForConstantValue(
        [
          property.value.top,
          property.value.left,
          property.value.bottom,
          property.value.right,
        ].toNSArray(),
      );
    }
  }

  @override
  PropertyValue<bool> get iconKeepUpright =>
      ffiLayer.keepsIconUpright.toPropertyValue() ??
      SymbolStyleLayer.defaultIconKeepUpright;

  @override
  set iconKeepUpright(PropertyValue<bool> property) {
    if (property.isExpression) {
      ffiLayer.keepsIconUpright = property.expression.toNSExpression();
    } else {
      ffiLayer.keepsIconUpright = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<Offset> get iconOffset =>
      ffiLayer.iconOffset.toOffsetPropertyValue() ??
      SymbolStyleLayer.defaultIconOffset;

  @override
  set iconOffset(PropertyValue<Offset> property) {
    if (property.isExpression) {
      ffiLayer.iconOffset = property.expression.toNSExpression();
    } else {
      ffiLayer.iconOffset = NSExpression.expressionForConstantValue(
        [property.value.dx, property.value.dy].toNSArray(),
      );
    }
  }

  @override
  PropertyValue<IconAnchor> get iconAnchor =>
      ffiLayer.iconAnchor.toEnumPropertyValue(IconAnchor.values) ??
      SymbolStyleLayer.defaultIconAnchor;

  @override
  set iconAnchor(PropertyValue<IconAnchor> property) {
    if (property.isExpression) {
      ffiLayer.iconAnchor = property.expression.toNSExpression();
    } else {
      ffiLayer.iconAnchor = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<IconPitchAlignment> get iconPitchAlignment =>
      ffiLayer.iconPitchAlignment.toEnumPropertyValue(
        IconPitchAlignment.values,
      ) ??
      SymbolStyleLayer.defaultIconPitchAlignment;

  @override
  set iconPitchAlignment(PropertyValue<IconPitchAlignment> property) {
    if (property.isExpression) {
      ffiLayer.iconPitchAlignment = property.expression.toNSExpression();
    } else {
      ffiLayer.iconPitchAlignment = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<TextPitchAlignment> get textPitchAlignment =>
      ffiLayer.textPitchAlignment.toEnumPropertyValue(
        TextPitchAlignment.values,
      ) ??
      SymbolStyleLayer.defaultTextPitchAlignment;

  @override
  set textPitchAlignment(PropertyValue<TextPitchAlignment> property) {
    if (property.isExpression) {
      ffiLayer.textPitchAlignment = property.expression.toNSExpression();
    } else {
      ffiLayer.textPitchAlignment = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<TextRotationAlignment> get textRotationAlignment =>
      ffiLayer.textRotationAlignment.toEnumPropertyValue(
        TextRotationAlignment.values,
      ) ??
      SymbolStyleLayer.defaultTextRotationAlignment;

  @override
  set textRotationAlignment(PropertyValue<TextRotationAlignment> property) {
    if (property.isExpression) {
      ffiLayer.textRotationAlignment = property.expression.toNSExpression();
    } else {
      ffiLayer.textRotationAlignment = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<String> get textField =>
      ffiLayer.text.toPropertyValue() ?? SymbolStyleLayer.defaultTextField;

  @override
  set textField(PropertyValue<String> property) {
    if (property.isExpression) {
      ffiLayer.text = property.expression.toNSExpression();
    } else {
      ffiLayer.text = NSExpression.expressionForConstantValue(
        property.value.toNSString(),
      );
    }
  }

  @override
  PropertyValue<List<String>> get textFont => throw UnimplementedError();

  @override
  set textFont(PropertyValue<List<String>> property) {
    if (property.isExpression) {
      ffiLayer.textFontNames = property.expression.toNSExpression();
    } else {
      ffiLayer.textFontNames = NSExpression.expressionForConstantValue(
        property.value
            .map<Object?>((e) => e)
            .toList(growable: false)
            .toNSArray(),
      );
    }
  }

  @override
  PropertyValue<double> get textSize =>
      ffiLayer.textFontSize.toPropertyValue() ??
      SymbolStyleLayer.defaultTextSize;

  @override
  set textSize(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.textFontSize = property.expression.toNSExpression();
    } else {
      ffiLayer.textFontSize = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double> get textMaxWidth =>
      ffiLayer.maximumTextWidth.toPropertyValue() ??
      SymbolStyleLayer.defaultTextMaxWidth;

  @override
  set textMaxWidth(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.maximumTextWidth = property.expression.toNSExpression();
    } else {
      ffiLayer.maximumTextWidth = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double> get textLineHeight =>
      ffiLayer.textLineHeight.toPropertyValue() ??
      SymbolStyleLayer.defaultTextLineHeight;

  @override
  set textLineHeight(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.textLineHeight = property.expression.toNSExpression();
    } else {
      ffiLayer.textLineHeight = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double> get textLetterSpacing =>
      ffiLayer.textLetterSpacing.toPropertyValue() ??
      SymbolStyleLayer.defaultTextLetterSpacing;

  @override
  set textLetterSpacing(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.textLetterSpacing = property.expression.toNSExpression();
    } else {
      ffiLayer.textLetterSpacing = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<TextJustify> get textJustify =>
      ffiLayer.textJustification.toEnumPropertyValue(TextJustify.values) ??
      SymbolStyleLayer.defaultTextJustify;

  @override
  set textJustify(PropertyValue<TextJustify> property) {
    if (property.isExpression) {
      ffiLayer.textJustification = property.expression.toNSExpression();
    } else {
      ffiLayer.textJustification = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<double> get textRadialOffset =>
      ffiLayer.textRadialOffset.toPropertyValue() ??
      SymbolStyleLayer.defaultTextRadialOffset;

  @override
  set textRadialOffset(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.textRadialOffset = property.expression.toNSExpression();
    } else {
      ffiLayer.textRadialOffset = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<List<IconAnchor>>? get textVariableAnchor =>
      throw UnimplementedError();

  @override
  set textVariableAnchor(PropertyValue<List<IconAnchor>>? property) {
    if (property == null) {
      ffiLayer.textVariableAnchor = NSExpression.expressionForConstantValue(
        null,
      );
    } else if (property.isExpression) {
      ffiLayer.textVariableAnchor = property.expression.toNSExpression();
    } else {
      ffiLayer.textVariableAnchor = NSExpression.expressionForConstantValue(
        property.value
            .map<Object?>((e) => e.name)
            .toList(growable: false)
            .toNSArray(),
      );
    }
  }

  @override
  PropertyValue<List<OneOf2<String, Offset>>>? get textVariableAnchorOffset =>
      throw UnimplementedError();

  @override
  set textVariableAnchorOffset(
    PropertyValue<List<OneOf2<String, Offset>>>? property,
  ) {
    if (property == null) {
      ffiLayer.textVariableAnchorOffset =
          NSExpression.expressionForConstantValue(null);
    } else if (property.isExpression) {
      ffiLayer.textVariableAnchorOffset = property.expression.toNSExpression();
    } else {
      throw UnimplementedError();
    }
  }

  @override
  PropertyValue<TextAnchor> get textAnchor =>
      ffiLayer.textAnchor.toEnumPropertyValue(TextAnchor.values) ??
      SymbolStyleLayer.defaultTextAnchor;

  @override
  set textAnchor(PropertyValue<TextAnchor> property) {
    if (property.isExpression) {
      ffiLayer.textAnchor = property.expression.toNSExpression();
    } else {
      ffiLayer.textAnchor = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<double> get textMaxAngle =>
      ffiLayer.maximumTextAngle.toPropertyValue() ??
      SymbolStyleLayer.defaultTextMaxAngle;

  @override
  set textMaxAngle(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.maximumTextAngle = property.expression.toNSExpression();
    } else {
      ffiLayer.maximumTextAngle = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<List<TextWritingMode>>? get textWritingMode =>
      throw UnimplementedError();

  @override
  set textWritingMode(PropertyValue<List<TextWritingMode>>? property) {
    if (property == null) {
      ffiLayer.textWritingModes = NSExpression.expressionForConstantValue(null);
    } else if (property.isExpression) {
      ffiLayer.textWritingModes = property.expression.toNSExpression();
    } else {
      ffiLayer.textWritingModes = NSExpression.expressionForConstantValue(
        property.value
            .map<Object?>((e) => e.name)
            .toList(growable: false)
            .toNSArray(),
      );
    }
  }

  @override
  PropertyValue<double> get textRotate =>
      ffiLayer.textRotation.toPropertyValue() ??
      SymbolStyleLayer.defaultTextRotate;

  @override
  set textRotate(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.textRotation = property.expression.toNSExpression();
    } else {
      ffiLayer.textRotation = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double> get textPadding =>
      ffiLayer.textPadding.toPropertyValue() ??
      SymbolStyleLayer.defaultTextPadding;

  @override
  set textPadding(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.textPadding = property.expression.toNSExpression();
    } else {
      ffiLayer.textPadding = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<bool> get textKeepUpright =>
      ffiLayer.keepsTextUpright.toPropertyValue() ??
      SymbolStyleLayer.defaultTextKeepUpright;

  @override
  set textKeepUpright(PropertyValue<bool> property) {
    if (property.isExpression) {
      ffiLayer.keepsTextUpright = property.expression.toNSExpression();
    } else {
      ffiLayer.keepsTextUpright = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<TextTransform> get textTransform =>
      ffiLayer.textTransform.toEnumPropertyValue(TextTransform.values) ??
      SymbolStyleLayer.defaultTextTransform;

  @override
  set textTransform(PropertyValue<TextTransform> property) {
    if (property.isExpression) {
      ffiLayer.textTransform = property.expression.toNSExpression();
    } else {
      ffiLayer.textTransform = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<Offset> get textOffset =>
      ffiLayer.textOffset.toOffsetPropertyValue() ??
      SymbolStyleLayer.defaultTextOffset;

  @override
  set textOffset(PropertyValue<Offset> property) {
    if (property.isExpression) {
      ffiLayer.textOffset = property.expression.toNSExpression();
    } else {
      ffiLayer.textOffset = NSExpression.expressionForConstantValue(
        [property.value.dx, property.value.dy].toNSArray(),
      );
    }
  }

  @override
  PropertyValue<bool> get textAllowOverlap =>
      ffiLayer.textAllowsOverlap.toPropertyValue() ??
      SymbolStyleLayer.defaultTextAllowOverlap;

  @override
  set textAllowOverlap(PropertyValue<bool> property) {
    if (property.isExpression) {
      ffiLayer.textAllowsOverlap = property.expression.toNSExpression();
    } else {
      ffiLayer.textAllowsOverlap = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<SymbolOverlap>? get textOverlap =>
      ffiLayer.textAllowOverlap.toEnumPropertyValue(SymbolOverlap.values);

  @override
  set textOverlap(PropertyValue<SymbolOverlap>? property) {
    if (property == null) {
      ffiLayer.textAllowOverlap = NSExpression.expressionForConstantValue(null);
    } else if (property.isExpression) {
      ffiLayer.textAllowOverlap = property.expression.toNSExpression();
    } else {
      ffiLayer.textAllowOverlap = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<bool> get textIgnorePlacement =>
      ffiLayer.textIgnoresPlacement.toPropertyValue() ??
      SymbolStyleLayer.defaultTextIgnorePlacement;

  @override
  set textIgnorePlacement(PropertyValue<bool> property) {
    if (property.isExpression) {
      ffiLayer.textIgnoresPlacement = property.expression.toNSExpression();
    } else {
      ffiLayer.textIgnoresPlacement = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<bool> get textOptional =>
      ffiLayer.isTextOptional.toPropertyValue() ??
      SymbolStyleLayer.defaultTextOptional;

  @override
  set textOptional(PropertyValue<bool> property) {
    if (property.isExpression) {
      ffiLayer.isTextOptional = property.expression.toNSExpression();
    } else {
      ffiLayer.isTextOptional = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double> get iconOpacity =>
      ffiLayer.iconOpacity.toPropertyValue() ??
      SymbolStyleLayer.defaultIconOpacity;

  @override
  set iconOpacity(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.iconOpacity = property.expression.toNSExpression();
    } else {
      ffiLayer.iconOpacity = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<Color> get iconColor =>
      ffiLayer.iconColor.toColorPropertyValue() ??
      SymbolStyleLayer.defaultIconColor;

  @override
  set iconColor(PropertyValue<Color> property) {
    if (property.isExpression) {
      ffiLayer.iconColor = property.expression.toNSExpression();
    } else {
      ffiLayer.iconColor = NSExpression.expressionForConstantValue(
        property.value.toUIColor(),
      );
    }
  }

  @override
  PropertyValue<Color> get iconHaloColor =>
      ffiLayer.iconHaloColor.toColorPropertyValue() ??
      SymbolStyleLayer.defaultIconHaloColor;

  @override
  set iconHaloColor(PropertyValue<Color> property) {
    if (property.isExpression) {
      ffiLayer.iconHaloColor = property.expression.toNSExpression();
    } else {
      ffiLayer.iconHaloColor = NSExpression.expressionForConstantValue(
        property.value.toUIColor(),
      );
    }
  }

  @override
  PropertyValue<double> get iconHaloWidth =>
      ffiLayer.iconHaloWidth.toPropertyValue() ??
      SymbolStyleLayer.defaultIconHaloWidth;

  @override
  set iconHaloWidth(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.iconHaloWidth = property.expression.toNSExpression();
    } else {
      ffiLayer.iconHaloWidth = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double> get iconHaloBlur =>
      ffiLayer.iconHaloBlur.toPropertyValue() ??
      SymbolStyleLayer.defaultIconHaloBlur;

  @override
  set iconHaloBlur(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.iconHaloBlur = property.expression.toNSExpression();
    } else {
      ffiLayer.iconHaloBlur = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<Offset> get iconTranslate =>
      ffiLayer.iconTranslation.toOffsetPropertyValue() ??
      SymbolStyleLayer.defaultIconTranslate;

  @override
  set iconTranslate(PropertyValue<Offset> property) {
    if (property.isExpression) {
      ffiLayer.iconTranslation = property.expression.toNSExpression();
    } else {
      ffiLayer.iconTranslation = NSExpression.expressionForConstantValue(
        [property.value.dx, property.value.dy].toNSArray(),
      );
    }
  }

  @override
  PropertyValue<ReferenceSpace> get iconTranslateAnchor =>
      ffiLayer.iconTranslationAnchor.toEnumPropertyValue(
        ReferenceSpace.values,
      ) ??
      SymbolStyleLayer.defaultIconTranslateAnchor;

  @override
  set iconTranslateAnchor(PropertyValue<ReferenceSpace> property) {
    if (property.isExpression) {
      ffiLayer.iconTranslationAnchor = property.expression.toNSExpression();
    } else {
      ffiLayer.iconTranslationAnchor = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<double> get textOpacity =>
      ffiLayer.textOpacity.toPropertyValue() ??
      SymbolStyleLayer.defaultTextOpacity;

  @override
  set textOpacity(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.textOpacity = property.expression.toNSExpression();
    } else {
      ffiLayer.textOpacity = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<Color> get textColor =>
      ffiLayer.textColor.toColorPropertyValue() ??
      SymbolStyleLayer.defaultTextColor;

  @override
  set textColor(PropertyValue<Color> property) {
    if (property.isExpression) {
      ffiLayer.textColor = property.expression.toNSExpression();
    } else {
      ffiLayer.textColor = NSExpression.expressionForConstantValue(
        property.value.toUIColor(),
      );
    }
  }

  @override
  PropertyValue<Color> get textHaloColor =>
      ffiLayer.textHaloColor.toColorPropertyValue() ??
      SymbolStyleLayer.defaultTextHaloColor;

  @override
  set textHaloColor(PropertyValue<Color> property) {
    if (property.isExpression) {
      ffiLayer.textHaloColor = property.expression.toNSExpression();
    } else {
      ffiLayer.textHaloColor = NSExpression.expressionForConstantValue(
        property.value.toUIColor(),
      );
    }
  }

  @override
  PropertyValue<double> get textHaloWidth =>
      ffiLayer.textHaloWidth.toPropertyValue() ??
      SymbolStyleLayer.defaultTextHaloWidth;

  @override
  set textHaloWidth(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.textHaloWidth = property.expression.toNSExpression();
    } else {
      ffiLayer.textHaloWidth = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double> get textHaloBlur =>
      ffiLayer.textHaloBlur.toPropertyValue() ??
      SymbolStyleLayer.defaultTextHaloBlur;

  @override
  set textHaloBlur(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.textHaloBlur = property.expression.toNSExpression();
    } else {
      ffiLayer.textHaloBlur = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<Offset> get textTranslate =>
      ffiLayer.textTranslation.toOffsetPropertyValue() ??
      SymbolStyleLayer.defaultTextTranslate;

  @override
  set textTranslate(PropertyValue<Offset> property) {
    if (property.isExpression) {
      ffiLayer.textTranslation = property.expression.toNSExpression();
    } else {
      ffiLayer.textTranslation = NSExpression.expressionForConstantValue(
        [property.value.dx, property.value.dy].toNSArray(),
      );
    }
  }

  @override
  PropertyValue<ReferenceSpace> get textTranslateAnchor =>
      ffiLayer.textTranslationAnchor.toEnumPropertyValue(
        ReferenceSpace.values,
      ) ??
      SymbolStyleLayer.defaultTextTranslateAnchor;

  @override
  set textTranslateAnchor(PropertyValue<ReferenceSpace> property) {
    if (property.isExpression) {
      ffiLayer.textTranslationAnchor = property.expression.toNSExpression();
    } else {
      ffiLayer.textTranslationAnchor = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  Expression? get filter => ffiLayer.predicate?.toExpression();

  @override
  set filter(Expression expression) {
    ffiLayer.predicate = expression.toNSPredicate();
  }

  @override
  String? get sourceLayerId => ffiLayer.sourceLayerIdentifier?.toDartString();

  @override
  set sourceLayerId(String? value) {
    ffiLayer.sourceLayerIdentifier = value?.toNSString();
  }

  @override
  String get sourceId => ffiLayer.sourceIdentifier!.toDartString();
}
