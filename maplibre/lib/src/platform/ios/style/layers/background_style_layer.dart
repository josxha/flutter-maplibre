import 'dart:ui';

import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform/ios/style/style.dart';
import 'package:maplibre_ios/maplibre_ffi.g.dart';
import 'package:maplibre_ios/objective_c.dart';

/// A layer that contains circles for iOS platform.
class BackgroundStyleLayerIos extends StyleLayerIos<MLNBackgroundStyleLayer>
    implements BackgroundStyleLayer {
  /// Default constructor for a [BackgroundStyleLayerIos] instance.
  BackgroundStyleLayerIos({
    required String id,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<Color> color,
    required PropertyValue<String>? pattern,
    required PropertyValue<double> opacity,
    required bool visible,
  }) : super.fromNativeLayer(MLNBackgroundStyleLayer.new$()) {
    ffiLayer.initWithIdentifier(id.toNSString());
    this.minZoom = minZoom;
    this.maxZoom = maxZoom;
    this.color = color;
    this.opacity = opacity;
    this.visible = visible;
    this.pattern = pattern;
  }

  @override
  String get id => ffiLayer.identifier.toString();

  @override
  double get maxZoom => ffiLayer.maximumZoomLevel;

  @override
  set maxZoom(double value) => ffiLayer.maximumZoomLevel = value;

  @override
  double get minZoom => ffiLayer.minimumZoomLevel;

  @override
  set minZoom(double value) => ffiLayer.minimumZoomLevel = value;

  @override
  PropertyValue<Color> get color => ffiLayer.backgroundColor;

  @override
  set color(PropertyValue<Color> value) {
    ffiLayer.backgroundColor = NSExpression.expressionWithFormat(
      value.value.toHexString().toNSString(),
    );
    // TODO handle expressions
  }

  @override
  PropertyValue<double> get opacity => ffiLayer.backgroundOpacity;

  @override
  set opacity(PropertyValue<double> value) {
    ffiLayer.backgroundOpacity = NSExpression.expressionForConstantValue(
      value.value.toNSNumber(),
    );
    // TODO handle expressions
  }

  @override
  PropertyValue<String>? get pattern => ffiLayer.backgroundPattern;

  @override
  set pattern(PropertyValue<String>? value) {
    ffiLayer.backgroundOpacity = NSExpression.expressionForConstantValue(
      value?.value.toNSString(),
    );
    // TODO handle expressions
  }

  @override
  bool get visible => ffiLayer.isVisible;

  @override
  set visible(bool value) => ffiLayer.isVisible = value;
}
