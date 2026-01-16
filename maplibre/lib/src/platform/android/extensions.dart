import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/android/jni.g.dart' as jni;
import 'package:maplibre/src/platform/pigeon.g.dart' as pigeon;

/// Extension methods for the [Geographic] class. Not exported publicly.
extension GeographicExt on Geographic {
  /// Convert a [Geographic] to an internal [pigeon.LngLat].
  pigeon.LngLat toLngLat() => pigeon.LngLat(lng: lon, lat: lat);

  /// Convert a [Geographic] to an [jni.LatLng].
  jni.LatLng toLatLng() => jni.LatLng.new$1(lat, lon);
}

/// Extension methods for the [pigeon.LngLat] class. Not exported publicly.
extension LngLatExt on pigeon.LngLat {
  /// Convert an internal [pigeon.LngLat] to a [Geographic].
  Geographic toGeographic() => Geographic(lon: lng, lat: lat);
}

/// Extension methods for the [pigeon.Offset] class. Not exported publicly.
extension PigeonOffsetExt on pigeon.Offset {
  /// Convert an internal [pigeon.Offset] to a [Offset].
  Offset toOffset() => Offset(x, y);
}

/// Extension methods for the [jni.LatLng] class. Not exported publicly.
extension JniLatLngExt on jni.LatLng {
  /// Convert an internal [jni.LatLng] to a [Geographic].
  Geographic toGeographic({bool releaseOriginal = false}) {
    final point = Geographic(lon: getLongitude(), lat: getLatitude());
    if (releaseOriginal) release();
    return point;
  }
}

/// Extension methods for the [jni.PointF] class. Not exported publicly.
extension PointExt on jni.PointF {
  /// Convert an [jni.PointF] to a [Offset].
  Offset toOffset({bool releaseOriginal = false}) {
    final offset = Offset(x, y);
    if (releaseOriginal) release();
    return offset;
  }
}

/// Extension methods for the [Offset] class. Not exported publicly.
extension OffsetExt on Offset {
  /// Convert an [Offset] to an internal [pigeon.Offset].
  pigeon.Offset toOffset() => pigeon.Offset(x: dx, y: dy);

  /// Convert an [Offset] to an [jni.PointF].
  jni.PointF toJPointF({required Arena arena}) =>
      jni.PointF.new$3(dx, dy)..releasedBy(arena);

  /// Convert an [Offset] to a [JArray<JFloat>].
  JArray<JFloat?> toJFloatArray(Arena arena) {
    final jArray = JArray(JFloat.nullableType, 2)..releasedBy(arena);
    jArray[0] = dx.toJFloat()..releasedBy(arena);
    jArray[1] = dy.toJFloat()..releasedBy(arena);
    return jArray;
  }
}

/// Extension methods for the [LngLatBounds] class. Not exported publicly.
extension LngLatBoundsExt on LngLatBounds {
  /// Convert an [LngLatBounds] to an internal [pigeon.LngLatBounds].
  pigeon.LngLatBounds toLngLatBounds() => pigeon.LngLatBounds(
    longitudeEast: longitudeEast,
    longitudeWest: longitudeWest,
    latitudeNorth: latitudeNorth,
    latitudeSouth: latitudeSouth,
  );

  /// Convert an [LngLatBounds] to an internal [jni.LatLngBounds].
  jni.LatLngBounds toJLatLngBounds({required Arena arena}) =>
      jni.LatLngBounds.from(
        latitudeNorth,
        longitudeEast,
        latitudeSouth,
        longitudeWest,
      )..releasedBy(arena);
}

/// Extension methods for the [jni.LatLngBounds] class. Not exported publicly.
extension LatLngBounds on jni.LatLngBounds {
  /// Convert an internal [jni.LatLngBounds] to an [LngLatBounds].
  LngLatBounds toLngLatBounds({bool releaseOriginal = false}) {
    final bounds = LngLatBounds(
      longitudeWest: longitudeWest,
      longitudeEast: longitudeEast,
      latitudeSouth: latitudeSouth,
      latitudeNorth: latitudeNorth,
    );
    if (releaseOriginal) release();
    return bounds;
  }
}

/// Extension methods for the [EdgeInsets] class. Not exported publicly.
extension EdgeInsetsExt on EdgeInsets {
  /// Convert an [EdgeInsets] to an internal [pigeon.Padding].
  pigeon.Padding toPadding() => pigeon.Padding(
    top: top.toInt(),
    bottom: bottom.toInt(),
    left: left.toInt(),
    right: right.toInt(),
  );
}

