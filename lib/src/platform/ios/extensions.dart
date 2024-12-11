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
}

/// Internal extensions on [Object].
extension ObjectExt on Object {
  /// Convert to a [NSExpression].
  NSExpression toNSExpression() => NSExpression.expressionWithFormat_(
    jsonEncode(this).toNSString(),
  );
}

/// UTF8 Encoding
const nsUTF8StringEncoding = 4;