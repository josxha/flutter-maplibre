import 'dart:ui';

import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/android/extensions.dart';
import 'package:maplibre/src/platform/android/jni.g.dart' as jni;

/// A layer that contains circles for Android platform.
class AndroidBackgroundStyleLayer implements BackgroundStyleLayer {
  /// Default constructor for a [AndroidBackgroundStyleLayer] instance.
  AndroidBackgroundStyleLayer({
    required String id,
    double minZoom = 0,
    double maxZoom = 24,
    PropertyValue<Color> color = const PropertyValue<Color>.value(
      Color(0x00000000),
    ),
    PropertyValue<double> opacity = const PropertyValue.value(1),
    bool visible = true,
  }) : _jLayer = jni.BackgroundLayer(id.toJString()) {
    final finalizer = Finalizer<jni.BackgroundLayer>((j) => j.release());
    finalizer.attach(this, _jLayer, detach: this);

    this.minZoom = minZoom;
    this.maxZoom = maxZoom;
    this.color = color;
    this.opacity = opacity;
    this.visible = visible;
  }

  /// Construct a [AndroidBackgroundStyleLayer] from a JNI layer.
  AndroidBackgroundStyleLayer.fromJLayer(this._jLayer) {
    final finalizer = Finalizer<jni.BackgroundLayer>((j) => j.release());
    finalizer.attach(this, _jLayer, detach: this);
  }

  final jni.BackgroundLayer _jLayer;

  @override
  String get id => _jLayer.getId().toDartString(releaseOriginal: true);

  @override
  double get maxZoom => _jLayer.getMaxZoom();

  set maxZoom(double value) => _jLayer.setMaxZoom(value);

  @override
  double get minZoom => _jLayer.getMinZoom();

  set minZoom(double value) => _jLayer.setMinZoom(value);

  @override
  PropertyValue<double> get opacity => using((arena) {
    final jProperty = _jLayer.getBackgroundOpacity()..releasedBy(arena);
    if (jProperty.isExpression()) {
      final expression = jProperty.getExpression()!.toDartExpression(
        releaseOriginal: true,
      );
      return PropertyValue.expression(expression);
    }
    final value = jProperty.getValue()!.floatValue(releaseOriginal: true);
    return PropertyValue.value(value);
  });

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
    _jLayer.as(jni.Layer.type).setProperty(jProperty);
  });

  @override
  bool get visible => using((arena) {
    final jProperty = _jLayer.getVisibility()..releasedBy(arena);
    final value = jProperty.getValue()?.toDartString(releaseOriginal: true);
    return !(value == 'none');
  });

  set visible(bool newValue) => using((arena) {
    final jni.PropertyValue? jProperty;
    final stringValue = newValue ? 'visible' : 'none';
    final jValue = stringValue.toJString()..releasedBy(arena);
    jProperty = jni.PropertyFactory.visibility(jValue);
    _jLayer.as(jni.Layer.type).setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get color => using((arena) {
    final jProperty = _jLayer.getBackgroundColor()..releasedBy(arena);
    if (jProperty.isExpression()) {
      final expression = jProperty.getExpression()!.toDartExpression(
        releaseOriginal: true,
      );
      return PropertyValue.expression(expression);
    }
    final value = jProperty.getColorInt()!.intValue(releaseOriginal: true);
    return PropertyValue.value(Color(value));
  });

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
    _jLayer.as(jni.Layer.type).setProperty(jProperty);
  });
}