/// Extension methods for the [EdgeInsets] class. Not exported publicly.
extension OfflineRegionExt on jni.OfflineRegion {
  /// Convert an [EdgeInsets] to an internal [pigeon.Padding].
  OfflineRegion toOfflineRegion() => using((arena) {
    final jDefinition = getDefinition()..releasedBy(arena);
    // TODO add getMetadata();
    return OfflineRegion(
      id: getId(),
      bounds: jDefinition.getBounds()!.toLngLatBounds(releaseOriginal: true),
      minZoom: jDefinition.getMinZoom(),
      maxZoom: jDefinition.getMaxZoom(),
      pixelRatio: jDefinition.getPixelRatio(),
      styleUrl: jDefinition.getStyleURL()!.toDartString(releaseOriginal: true),
    );
  });
}

/// Extension methods on [Object].
extension ObjectExt on Object {
  /// Convert a [Object] to a [JObject].
  JObject toJObject(Arena arena) {
    switch (this) {
      case final Map<String, Object?> value:
        final jMap = jni.HashMap(
          K: JObject.nullableType,
          V: JObject.nullableType,
        )..releasedBy(arena);
        for (final entry in value.entries) {
          final jKey = entry.key.toJObject(arena)..releasedBy(arena);
          final jValue = entry.value?.toJObject(arena);
          jMap.put(jKey, jValue);
        }
        return jMap;
      case final List<Object?> value:
        return JArray.of(
          JObject.nullableType,
          value.map((e) => e?.toJObject(arena)).toList(growable: false),
        )..releasedBy(arena);
      case final String value:
        return value.toJString()..releasedBy(arena);
      case final double value:
        return value.toJDouble()..releasedBy(arena);
      // a dart int equals a java long
      case final int value:
        return value.toJLong()..releasedBy(arena);
      case final bool value:
        return value.toJBoolean()..releasedBy(arena);
      default:
        throw Exception('Unsupported property type: $runtimeType, $this');
    }
  }
}

/// Extension methods for the [jni.Layer] class. Not exported publicly.
extension JniLayerExt on jni.Layer {
  /// Set a single property on this layer.
  void setProperty(jni.PropertyValue? property) => using((arena) {
    final jProperties =
        JArray(jni.PropertyValue.nullableType(JObject.nullableType), 1)
          ..releasedBy(arena)
          ..[0] = property;
    setProperties(jProperties);
  });
}

/// Extension methods for the [Expression] class. Not exported publicly.
extension ExpressionExt on Expression {
  /// Set a single property on this layer.
  jni.Expression? toJExpression(Arena arena) {
    final expressionString = jsonEncode(json).toJString()..releasedBy(arena);
    return jni.Expression$Converter.convert$2(expressionString)
      ?..releasedBy(arena);
  }
}

/// Extension methods for the [jni.Expression] class. Not exported publicly.
extension JExpressionExt on jni.Expression {
  /// Convert a [jni.Expression] to an [Expression].
  Expression toDart({bool releaseOriginal = false}) => using((arena) {
    final expressionString = toString$2()!.toDartString(releaseOriginal: true);
    if (releaseOriginal) release();
    final json = jsonDecode(expressionString) as List<Object?>;
    final expression = Expression.fromJson(json);
    return expression;
  });
}

/// Extension methods for the [jni.PropertyValue] class. Not exported publicly.
extension JStringPropertyValueExt on jni.PropertyValue<JString?> {
  /// Convert a [jni.PropertyValue] to a [PropertyValue<String>].
  PropertyValue<String>? toDart({bool releaseOriginal = false}) =>
      using((arena) {
        if (isNull$1()) return null;
        if (isExpression()) {
          final jExpression = getExpression()?..releasedBy(arena);
          if (jExpression == null) return null;
          return PropertyValue.expression(jExpression.toDart());
        }
        final jValue = getValue();
        if (jValue == null) return null;
        final value = jValue.toDartString(releaseOriginal: true);
        if (releaseOriginal) release();
        return PropertyValue.value(value);
      });

