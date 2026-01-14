import 'dart:ui';

import 'package:flutter/painting.dart' show EdgeInsets;
import 'package:jni/jni.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/android/extensions.dart';
import 'package:maplibre/src/platform/android/jni.g.dart' as jni;

part 'background_style_layer.dart';
part 'circle_style_layer.dart';
part 'fill_extrusion_style_layer.dart';
part 'fill_style_layer.dart';
part 'heatmap_style_layer.dart';
part 'hillshade_style_layer.dart';
part 'line_style_layer.dart';
part 'raster_style_layer.dart';
part 'symbol_style_layer.dart';

/// Android implementation of [StyleLayer].
abstract class StyleLayerAndroid<JLayer extends jni.Layer>
    implements StyleLayer {
  /// Construct an [StyleLayerAndroid] from a JNI layer.
  StyleLayerAndroid.fromNativeLayer(this.jLayer) {
    final finalizer = Finalizer<jni.Layer>((j) => j.release());
    finalizer.attach(this, jLayer, detach: this);
  }

  /// The JNI layer instance.
  final JLayer jLayer;

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
}
