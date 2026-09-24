import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:jni/jni.dart' as jni;
import 'package:jni/jni.dart';
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
    final point = Geographic(lon: longitude, lat: latitude);
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
    final jX = this[0];
    final x = jX?.floatValue() ?? 0;
    jX?.release();
    final jY = this[1];
    final y = jY?.floatValue() ?? 0;
    jY?.release();
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
    final jArray = JArray.withLength(JFloat.type, 2)..releasedBy(arena);
    jArray[0] = dx.toJFloat()..releasedBy(arena);
    jArray[1] = dy.toJFloat()..releasedBy(arena);
    return jArray;
  }
}

/// Extension methods for the [EdgeInsets] class. Not exported publicly.
extension EdgeInsetsExt on EdgeInsets {
  /// Convert an [EdgeInsets] to a [JArray<JFloat>].
  JArray<JFloat?> toJFloatArray(Arena arena) {
    final jArray = JArray.withLength(JFloat.type, 4)..releasedBy(arena);
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
    final jArray = JArray.withLength(JFloat.type, length)..releasedBy(arena);
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
    final jArray = JArray.withLength(JString.type, length)..releasedBy(arena);
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
    final jDefinition = definition..releasedBy(arena);
    final jMetadata = metadata..releasedBy(arena);
    final metadataBytes = jMetadata.asDart();
    final metadataJson = utf8.decode(metadataBytes);
    final dartMetadata = jsonDecode(metadataJson) as Map<String, Object?>;

    return OfflineRegion(
      id: id,
      bounds: jDefinition.getBounds()!.toLngLatBounds(releaseOriginal: true),
      minZoom: jDefinition.getMinZoom(),
      maxZoom: jDefinition.getMaxZoom(),
      pixelRatio: jDefinition.getPixelRatio(),
      styleUrl: jDefinition.getStyleURL()!.toDartString(releaseOriginal: true),
      metadata: dartMetadata,
    );
  });
}

/// Extension methods for the [jni.Layer] class. Not exported publicly.
extension JniLayerExt on jni.Layer {
  /// Set a single property on this layer.
  void setProperty(jni.PropertyValue? property) => using((arena) {
    final jProperties = JArray.withLength(jni.PropertyValue.type, 1)
      ..releasedBy(arena)
      ..[0] = property;
    properties = jProperties;
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
        if (isNull$1) return null;
        if (isExpression) {
          final jExpression = expression?..releasedBy(arena);
          if (jExpression == null) return null;
          return PropertyValue.expression(jExpression.toDart());
        }
        final jValue = this.value;
        if (jValue == null) return null;
        final value = jValue.toDartString(releaseOriginal: true);
        if (releaseOriginal) release();
        return PropertyValue.value(value);
      });

  /// Convert a [jni.PropertyValue] to a [PropertyValue<Color>].
  PropertyValue<Color>? toDartColor({bool releaseOriginal = false}) =>
      using((arena) {
        if (isNull$1) return null;
        if (isExpression) {
          final jExpression = expression?..releasedBy(arena);
          if (jExpression == null) return null;
          return PropertyValue.expression(jExpression.toDart());
        }
        final jValue = colorInt;
        if (jValue == null) return null;
        final value = jValue.intValue();
        jValue.release();
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
        if (isNull$1) return null;
        if (isExpression) {
          final jExpression = expression?..releasedBy(arena);
          if (jExpression == null) return null;
          return PropertyValue.expression(jExpression.toDart());
        }
        final jValue = this.value;
        if (jValue == null) return null;
        final value = jValue.doubleValue();
        jValue.release();
        if (releaseOriginal) release();
        return PropertyValue.value(value);
      });
}

/// Extension methods for the [jni.PropertyValue] class. Not exported publicly.
extension JFloatPropertyValueExt on jni.PropertyValue<JFloat?> {
  /// Convert a [jni.PropertyValue] to a [PropertyValue<double>].
  PropertyValue<double>? toDart({bool releaseOriginal = false}) =>
      using((arena) {
        if (isNull$1) return null;
        if (isExpression) {
          final jExpression = expression?..releasedBy(arena);
          if (jExpression == null) return null;
          return PropertyValue.expression(jExpression.toDart());
        }
        final jValue = this.value;
        if (jValue == null) return null;
        final value = jValue.doubleValue();
        jValue.release();
        if (releaseOriginal) release();
        return PropertyValue.value(value);
      });
}