  /// Convert a [jni.PropertyValue] to a [PropertyValue<Color>].
  PropertyValue<Color>? toDartColor({bool releaseOriginal = false}) =>
      using((arena) {
        if (isNull$1()) return null;
        if (isExpression()) {
          final jExpression = getExpression()?..releasedBy(arena);
          if (jExpression == null) return null;
          return PropertyValue.expression(jExpression.toDart());
        }
        final jValue = getColorInt();
        if (jValue == null) return null;
        final value = jValue.intValue(releaseOriginal: true);
        if (releaseOriginal) release();
        return PropertyValue.value(Color(value));
      });

  /// Convert a [jni.PropertyValue] to a [PropertyValue<Color>].
  PropertyValue<ReferenceSpace>? toDartReferenceSpace({
    bool releaseOriginal = false,
  }) => using((arena) {
    if (isNull$1()) return null;
    if (isExpression()) {
      final jExpression = getExpression()?..releasedBy(arena);
      if (jExpression == null) return null;
      return PropertyValue.expression(jExpression.toDart());
    }
    final jValue = getValue();
    if (jValue == null) return null;
    final value = jValue.toDartString(releaseOriginal: true);
    if (releaseOriginal) release();
    return PropertyValue.value(
      ReferenceSpace.values.firstWhere((e) => e.name == value),
    );
  });
}

/// Extension methods for the [jni.PropertyValue] class. Not exported publicly.
extension JDoublePropertyValueExt on jni.PropertyValue<JDouble?> {
  /// Convert a [jni.PropertyValue] to a [PropertyValue<double>].
  PropertyValue<double>? toDart({bool releaseOriginal = false}) =>
      using((arena) {
        if (isNull$1()) return null;
        if (isExpression()) {
          final jExpression = getExpression()?..releasedBy(arena);
          if (jExpression == null) return null;
          return PropertyValue.expression(jExpression.toDart());
        }
        final jValue = getValue();
        if (jValue == null) return null;
        final value = jValue.doubleValue(releaseOriginal: true);
        if (releaseOriginal) release();
        return PropertyValue.value(value);
      });
}

/// Extension methods for the [jni.PropertyValue] class. Not exported publicly.
extension JFloatPropertyValueExt on jni.PropertyValue<JFloat?> {
  /// Convert a [jni.PropertyValue] to a [PropertyValue<double>].
  PropertyValue<double>? toDart({bool releaseOriginal = false}) =>
      using((arena) {
        if (isNull$1()) return null;
        if (isExpression()) {
          final jExpression = getExpression()?..releasedBy(arena);
          if (jExpression == null) return null;
          return PropertyValue.expression(jExpression.toDart());
        }
        final jValue = getValue();
        if (jValue == null) return null;
        final value = jValue.doubleValue(releaseOriginal: true);
        if (releaseOriginal) release();
        return PropertyValue.value(value);
      });
}

/// Extension methods for the [jni.PropertyValue] class. Not exported publicly.
extension JBooleanPropertyValueExt on jni.PropertyValue<JBoolean?> {
  /// Convert a [jni.PropertyValue] to a [PropertyValue<double>].
  PropertyValue<bool>? toDart({bool releaseOriginal = false}) => using((arena) {
    if (isNull$1()) return null;
    if (isExpression()) {
      final jExpression = getExpression()?..releasedBy(arena);
      if (jExpression == null) return null;
      return PropertyValue.expression(jExpression.toDart());
    }
    final jValue = getValue();
    if (jValue == null) return null;
    final value = jValue.booleanValue(releaseOriginal: true);
    if (releaseOriginal) release();
    return PropertyValue.value(value);
  });
}

/// Extension methods for the [jni.PropertyValue] class. Not exported publicly.
extension JFloatArrayPropertyValueExt on jni.PropertyValue<JArray<JFloat?>?> {
  /// Convert a [jni.PropertyValue] to a [PropertyValue<Offset>].
  PropertyValue<Offset>? toDartOffset({bool releaseOriginal = false}) =>
      using((arena) {
        if (isNull$1()) return null;
        if (isExpression()) {
          final jExpression = getExpression()!..releasedBy(arena);
          final expression = jExpression.toDart(releaseOriginal: true);
          return PropertyValue.expression(expression);
        }
        final jValue = getValue()!..releasedBy(arena);
        final x = jValue[0]!.floatValue(releaseOriginal: true);
        final y = jValue[1]!.floatValue(releaseOriginal: true);
        if (releaseOriginal) release();
        return PropertyValue.value(Offset(x, y));
      });
}
