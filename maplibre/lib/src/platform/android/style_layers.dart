import 'dart:ui';

import 'package:jni/jni.dart';
import 'package:maplibre/src/platform/android/jni.g.dart' as jni;

///
extension type CircleStyleLayer._(jni.CircleLayer l) {
  ///
  CircleStyleLayer({required String id, required String sourceId})
    : l = jni.CircleLayer(id.toJString(), sourceId.toJString());

  ///
  Object? get color {
    final jColor = l.getCircleColor();
    if (jColor.isNull$1()) return null;
    if (jColor.isExpression()) {
      return jColor
    }
  }
}