/// Extension methods for the [jni.PropertyValue] class. Not exported publicly.
extension JBooleanPropertyValueExt on jni.PropertyValue<JBoolean?> {
  /// Convert a [jni.PropertyValue] to a [PropertyValue<double>].
  PropertyValue<bool>? toDart({bool releaseOriginal = false}) => using((arena) {
    if (isNull$1) return null;
    if (isExpression) {
      final jExpression = expression?..releasedBy(arena);
      if (jExpression == null) return null;
      return PropertyValue.expression(jExpression.toDart());
    }
    final jValue = this.value;
    if (jValue == null) return null;
    final value = jValue.booleanValue();
    jValue.release();
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
    if (isNull$1) return null;
    if (isExpression) {
      final jExpression = this.expression!..releasedBy(arena);
      final expression = jExpression.toDart(releaseOriginal: true);
      return PropertyValue.expression(expression);
    }
    final jValue = value!..releasedBy(arena);
    final list = jValue
        .asDart()
        .nonNulls
        .map((e) => e.toDartString(releaseOriginal: true))
        .toList(growable: true);
    if (releaseOriginal) release();
    return PropertyValue.value(list);
  });

  /// Convert a [jni.PropertyValue] to a [PropertyValue<List<Color>>].
  PropertyValue<List<Color>>? toDartColorList({bool releaseOriginal = false}) =>
      using((arena) {
        if (isNull$1) return null;
        if (isExpression) {
          final jExpression = this.expression!..releasedBy(arena);
          final expression = jExpression.toDart(releaseOriginal: true);
          return PropertyValue.expression(expression);
        }
        final jValue = value!..releasedBy(arena);
        final list = jValue
            .asDart()
            .nonNulls
            .map((e) {
              final string = e.toDartString(releaseOriginal: true);
              final intValue = int.parse(string, radix: 16);
              return Color(intValue);
            })
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
        if (isNull$1) return null;
        if (isExpression) {
          final jExpression = this.expression!..releasedBy(arena);
          final expression = jExpression.toDart(releaseOriginal: true);
          return PropertyValue.expression(expression);
        }
        final jValue = value!..releasedBy(arena);
        final jX = jValue[0]?..releasedBy(arena);
        final jY = jValue[1]?..releasedBy(arena);
        final x = jX?.floatValue() ?? 0;
        final y = jY?.floatValue() ?? 0;
        if (releaseOriginal) release();
        return PropertyValue.value(Offset(x, y));
      });

  /// Convert a [jni.PropertyValue] to a [PropertyValue<Offset>].
  PropertyValue<EdgeInsets>? toDartEdgeInsets({bool releaseOriginal = false}) =>
      using((arena) {
        if (isNull$1) return null;
        if (isExpression) {
          final jExpression = this.expression!..releasedBy(arena);
          final expression = jExpression.toDart(releaseOriginal: true);
          return PropertyValue.expression(expression);
        }
        final jValue = value!..releasedBy(arena);
        final jTop = jValue[0]?..releasedBy(arena);
        final jRight = jValue[1]?..releasedBy(arena);
        final jBottom = jValue[2]?..releasedBy(arena);
        final jLeft = jValue[3]?..releasedBy(arena);
        final padding = EdgeInsets.only(
          top: jTop?.floatValue() ?? 0,
          right: jRight?.floatValue() ?? 0,
          bottom: jBottom?.floatValue() ?? 0,
          left: jLeft?.floatValue() ?? 0,
        );
        if (releaseOriginal) release();
        return PropertyValue.value(padding);
      });

  /// Convert a [jni.PropertyValue] to a [PropertyValue<Offset>].
  PropertyValue<List<double>>? toDartDoubleList({
    bool releaseOriginal = false,
  }) => using((arena) {
    if (isNull$1) return null;
    if (isExpression) {
      final jExpression = this.expression!..releasedBy(arena);
      final expression = jExpression.toDart(releaseOriginal: true);
      return PropertyValue.expression(expression);
    }
    final jValue = value!..releasedBy(arena);
    final list = jValue
        .asDart()
        .nonNulls
        .map((e) {
          final doubleValue = e.floatValue();
          e.release();
          return doubleValue;
        })
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
    if (isExpression) {
      final jExpression = this.expression?..releasedBy(arena);
      final expression = jExpression?.toDart(releaseOriginal: true);
      if (expression == null) return null;
      return PropertyValue.expression(expression);
    }
    final jValue = this.value;
    if (jValue == null) return null;
    final value = jValue.toDartString(releaseOriginal: true);
    final match = values.firstWhere((e) => e.name == value);
    if (releaseOriginal) release();
    return PropertyValue.value(match);
  });
}
