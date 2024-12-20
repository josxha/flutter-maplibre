import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_ios/maplibre_ffi.dart';
import 'package:objective_c/objective_c.dart';

/// Internal extensions on [CLLocationCoordinate2D].
extension CLLocationCoordinate2DExt on CLLocationCoordinate2D {
  /// Convert a [CLLocationCoordinate2D] to [Position].
  Position toPosition() => Position(longitude, latitude);
}

/// Internal extensions on [Position].
extension PositionExt on Position {
  /// Convert a [Position] to a [CLLocationCoordinate2D].
  CLLocationCoordinate2D toCLLocationCoordinate2D() {
    final coords = Struct.create<CLLocationCoordinate2D>();
    coords.latitude = lat.toDouble();
    coords.longitude = lng.toDouble();
    return coords;
  }
}

/// Internal extensions on [Offset].
extension OffsetExt on Offset {
  /// Convert a [Position] to a [CGPoint].
  CGPoint toCGPoint() {
    final point = Struct.create<CGPoint>();
    point.x = dx;
    point.y = dy;
    return point;
  }
}

/// Internal extensions on [CGPoint].
extension CGPointExt on CGPoint {
  /// Convert a [CGPoint] to a [Offset].
  Offset toOffset() => Offset(x, y);
}

/// Internal extensions on [String].
extension StringExt on String {
  /// Convert to a [NSURL].
  NSURL? toNSURL() => NSURL.URLWithString_(toNSString());

  /// Convert to a [NSURL].
  NSData? toNSDataUTF8() => toNSString().dataUsingEncoding_(
        nsUTF8StringEncoding,
      );

  /// Convert a dashed separated name to camel case.
  String dashedToCamelCase() => split('-').indexed.map((entry) {
        final index = entry.$1;
        final word = entry.$2;
        // Keep the first word in lowercase
        if (index == 0) return word;
        return word[0].toUpperCase() + word.substring(1);
      }).join();
}

/// Convert a raw String to a [NSExpression].
NSExpression? parseNSExpression(String propertyName, String json) =>
    Helpers.parseExpressionWithPropertyName_expression_(
      propertyName.toNSString(),
      json.toNSString(),
    );

/// Internal extensions on [MLNStyleLayer].
extension MLNStyleLayerExt on MLNStyleLayer {
  /// Apply all paint or layout properties on the [MLNStyleLayer].
  void setProperties(Map<String, Object> properties) {
    for (final property in properties.entries) {
      print('${property.key}   ${jsonEncode(property.value)}');
      switch (property.key) {
        case 'visibility':
          visible = property.value == 'none';
        default:
          setProperty(property.key, property.value);
      }
    }
  }

  /// Set a layout or paint property for a [MLNStyleLayer].
  void setProperty(String key, Object value) {
    final keyCamelCase = key.dashedToCamelCase();
    try {
      // convert to a String
      var rawValue = switch (value) {
        List() || Map() => jsonEncode(value),
        String() => value,
        _ => value.toString(),
      };
      // convert html color names to hex strings
      if (key.contains('color')) {
        rawValue = htmlColorNames[rawValue] ?? rawValue;
      }
      final expression = parseNSExpression(keyCamelCase, rawValue);
      print('${expression?.description1 ?? 'no expression!'}');
      if (expression != null) {
        Helpers.setExpressionWithTarget_field_expression_(
          this,
          keyCamelCase.toNSString(),
          expression,
        );
      }
    } catch (error, stacktrace) {
      debugPrint(error.toString());
      debugPrintStack(stackTrace: stacktrace);
    }
  }
}

/// UTF8 Encoding
const nsUTF8StringEncoding = 4;
