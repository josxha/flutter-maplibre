part of 'style_layer.dart';

/// Android implementation of [LineStyleLayer].
class LineStyleLayerAndroid extends StyleLayerAndroid<jni.LineLayer>
		implements LineStyleLayer {
	/// Factory for a [LineStyleLayerAndroid] instance.
	factory LineStyleLayerAndroid({
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
	}) => using((arena) {
		final layer = LineStyleLayerAndroid.fromNativeLayer(
			jni.LineLayer(
				id.toJString()..releasedBy(arena),
				sourceId.toJString()..releasedBy(arena),
			)..releasedBy(arena),
		)
			..minZoom = minZoom
			..maxZoom = maxZoom
			..visible = visible
			..filter = filter
			..sortKey = sortKey
			..translate = translate
			..translateAnchor = translateAnchor
			..cap = cap
			..join = join
			..miterLimit = miterLimit
			..roundLimit = roundLimit
			..opacity = opacity
			..color = color
			..width = width
			..gapWidth = gapWidth
			..offset = offset
			..blur = blur
			..dashArray = dashArray
			..pattern = pattern
			..gradient = gradient;
		if (sourceLayerId != null) layer.sourceLayerId = sourceLayerId;
		return layer;
	});

	/// Construct a [LineStyleLayerAndroid] from a JNI layer.
	LineStyleLayerAndroid.fromNativeLayer(super.jLayer) : super.fromNativeLayer();

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

	PropertyValue<List<double>>? _doubleArrayProperty(
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
		final values = <double>[];
		for (var i = 0; i < jArray.length; i++) {
			final entry = jArray[i];
			if (entry != null) values.add(entry.floatValue(releaseOriginal: true));
		}
		return PropertyValue.value(values);
	});

	@override
	PropertyValue<LineCap> get cap => _enumProperty(
		jLayer.getLineCap(),
		LineCap.values,
		LineStyleLayer.defaultCap,
	);

	@override
	set cap(PropertyValue<LineCap> value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena)
				?..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineCap$1(jExpression);
		} else {
			final jValue = value.value.name.toJString()..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineCap(jValue);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	@override
	PropertyValue<LineJoin> get join => _enumProperty(
		jLayer.getLineJoin(),
		LineJoin.values,
		LineStyleLayer.defaultJoin,
	);

	@override
	set join(PropertyValue<LineJoin> value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena)
				?..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineJoin$1(jExpression);
		} else {
			final jValue = value.value.name.toJString()..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineJoin(jValue);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	@override
	PropertyValue<double> get miterLimit =>
			jLayer.getLineMiterLimit().toDart(releaseOriginal: true) ??
			LineStyleLayer.defaultMiterLimit;

	@override
	set miterLimit(PropertyValue<double> value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena)
				?..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineMiterLimit$1(jExpression);
		} else {
			final jValue = value.value.toJFloat()..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineMiterLimit(jValue);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	@override
	PropertyValue<double> get roundLimit =>
			jLayer.getLineRoundLimit().toDart(releaseOriginal: true) ??
			LineStyleLayer.defaultRoundLimit;

	@override
	set roundLimit(PropertyValue<double> value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena)
				?..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineRoundLimit$1(jExpression);
		} else {
			final jValue = value.value.toJFloat()..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineRoundLimit(jValue);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	@override
	PropertyValue<double> get opacity =>
			jLayer.getLineOpacity().toDart(releaseOriginal: true) ??
			LineStyleLayer.defaultOpacity;

	@override
	set opacity(PropertyValue<double> value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena)
				?..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineOpacity$1(jExpression);
		} else {
			final jValue = value.value.toJFloat()..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineOpacity(jValue);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	@override
	PropertyValue<Color> get color =>
			jLayer.getLineColor().toDartColor(releaseOriginal: true) ??
			LineStyleLayer.defaultColor;

	@override
	set color(PropertyValue<Color> value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value.isExpression) {
			jProperty = jni.PropertyFactory.lineColor$2(
				value.expression.toJExpression(arena),
			);
		} else {
			final jValue = value.value.toHexString().toJString()
				..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineColor$1(jValue);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	@override
	PropertyValue<double> get width =>
			jLayer.getLineWidth().toDart(releaseOriginal: true) ??
			LineStyleLayer.defaultWidth;

	@override
	set width(PropertyValue<double> value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena)
				?..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineWidth$1(jExpression);
		} else {
			final jValue = value.value.toJFloat()..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineWidth(jValue);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	@override
	PropertyValue<double> get gapWidth =>
			jLayer.getLineGapWidth().toDart(releaseOriginal: true) ??
			LineStyleLayer.defaultGapWidth;

	@override
	set gapWidth(PropertyValue<double> value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena)
				?..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineGapWidth$1(jExpression);
		} else {
			final jValue = value.value.toJFloat()..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineGapWidth(jValue);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	@override
	PropertyValue<double> get offset =>
			jLayer.getLineOffset().toDart(releaseOriginal: true) ??
			LineStyleLayer.defaultOffset;

	@override
	set offset(PropertyValue<double> value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena)
				?..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineOffset$1(jExpression);
		} else {
			final jValue = value.value.toJFloat()..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineOffset(jValue);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	@override
	PropertyValue<double> get blur =>
			jLayer.getLineBlur().toDart(releaseOriginal: true) ??
			LineStyleLayer.defaultBlur;

	@override
	set blur(PropertyValue<double> value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena)
				?..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineBlur$1(jExpression);
		} else {
			final jValue = value.value.toJFloat()..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineBlur(jValue);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	@override
	PropertyValue<List<double>>? get dashArray => _doubleArrayProperty(
		jLayer.getLineDasharray(),
	);

	@override
	set dashArray(PropertyValue<List<double>>? value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value == null) {
			jProperty = jni.PropertyFactory.lineDasharray(null);
		} else if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena)
				?..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineDasharray$1(jExpression);
		} else {
			final list = value.value;
			final jArray = JArray(JFloat.nullableType, list.length)
				..releasedBy(arena);
			for (var i = 0; i < list.length; i++) {
				jArray[i] = list[i].toJFloat()..releasedBy(arena);
			}
			jProperty = jni.PropertyFactory.lineDasharray(jArray);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	@override
	PropertyValue<String>? get pattern =>
			jLayer.getLinePattern().toDart(releaseOriginal: true);

	@override
	set pattern(PropertyValue<String>? value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value == null) {
			jProperty = jni.PropertyFactory.linePattern(null);
		} else if (value.isExpression) {
			jProperty = jni.PropertyFactory.linePattern$1(
				value.expression.toJExpression(arena),
			);
		} else {
			final jValue = value.value.toJString()..releasedBy(arena);
			jProperty = jni.PropertyFactory.linePattern(jValue);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	@override
	PropertyValue<Color>? get gradient => using((arena) {
		final jProperty = jLayer.getLineGradient()..releasedBy(arena);
		if (jProperty.isNull$1()) return null;
		if (jProperty.isExpression()) {
			final jExpression = jProperty.getExpression()?..releasedBy(arena);
			final expression = jExpression?.toDart(releaseOriginal: true);
			return expression == null ? null : PropertyValue.expression(expression);
		}
		final jValue = jProperty.getValue();
		if (jValue == null) return null;
		final value = jValue.toDartString(releaseOriginal: true);
		final color = Color(int.parse(value.replaceFirst('#', '0xFF')));
		return PropertyValue.value(color);
	});

	@override
	set gradient(PropertyValue<Color>? value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value == null) {
			jProperty = jni.PropertyFactory.lineGradient$1(null);
		} else if (value.isExpression) {
			jProperty = jni.PropertyFactory.lineGradient$2(
				value.expression.toJExpression(arena),
			);
		} else {
			final jValue = value.value.toHexString().toJString()
				..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineGradient$1(jValue);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	@override
	PropertyValue<Offset> get translate =>
			jLayer.getLineTranslate().toDartOffset(releaseOriginal: true) ??
			StyleLayerWithTranslate.defaultTranslate;

	@override
	set translate(PropertyValue<Offset> value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena)
				?..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineTranslate$1(jExpression);
		} else {
			final jArray = value.value.toJFloatArray(arena);
			jProperty = jni.PropertyFactory.lineTranslate(jArray);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	@override
	PropertyValue<ReferenceSpace> get translateAnchor =>
			jLayer.getLineTranslateAnchor().toDartReferenceSpace(
				releaseOriginal: true,
			) ??
			StyleLayerWithTranslate.defaultTranslateAnchor;

	@override
	set translateAnchor(PropertyValue<ReferenceSpace> value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena)
				?..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineTranslateAnchor$1(jExpression);
		} else {
			final jValue = value.value.name.toJString()..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineTranslateAnchor(jValue);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	@override
	PropertyValue<double>? get sortKey =>
			jLayer.getLineSortKey().toDart(releaseOriginal: true);

	@override
	set sortKey(PropertyValue<double>? value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value == null) {
			jProperty = jni.PropertyFactory.lineSortKey(null);
		} else if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena)
				?..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineSortKey$1(jExpression);
		} else {
			final jValue = value.value.toJFloat()..releasedBy(arena);
			jProperty = jni.PropertyFactory.lineSortKey(jValue);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
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
				'Setting filter for LineStyleLayer to null is not supported.',
			);
		}
		final jFilter = expression.toJExpression(arena)?..releasedBy(arena);
		if (jFilter != null) jLayer.setFilter(jFilter);
	});

	@override
	String get sourceId =>
			jLayer.getSourceId().toDartString(releaseOriginal: true);

	@override
	String? get sourceLayerId =>
			jLayer.getSourceLayer().toDartString(releaseOriginal: true);

	@override
	set sourceLayerId(String? value) => using((arena) {
		final jValue = value?.toJString();
		jValue?.releasedBy(arena);
		jLayer.setSourceLayer(jValue);
	});
}

