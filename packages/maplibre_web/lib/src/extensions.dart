import 'dart:js_interop';

import 'package:flutter/widgets.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_web/src/interop/interop.dart' as interop;

/// Extension methods for the [Geographic] class. Not exported publicly.
extension PositionExt on Geographic {
  /// Convert a [Geographic] to an internal [interop.LngLat].
  interop.LngLat toLngLat() => interop.LngLat.fromGeographic(this);
}

/// Extension methods for the [Geographic] class. Not exported publicly.
extension LngLatBoundsExt on LngLatBounds {
  /// Convert a [Geographic] to an internal [interop.LngLat].
  interop.LngLatBounds toJsLngLatBounds() => interop.LngLatBounds(
    interop.LngLat(lng: longitudeWest, lat: latitudeSouth),
    interop.LngLat(lng: longitudeEast, lat: latitudeNorth),
  );
}

/// Extension methods for the [Offset] class. Not exported publicly.
extension OffsetExt on Offset {
  /// Convert a [Offset] to an internal [interop.Point].
  interop.Point toJsPoint() => interop.Point(dx, dy);
}

/// Extension methods for the [interop.Point] class. Not exported publicly.
extension JsPointExt on interop.Point {
  /// Convert a [interop.Point] to an internal [Offset].
  Offset toOffset() => Offset(x.toDouble(), y.toDouble());
}

/// Extension methods for the [EdgeInsets] class. Not exported publicly.
extension EdgeInsetsExt on EdgeInsets {
  /// Convert a [EdgeInsets] to an internal [interop.PaddingOptions].
  ///
  /// Web does not require pixel ratio conversion.
  interop.PaddingOptions toPaddingOptions() => interop.PaddingOptions(
    right: right,
    left: left,
    bottom: bottom,
    top: top,
  );
}

/// Internal extension to convert JSAny to Map\<String, dynamic\>
extension StringMap on JSAny? {
  /// Like [dartify], but for the special case of a JSON map.
  Map<String, Object?>? asStringMap() =>
      (dartify() as Map<Object?, Object?>?)?.map(
        (k, v) => MapEntry(k.toString(), v),
      ) ??
      {};

  /// Convert a [JSAny] to a [PropertyValue] of type [V] that can be [double],
  /// [String], [bool], [int], or [List<double>].
  PropertyValue<V>? toPropertyValue<V extends Object?>() {
    final property = dartify();
    if (property == null) {
      return null;
    } else if (property is List<Object?> && property.firstOrNull is String) {
      return PropertyValue.expression(Expression.fromJson(property));
    } else {
      final Object? v;
      if (V == double && property is num) {
        // JS numbers may dartify to int for whole values. If the caller expects
        // a double, convert any num to double.
        v = property.toDouble();
      } else if ((V == List<double>) && property is List) {
        // Similarly, JS arrays of numbers may dartify to List<num>/List<int>.
        // When the caller expects a List<double>, convert each element.
        v = property
            .map((e) => (e as num).toDouble())
            .cast<double>()
            .toList(growable: false);
      } else {
        v = property;
      }
      return PropertyValue.value(v as V);
      return PropertyValue.value(property as V);
    }
  }

  /// Convert a [JSAny] to a [PropertyValue] of type [Offset].
  PropertyValue<Offset>? toOffsetPropertyValue() {
    final property = dartify();
    if (property == null) {
      return null;
    } else if (property is List<Object?> && property.firstOrNull is String) {
      return PropertyValue.expression(Expression.fromJson(property));
    } else if (property is Map<Object?, Object?>) {
      final map = property.map((k, v) => MapEntry(k.toString(), v));
      if (map.containsKey('x') && map.containsKey('y')) {
        return PropertyValue.value(
          Offset((map['x']! as num).toDouble(), (map['y']! as num).toDouble()),
        );
      } else {
        throw StateError(
          'Expected a map with keys "x" and "y" for an offset property, but got $property',
        );
      }
    }
    throw StateError(
      'Expected a String, List, or Map for an offset property, but got ${property.runtimeType}',
    );
  }

  /// Convert a [JSAny] to a [PropertyValue] of type [Color].
  PropertyValue<Color>? toColorPropertyValue() {
    final property = dartify();
    if (property == null) {
      return null;
    } else if (property is List<Object?> && property.firstOrNull is String) {
      return PropertyValue.expression(Expression.fromJson(property));
    } else if (property is String) {
      if (property.startsWith('#')) {
        // hex color string
        return PropertyValue.value(
          Color(int.parse(property.replaceFirst('#', '0xff'))),
        );
      } else {
        // rgba color string
        final regex = RegExp(
          r'rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d*\.?\d+))?\)',
        );
        final match = regex.firstMatch(property);
        if (match != null) {
          final r = int.parse(match.group(1)!);
          final g = int.parse(match.group(2)!);
          final b = int.parse(match.group(3)!);
          final a = match.group(4) != null
              ? (double.parse(match.group(4)!) * 255).round()
              : 255;
          return PropertyValue.value(Color.fromARGB(a, r, g, b));
        } else {
          throw StateError('Invalid color string: $property');
        }
      }
    }
    throw StateError(
      'Expected a String or List for a color property, but got ${property.runtimeType}',
    );
  }

