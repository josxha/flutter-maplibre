part of 'style_layer.dart';

/// iOS implementation of [LineStyleLayer].
class LineStyleLayerIos extends StyleLayerIos<MLNLineStyleLayer>
    implements LineStyleLayer {
  /// Default constructor for a [LineStyleLayerIos] instance.
  factory LineStyleLayerIos({
    required String id,
    required String sourceId,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required String? sourceLayerId,
    required Expression? filter,
    required PropertyValue<double>? sortKey,
    required PropertyValue<Offset> translate,
    required PropertyValue<ReferenceSpace> translateAnchor,
    required PropertyValue<LineCap> cap,
    required PropertyValue<LineJoin> join,
    required PropertyValue<double> miterLimit,
    required PropertyValue<double> roundLimit,
    required PropertyValue<double> opacity,
    required PropertyValue<Color> color,
    required PropertyValue<double> width,
    required PropertyValue<double> gapWidth,
    required PropertyValue<double> offset,
    required PropertyValue<double> blur,
    required PropertyValue<List<double>>? dashArray,
    required PropertyValue<String>? pattern,
    required PropertyValue<Color>? gradient,
  }) {
    final layer = LineStyleLayerIos.fromNativeLayer(
      MLNLineStyleLayer.new$()..initWithIdentifier(
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
    layer.translate = translate;
    layer.translateAnchor = translateAnchor;
    layer.cap = cap;
    layer.join = join;
    layer.miterLimit = miterLimit;
    layer.roundLimit = roundLimit;
    layer.opacity = opacity;
    layer.color = color;
    layer.width = width;
    layer.gapWidth = gapWidth;
    layer.offset = offset;
    layer.blur = blur;
    layer.dashArray = dashArray;
    if (pattern != null) layer.pattern = pattern;
    layer.gradient = gradient;
    return layer;
  }

  /// Construct a [LineStyleLayerIos] from a ObjC layer.
  LineStyleLayerIos.fromNativeLayer(super.ffiLayer) : super.fromNativeLayer();

  @override
  PropertyValue<LineCap> get cap =>
      ffiLayer.lineCap.toEnumPropertyValue(LineCap.values) ??
      LineStyleLayer.defaultCap;

  @override
  set cap(PropertyValue<LineCap> property) {
    if (property.isExpression) {
      ffiLayer.lineCap = property.expression.toNSExpression();
    } else {
      ffiLayer.lineCap = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<LineJoin> get join =>
      ffiLayer.lineJoin.toEnumPropertyValue(LineJoin.values) ??
      LineStyleLayer.defaultJoin;

  @override
  set join(PropertyValue<LineJoin> property) {
    if (property.isExpression) {
      ffiLayer.lineJoin = property.expression.toNSExpression();
    } else {
      ffiLayer.lineJoin = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<double> get miterLimit =>
      ffiLayer.lineMiterLimit.toPropertyValue() ??
      LineStyleLayer.defaultMiterLimit;

  @override
  set miterLimit(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.lineMiterLimit = property.expression.toNSExpression();
    } else {
      ffiLayer.lineMiterLimit = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double> get roundLimit =>
      ffiLayer.lineRoundLimit.toPropertyValue() ??
      LineStyleLayer.defaultRoundLimit;

  @override
  set roundLimit(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.lineRoundLimit = property.expression.toNSExpression();
    } else {
      ffiLayer.lineRoundLimit = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double> get opacity =>
      ffiLayer.lineOpacity.toPropertyValue() ?? LineStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.lineOpacity = property.expression.toNSExpression();
    } else {
      ffiLayer.lineOpacity = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<Color> get color =>
      ffiLayer.lineColor.toColorPropertyValue() ?? LineStyleLayer.defaultColor;

  @override
  set color(PropertyValue<Color> property) {
    if (property.isExpression) {
      ffiLayer.lineColor = property.expression.toNSExpression();
    } else {
      ffiLayer.lineColor = NSExpression.expressionForConstantValue(
        property.value.toUIColor(),
      );
    }
  }

  @override
  PropertyValue<double> get width =>
      ffiLayer.lineWidth.toPropertyValue() ?? LineStyleLayer.defaultWidth;

  @override
  set width(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.lineWidth = property.expression.toNSExpression();
    } else {
      ffiLayer.lineWidth = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double> get gapWidth =>
      ffiLayer.lineGapWidth.toPropertyValue() ?? LineStyleLayer.defaultGapWidth;

  @override
  set gapWidth(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.lineGapWidth = property.expression.toNSExpression();
    } else {
      ffiLayer.lineGapWidth = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double> get offset =>
      ffiLayer.lineOffset.toPropertyValue() ?? LineStyleLayer.defaultOffset;

  @override
  set offset(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.lineOffset = property.expression.toNSExpression();
    } else {
      ffiLayer.lineOffset = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<double> get blur =>
      ffiLayer.lineBlur.toPropertyValue() ?? LineStyleLayer.defaultBlur;

  @override
  set blur(PropertyValue<double> property) {
    if (property.isExpression) {
      ffiLayer.lineBlur = property.expression.toNSExpression();
    } else {
      ffiLayer.lineBlur = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
      );
    }
  }

  @override
  PropertyValue<List<double>>? get dashArray {
    final expression = ffiLayer.lineDashPattern;
    if (expression.expressionType ==
        NSExpressionType.NSConstantValueExpressionType) {
      final ffiValue = expression.constantValue;
      if (ffiValue == null) return null;
      final raw = toDartObject(ffiValue, convertOther: toDartObject);
      final list = (raw as List<Object?>)
          .cast<num>()
          .map((e) => e.toDouble())
          .toList(growable: false);
      return PropertyValue.value(list);
    }
    return PropertyValue.expression(expression.toExpression());
  }

  @override
  set dashArray(PropertyValue<List<double>>? property) {
    if (property == null) {
      ffiLayer.lineDashPattern = NSExpression.expressionForConstantValue(null);
    } else if (property.isExpression) {
      ffiLayer.lineDashPattern = property.expression.toNSExpression();
    } else {
      ffiLayer.lineDashPattern = NSExpression.expressionForConstantValue(
        property.value.map<Object?>((e) => e).toList().toNSArray(),
      );
    }
  }

  @override
  PropertyValue<String>? get pattern => ffiLayer.linePattern.toPropertyValue();

  @override
  set pattern(PropertyValue<String>? property) {
    if (property == null) {
      throw UnsupportedError(
        'Removing the pattern property is not supported on iOS',
      );
    } else if (property.isExpression) {
      ffiLayer.linePattern = property.expression.toNSExpression();
    } else {
      ffiLayer.linePattern = NSExpression.expressionForConstantValue(
        property.value.toNSString(),
      );
    }
  }

  @override
  PropertyValue<Color>? get gradient =>
      ffiLayer.lineGradient.toColorPropertyValue();

  @override
  set gradient(PropertyValue<Color>? property) {
    if (property == null) {
      ffiLayer.lineGradient = NSExpression.expressionForConstantValue(null);
    } else if (property.isExpression) {
      ffiLayer.lineGradient = property.expression.toNSExpression();
    } else {
      ffiLayer.lineGradient = NSExpression.expressionForConstantValue(
        property.value.toUIColor(),
      );
    }
  }

  @override
  PropertyValue<Offset> get translate =>
      ffiLayer.lineTranslation.toOffsetPropertyValue() ??
      StyleLayerWithTranslate.defaultTranslate;

  @override
  set translate(PropertyValue<Offset> property) {
    if (property.isExpression) {
      ffiLayer.lineTranslation = property.expression.toNSExpression();
    } else {
      ffiLayer.lineTranslation = NSExpression.expressionForConstantValue(
        [property.value.dx, property.value.dy].toNSArray(),
      );
    }
  }

  @override
  PropertyValue<ReferenceSpace> get translateAnchor =>
      ffiLayer.lineTranslationAnchor.toEnumPropertyValue(
        ReferenceSpace.values,
      ) ??
      StyleLayerWithTranslate.defaultTranslateAnchor;

  @override
  set translateAnchor(PropertyValue<ReferenceSpace> property) {
    if (property.isExpression) {
      ffiLayer.lineTranslationAnchor = property.expression.toNSExpression();
    } else {
      ffiLayer.lineTranslationAnchor = NSExpression.expressionForConstantValue(
        property.value.name.toNSString(),
      );
    }
  }

  @override
  PropertyValue<double>? get sortKey => ffiLayer.lineSortKey.toPropertyValue();

  @override
  set sortKey(PropertyValue<double>? property) {
    if (property == null) {
      ffiLayer.lineSortKey = NSExpression.expressionForConstantValue(null);
    } else if (property.isExpression) {
      ffiLayer.lineSortKey = property.expression.toNSExpression();
    } else {
      ffiLayer.lineSortKey = NSExpression.expressionForConstantValue(
        property.value.toNSNumber(),
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
