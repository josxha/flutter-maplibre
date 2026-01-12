import 'dart:js_interop';
import 'dart:ui';

import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/android/extensions.dart';
import 'package:maplibre/src/platform/web/interop/interop.dart' as js;
import 'package:maplibre/src/platform/web/style/style.dart';
import 'package:maplibre/src/style/expressions/types.dart';

/// A layer that contains circles for web platform.
class BackgroundStyleLayerWeb extends StyleLayerWeb<js.LayerSpecification>
    implements BackgroundStyleLayer {
  /// Default constructor for a [BackgroundStyleLayerWeb] instance.
  BackgroundStyleLayerWeb({
    required String id,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<Color> color,
    required PropertyValue<String>? pattern,
    required PropertyValue<double> opacity,
    required bool visible,
  }) : super.fromNativeLayer(
         js.LayerSpecification(
           id: id,
           type: 'background',
           layout: <String, Object?>{}.jsify()!,
           paint: <String, Object?>{}.jsify()!,
           maxzoom: maxZoom,
           minzoom: minZoom,
         ),
       ) {
    this.color = color;
    this.opacity = opacity;
    this.visible = visible;
    this.pattern = pattern;
  }

  @override
  String get id => jsLayer.identifier.toString();

  @override
  double get maxZoom => jsLayer.maximumZoomLevel;

  @override
  set maxZoom(double value) => jsLayer.maximumZoomLevel = value;

  @override
  double get minZoom => jsLayer.minimumZoomLevel;

  @override
  set minZoom(double value) => jsLayer.minimumZoomLevel = value;

  @override
  PropertyValue<Color> get color => jsLayer.backgroundColor;

  @override
  set color(PropertyValue<Color> value) {
    jsLayer.backgroundColor = NSExpression.expressionWithFormat(
      value.value.toHexString().toNSString(),
    );
    // TODO handle expressions
  }

  @override
  PropertyValue<double> get opacity => jsLayer.backgroundOpacity;

  @override
  set opacity(PropertyValue<double> value) {
    jsLayer.backgroundOpacity = NSExpression.expressionForConstantValue(
      value.value.toNSNumber(),
    );
    // TODO handle expressions
  }

  @override
  PropertyValue<String>? get pattern => jsLayer.backgroundPattern;

  @override
  set pattern(PropertyValue<String>? value) {
    jsLayer.backgroundOpacity = NSExpression.expressionForConstantValue(
      value?.value.toNSString(),
    );
    // TODO handle expressions
  }

  @override
  bool get visible => jsLayer.isVisible;

  @override
  set visible(bool value) => jsLayer.isVisible = value;
}
