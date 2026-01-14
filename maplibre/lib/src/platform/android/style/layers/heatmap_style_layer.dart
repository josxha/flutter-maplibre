part of 'style_layer.dart';

/// Android implementation of [HeatmapStyleLayer].
class HeatmapStyleLayerAndroid extends StyleLayerAndroid<jni.HeatmapLayer>
		implements HeatmapStyleLayer {
	PropertyValue<Offset> _translate = StyleLayerWithTranslate.defaultTranslate;
	PropertyValue<ReferenceSpace> _translateAnchor =
			StyleLayerWithTranslate.defaultTranslateAnchor;
	PropertyValue<double>? _sortKey;

	/// Factory for a [HeatmapStyleLayerAndroid] instance.
	factory HeatmapStyleLayerAndroid({
		required String id,
		required String sourceId,
		required String? sourceLayerId,
		required Expression? filter,
		required bool visible,
		required double minZoom,
		required double maxZoom,
		required PropertyValue<Offset> translate,
		required PropertyValue<ReferenceSpace> translateAnchor,
		required PropertyValue<double>? sortKey,
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
			)..releasedBy(arena),
		)
			..minZoom = minZoom
			..maxZoom = maxZoom
			..visible = visible
			..translate = translate
			..translateAnchor = translateAnchor
			..sortKey = sortKey
			..radius = radius
			..weight = weight
			..intensity = intensity
			..color = color
			..opacity = opacity
			..filter = filter;
		if (sourceLayerId != null) layer.sourceLayerId = sourceLayerId;
		return layer;
	});

	/// Construct a [HeatmapStyleLayerAndroid] from a JNI layer.
	HeatmapStyleLayerAndroid.fromNativeLayer(super.jLayer)
		: super.fromNativeLayer();

	@override
	PropertyValue<double> get radius =>
			jLayer.getHeatmapRadius().toDart(releaseOriginal: true) ??
			HeatmapStyleLayer.defaultRadius;

	@override
	set radius(PropertyValue<double> value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena)
				?..releasedBy(arena);
			jProperty = jni.PropertyFactory.heatmapRadius$1(jExpression);
		} else {
			final jValue = value.value.toJFloat()..releasedBy(arena);
			jProperty = jni.PropertyFactory.heatmapRadius(jValue);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	@override
	PropertyValue<double> get weight =>
			jLayer.getHeatmapWeight().toDart(releaseOriginal: true) ??
			HeatmapStyleLayer.defaultWeight;

	@override
	set weight(PropertyValue<double> value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena)
				?..releasedBy(arena);
			jProperty = jni.PropertyFactory.heatmapWeight$1(jExpression);
		} else {
			final jValue = value.value.toJFloat()..releasedBy(arena);
			jProperty = jni.PropertyFactory.heatmapWeight(jValue);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	@override
	PropertyValue<double> get intensity =>
			jLayer.getHeatmapIntensity().toDart(releaseOriginal: true) ??
			HeatmapStyleLayer.defaultIntensity;

	@override
	set intensity(PropertyValue<double> value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena)
				?..releasedBy(arena);
			jProperty = jni.PropertyFactory.heatmapIntensity$1(jExpression);
		} else {
			final jValue = value.value.toJFloat()..releasedBy(arena);
			jProperty = jni.PropertyFactory.heatmapIntensity(jValue);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	@override
	PropertyValue<Color>? get color => using((arena) {
		final jProperty = jLayer.getHeatmapColor()..releasedBy(arena);
		if (jProperty.isNull$1()) return null;
		if (jProperty.isExpression()) {
			final jExpression = jProperty.getExpression()?..releasedBy(arena);
			final expression = jExpression?.toDart(releaseOriginal: true);
			return expression == null ? null : PropertyValue.expression(expression);
		}
		final jValue = jProperty.getValue();
		if (jValue == null) return null;
		final value = jValue.toDartString(releaseOriginal: true);
		final color = Color(int.parse(value.replaceFirst('#', '0xff')));
		return PropertyValue.value(color);
	});

	@override
	set color(PropertyValue<Color>? value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value == null) {
			jProperty = jni.PropertyFactory.heatmapColor$1(null);
		} else if (value.isExpression) {
			jProperty = jni.PropertyFactory.heatmapColor$2(
				value.expression.toJExpression(arena),
			);
		} else {
			final jValue = value.value.toHexString().toJString()
				..releasedBy(arena);
			jProperty = jni.PropertyFactory.heatmapColor$1(jValue);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	@override
	PropertyValue<double> get opacity =>
			jLayer.getHeatmapOpacity().toDart(releaseOriginal: true) ??
			HeatmapStyleLayer.defaultOpacity;

	@override
	set opacity(PropertyValue<double> value) => using((arena) {
		final jni.PropertyValue? jProperty;
		if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena)
				?..releasedBy(arena);
			jProperty = jni.PropertyFactory.heatmapOpacity$1(jExpression);
		} else {
			final jValue = value.value.toJFloat()..releasedBy(arena);
			jProperty = jni.PropertyFactory.heatmapOpacity(jValue);
		}
		jProperty?.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	PropertyValue<Offset> get translate => _translate;

	set translate(PropertyValue<Offset> value) => using((arena) {
		_translate = value;
		final jName = 'heatmap-translate'.toJString()..releasedBy(arena);
		final jni.PropertyValue<JObject?> jProperty;
		if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena);
			jExpression?..releasedBy(arena);
			jProperty = jni.PropertyValue(
				jName,
				jExpression,
				T: JObject.nullableType,
			);
		} else {
			final jArray = value.value.toJFloatArray(arena);
			jProperty = jni.PropertyValue(
				jName,
				jArray,
				T: JObject.nullableType,
			);
		}
		jProperty.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	PropertyValue<ReferenceSpace> get translateAnchor => _translateAnchor;

	set translateAnchor(PropertyValue<ReferenceSpace> value) => using((arena) {
		_translateAnchor = value;
		final jName = 'heatmap-translate-anchor'.toJString()..releasedBy(arena);
		final jni.PropertyValue<JObject?> jProperty;
		if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena);
			jExpression?..releasedBy(arena);
			jProperty = jni.PropertyValue(
				jName,
				jExpression,
				T: JObject.nullableType,
			);
		} else {
			final jValue = value.value.name.toJString()..releasedBy(arena);
			jProperty = jni.PropertyValue(
				jName,
				jValue,
				T: JObject.nullableType,
			);
		}
		jProperty.releasedBy(arena);
		jLayer.setProperty(jProperty);
	});

	PropertyValue<double>? get sortKey => _sortKey;

	set sortKey(PropertyValue<double>? value) => using((arena) {
		_sortKey = value;
		final jName = 'heatmap-sort-key'.toJString()..releasedBy(arena);
		final jni.PropertyValue<JObject?> jProperty;
		if (value == null) {
			jProperty = jni.PropertyValue(jName, null, T: JObject.nullableType);
		} else if (value.isExpression) {
			final jExpression = value.expression.toJExpression(arena);
			jExpression?..releasedBy(arena);
			jProperty = jni.PropertyValue(
				jName,
				jExpression,
				T: JObject.nullableType,
			);
		} else {
			final jValue = value.value.toJFloat()..releasedBy(arena);
			jProperty = jni.PropertyValue(
				jName,
				jValue,
				T: JObject.nullableType,
			);
		}
		jProperty.releasedBy(arena);
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
				'Setting filter for HeatmapStyleLayer to null is not supported.',
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

