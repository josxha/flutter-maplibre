import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:jni/jni.dart';
import 'package:jni/jni.dart' as jni;
import 'package:maplibre_android/src/jni.g.dart' as jni;
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Extension methods for the [Geographic] class. Not exported publicly.
extension GeographicExt on Geographic {
  /// Convert a [Geographic] to an [jni.LatLng].
  jni.LatLng toLatLng() => jni.LatLng.new$1(lat, lon);
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

/// Extension methods for the [jni.PointF] class. Not exported publicly.
extension JFloatArrayExt on jni.JArray<jni.JFloat?> {
  /// Convert an [jni.JArray] to a [Offset].
  Offset toOffset({bool releaseOriginal = false}) {
    final x = this[0]?.floatValue(releaseOriginal: true) ?? 0;
    final y = this[1]?.floatValue(releaseOriginal: true) ?? 0;
    final offset = Offset(x, y);
    if (releaseOriginal) release();
    return offset;
  }
}

/// Extension methods for the [Offset] class. Not exported publicly.
extension OffsetExt on Offset {
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

/// Extension methods for the [EdgeInsets] class. Not exported publicly.
extension EdgeInsetsExt on EdgeInsets {
  /// Convert an [EdgeInsets] to a [JArray<JFloat>].
  JArray<JFloat?> toJFloatArray(Arena arena) {
    final jArray = JArray(JFloat.nullableType, 4)..releasedBy(arena);
    jArray[0] = top.toJFloat()..releasedBy(arena);
    jArray[1] = right.toJFloat()..releasedBy(arena);
    jArray[2] = bottom.toJFloat()..releasedBy(arena);
    jArray[3] = left.toJFloat()..releasedBy(arena);
    return jArray;
  }
}

/// Extension methods for the [LngLatBounds] class. Not exported publicly.
extension LngLatBoundsExt on LngLatBounds {
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

/// Extension methods for the [List<double>] class. Not exported publicly.
extension DoubleListExt on List<double> {
  /// Convert a [List<double>] to a [JArray<JDouble>].
  JArray<JFloat?> toJFloatArray(Arena arena) {
    final jArray = JArray(JFloat.nullableType, length)..releasedBy(arena);
    for (var i = 0; i < length; i++) {
      jArray[i] = this[i].toJFloat()..releasedBy(arena);
    }
    return jArray;
  }
}

/// Extension methods for the [List<String>] class. Not exported publicly.
extension StringListExt on List<String> {
  /// Convert a [List<String>] to a [JArray<JString>].
  JArray<JString?> toJStringArray(Arena arena) {
    final jArray = JArray(JString.nullableType, length)..releasedBy(arena);
    for (var i = 0; i < length; i++) {
      jArray[i] = this[i].toJString()..releasedBy(arena);
    }
    return jArray;
  }
}

/// Extension methods for the [jni.OfflineRegion] class. Not exported publicly.
extension OfflineRegionExt on jni.OfflineRegion {
  /// Convert an [jni.OfflineRegion] to an [OfflineRegion].
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
    final expressionString = jsonEncode(this.json).toJString()
      ..releasedBy(arena);
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
  }) => toDartEnum(
    values: ReferenceSpace.values,
    releaseOriginal: releaseOriginal,
  );
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
extension JStringArrayPropertyValueExt on jni.PropertyValue<JArray<JString?>?> {
  /// Convert a [jni.PropertyValue] to a [PropertyValue<List<String>>].
  PropertyValue<List<String>>? toDartStringList({
    bool releaseOriginal = false,
  }) => using((arena) {
    if (isNull$1()) return null;
    if (isExpression()) {
      final jExpression = getExpression()!..releasedBy(arena);
      final expression = jExpression.toDart(releaseOriginal: true);
      return PropertyValue.expression(expression);
    }
    final jValue = getValue()!..releasedBy(arena);
    final list = jValue.nonNulls
        .map((e) => e.toDartString(releaseOriginal: true))
        .toList(growable: true);
    if (releaseOriginal) release();
    return PropertyValue.value(list);
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

  /// Convert a [jni.PropertyValue] to a [PropertyValue<Offset>].
  PropertyValue<EdgeInsets>? toDartEdgeInsets({bool releaseOriginal = false}) =>
      using((arena) {
        if (isNull$1()) return null;
        if (isExpression()) {
          final jExpression = getExpression()!..releasedBy(arena);
          final expression = jExpression.toDart(releaseOriginal: true);
          return PropertyValue.expression(expression);
        }
        final jValue = getValue()!..releasedBy(arena);
        final padding = EdgeInsets.only(
          top: jValue[0]?.floatValue(releaseOriginal: true) ?? 0,
          right: jValue[1]?.floatValue(releaseOriginal: true) ?? 0,
          bottom: jValue[2]?.floatValue(releaseOriginal: true) ?? 0,
          left: jValue[3]?.floatValue(releaseOriginal: true) ?? 0,
        );
        if (releaseOriginal) release();
        return PropertyValue.value(padding);
      });

  /// Convert a [jni.PropertyValue] to a [PropertyValue<Offset>].
  PropertyValue<List<double>>? toDartDoubleList({
    bool releaseOriginal = false,
  }) => using((arena) {
    if (isNull$1()) return null;
    if (isExpression()) {
      final jExpression = getExpression()!..releasedBy(arena);
      final expression = jExpression.toDart(releaseOriginal: true);
      return PropertyValue.expression(expression);
    }
    final jValue = getValue()!..releasedBy(arena);
    final list = jValue.nonNulls
        .map((e) => e.doubleValue(releaseOriginal: true))
        .toList(growable: true);
    if (releaseOriginal) release();
    return PropertyValue.value(list);
  });
}

/// Extension methods for the [PropertyValue] class. Not exported publicly.
extension PropertyValueExt<V> on PropertyValue<V>? {
  /// Applies the [PropertyValue] to a style layer property.
  jni.PropertyValue? apply({
    required Arena arena,
    required jni.PropertyValue? Function(jni.Expression? expression)
    onExpression,
    required jni.PropertyValue? Function(V value) onValue,
    jni.PropertyValue? Function()? onNull,
  }) {
    final property = this;
    if (property == null) {
      return onNull?.call();
    } else if (property.isExpression) {
      return onExpression(property.expression.toJExpression(arena));
    } else {
      return onValue(property.value);
    }
  }
}

/// Extension methods for the [jni.PropertyValue] class. Not exported publicly.
extension JPropertyValueStringExt on jni.PropertyValue<JString?> {
  /// Convert a [jni.PropertyValue] to a [PropertyValue<T>] where T is an enum.
  PropertyValue<T>? toDartEnum<T extends Enum>({
    required List<T> values,
    bool releaseOriginal = false,
  }) => using((arena) {
    if (isExpression()) {
      final jExpression = getExpression()?..releasedBy(arena);
      final expression = jExpression?.toDart(releaseOriginal: true);
      if (expression == null) return null;
      return PropertyValue.expression(expression);
    }
    final jValue = getValue();
    if (jValue == null) return null;
    final value = jValue.toDartString(releaseOriginal: true);
    final match = values.firstWhere((e) => e.name == value);
    if (releaseOriginal) release();
    return PropertyValue.value(match);
  });
}
