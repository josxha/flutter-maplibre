import 'dart:ui';

import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/android/extensions.dart';
import 'package:maplibre/src/platform/android/jni.g.dart' as jni;
import 'package:maplibre/src/platform/android/style/style.dart';

/// A layer that contains circles for Android platform.
class BackgroundStyleLayerAndroid extends StyleLayerAndroid<jni.BackgroundLayer>
    implements BackgroundStyleLayer {
  /// Default constructor for a [BackgroundStyleLayerAndroid] instance.
  BackgroundStyleLayerAndroid({
    required String id,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<Color> color,
    required PropertyValue<String>? pattern,
    required PropertyValue<double> opacity,
    required bool visible,
  }) : super.fromNativeLayer(jni.BackgroundLayer(id.toJString())) {
    this.minZoom = minZoom;
    this.maxZoom = maxZoom;
    this.color = color;
    this.opacity = opacity;
    this.visible = visible;
    this.pattern = pattern;
  }

  @override
  String get id => jLayer.getId().toDartString(releaseOriginal: true);

  @override
  double get maxZoom => jLayer.getMaxZoom();

  @override
  set maxZoom(double value) => jLayer.setMaxZoom(value);

  @override
  double get minZoom => jLayer.getMinZoom();

  @override
  set minZoom(double value) => jLayer.setMinZoom(value);

  @override
  PropertyValue<double> get opacity => using((arena) {
    final jProperty = jLayer.getBackgroundOpacity()..releasedBy(arena);
    if (jProperty.isExpression()) {
      final expression = jProperty.getExpression()!.toDartExpression(
        releaseOriginal: true,
      );
      return PropertyValue.expression(expression);
    }
    final value = jProperty.getValue()!.floatValue(releaseOriginal: true);
    return PropertyValue.value(value);
  });

  @override
  set opacity(PropertyValue<double> property) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (property.isExpression) {
      jProperty = jni.PropertyFactory.backgroundOpacity$1(
        property.expression.toJExpression(arena),
      );
    } else {
      final jValue = property.value.toJFloat()..releasedBy(arena);
      jProperty = jni.PropertyFactory.backgroundOpacity(jValue);
    }
    jLayer.as(jni.Layer.type).setProperty(jProperty);
  });

  @override
  PropertyValue<String>? get pattern => using((arena) {
    final jProperty = jLayer.getBackgroundPattern()..releasedBy(arena);
    if (jProperty.isNull$1()) {
      return null;
    }
    if (jProperty.isExpression()) {
      final expression = jProperty.getExpression()!.toDartExpression(
        releaseOriginal: true,
      );
      return PropertyValue.expression(expression);
    }
    final value = jProperty.getValue()?.toDartString(releaseOriginal: true);
    return PropertyValue.value(value!);
  });

  @override
  set pattern(PropertyValue<String>? property) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (property == null) {
      jProperty = jni.PropertyFactory.backgroundPattern(null);
    } else if (property.isExpression) {
      jProperty = jni.PropertyFactory.backgroundPattern$1(
        property.expression.toJExpression(arena),
      );
    } else {
      final jValue = property.value.toJString()..releasedBy(arena);
      jProperty = jni.PropertyFactory.backgroundPattern(jValue);
    }
    jLayer.as(jni.Layer.type).setProperty(jProperty);
  });

  @override
  bool get visible => using((arena) {
    final jProperty = jLayer.getVisibility()..releasedBy(arena);
    final value = jProperty.getValue()?.toDartString(releaseOriginal: true);
    return !(value == 'none');
  });

  @override
  set visible(bool newValue) => using((arena) {
    final jni.PropertyValue? jProperty;
    final stringValue = newValue ? 'visible' : 'none';
    final jValue = stringValue.toJString()..releasedBy(arena);
    jProperty = jni.PropertyFactory.visibility(jValue);
    jLayer.as(jni.Layer.type).setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get color => using((arena) {
    final jProperty = jLayer.getBackgroundColor()..releasedBy(arena);
    if (jProperty.isExpression()) {
      final expression = jProperty.getExpression()!.toDartExpression(
        releaseOriginal: true,
      );
      return PropertyValue.expression(expression);
    }
    final value = jProperty.getColorInt()!.intValue(releaseOriginal: true);
    return PropertyValue.value(Color(value));
  });

  @override
  set color(PropertyValue<Color> property) => using((arena) {
    final jni.PropertyValue? jProperty;
    if (property.isExpression) {
      jProperty = jni.PropertyFactory.backgroundColor$2(
        property.expression.toJExpression(arena),
      );
    } else {
      final jValue = property.value.toHexString().toJString()
        ..releasedBy(arena);
      jProperty = jni.PropertyFactory.backgroundColor$1(jValue);
    }
    jLayer.as(jni.Layer.type).setProperty(jProperty);
  });
}
