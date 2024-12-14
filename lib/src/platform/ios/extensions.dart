import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';

import 'package:geotypes/geotypes.dart';
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
  /// Set a layout or paint property for a [MLNStyleLayer].
  void setProperty(String key, Object value) {
    final rawValue = switch (value) {
      List() || Map() => jsonEncode(value),
      _ => value.toString(),
    };
    final expression = parseNSExpression(key, rawValue);
    print(expression);
    if (expression != null) {
      Helpers.setExpressionWithTarget_field_expression_(
        this,
        key.dashedToCamelCase().toNSString(),
        expression,
      );
    }
  }

  /// Apply all paint or layout properties on the [MLNStyleLayer].
  void setProperties(Map<String, Object> properties) {
    for (final property in properties.entries) {
      print(property);
      switch (property.key) {
        case 'visibility':
          visible = property.value == 'none';
          continue;
        // TODO some properties cause currently a crash, skip them here
        /*case 'circle-radius':
        case 'circle-color':
        case 'circle-stroke-color':
        case 'circle-opacity':*/
        case 'fill-extrusion-color':
        case 'fill-extrusion-height':
        case 'fill-extrusion-base':
          continue;
        default:
          setProperty(property.key.dashedToCamelCase(), property.value);
      }
    }
  }
}

/// UTF8 Encoding
const nsUTF8StringEncoding = 4;