  /// Generic helper to convert a JS value to a [PropertyValue] of an enum type.
  ///
  /// Supports:
  /// - `null` -> `null`
  /// - expression JSON array -> `PropertyValue.expression(...)`
  /// - string/other -> matched against `enumValues[i].name`
  PropertyValue<E>? toEnumPropertyValue<E extends Enum>(List<E> enumValues) {
    final property = dartify();
    if (property == null) return null;
    if (property is List<Object?> && property.firstOrNull is String) {
      return PropertyValue.expression(Expression.fromJson(property));
    }

    final asString = property.toString();
    return PropertyValue.value(
      enumValues.firstWhere(
        (e) => e.name == asString,
        orElse: () => throw StateError('Invalid enum value: $property'),
      ),
    );
  }

  /// Convert a [JSAny] to a [PropertyValue] of type [NumberArray].
  PropertyValue<NumberArray>? toNumberArrayPropertyValue() {
    final property = dartify();
    if (property == null) return null;
    if (property is List<Object?> && property.firstOrNull is String) {
      return PropertyValue.expression(Expression.fromJson(property));
    }
    if (property is num) {
      return PropertyValue.value(NumberArray.number(property.toDouble()));
    }
    if (property is List) {
      final nums = property
          .whereType<num>()
          .map((e) => e.toDouble())
          .toList(growable: false);
      return PropertyValue.value(NumberArray.array(nums));
    }
    throw StateError(
      'Expected num, List<num>, or expression for NumberArray, got ${property.runtimeType}',
    );
  }

  /// Convert a [JSAny] to a [PropertyValue] of type [EdgeInsets].
  PropertyValue<EdgeInsets>? toEdgeInsetsPropertyValue() {
    final property = dartify();
    if (property == null) return null;
    if (property is List<Object?> && property.firstOrNull is String) {
      return PropertyValue.expression(Expression.fromJson(property));
    }
    if (property is List) {
      final nums = property.whereType<num>().map((e) => e.toDouble()).toList();
      if (nums.length != 4) {
        throw StateError(
          'Expected 4 numbers for EdgeInsets [top,right,bottom,left], got $property',
        );
      }
      return PropertyValue.value(
        EdgeInsets.fromLTRB(nums[3], nums[0], nums[1], nums[2]),
      );
    }
    throw StateError(
      'Expected List<num> or expression for EdgeInsets, got ${property.runtimeType}',
    );
  }

  /// Convert a [JSAny] to a [PropertyValue] of `List<E extends Enum>`.
  PropertyValue<List<E>>? toEnumListPropertyValue<E extends Enum>(
    List<E> enumValues,
  ) {
    final property = dartify();
    if (property == null) return null;
    if (property is List<Object?> && property.firstOrNull is String) {
      return PropertyValue.expression(Expression.fromJson(property));
    }
    if (property is List) {
      final result = property
          .map(
            (e) => enumValues.firstWhere(
              (v) => v.name == e.toString(),
              orElse: () => throw StateError('Invalid enum value: $e'),
            ),
          )
          .toList(growable: false);
      return PropertyValue.value(result);
    }
    throw StateError(
      'Expected List<String> or expression for enum list, got ${property.runtimeType}',
    );
  }

  /// Convert a [JSAny] to a [PropertyValue] of `Map<String, Offset>`.
  ///
  /// This is used for "text-variable-anchor-offset".
  PropertyValue<Map<String, Offset>>? toStringOffsetMapPropertyValue() {
    final property = dartify();
    if (property == null) return null;
    if (property is List<Object?> && property.firstOrNull is String) {
      return PropertyValue.expression(Expression.fromJson(property));
    }
    if (property is! List) {
      throw StateError(
        'Expected List for OneOf2<String,Offset> list, got ${property.runtimeType}',
      );
    }
    final values = <String, Offset>{};
    for (var i = 0; i < property.length; i += 2) {
      final key = property[i] as String;
      final item = property[i + 1] as List;
      final nums = item.whereType<num>().toList();
      final value = Offset(nums[0].toDouble(), nums[1].toDouble());
      values[key] = value;
    }
    return PropertyValue.value(values);
  }
}
