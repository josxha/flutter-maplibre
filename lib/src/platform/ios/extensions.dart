import 'dart:convert';
import 'dart:ffi' hide Size;

import 'package:flutter/cupertino.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre_ios/maplibre_ffi.dart';
import 'package:objective_c/objective_c.dart';

/// Internal extensions on [CLLocationCoordinate2D].
extension CLLocationCoordinate2DExt on CLLocationCoordinate2D {
  /// Convert a [CLLocationCoordinate2D] to [Geographic].
  Geographic toGeographic() => Geographic(lon: longitude, lat: latitude);
}

/// Internal extensions on [Geographic].
extension PositionExt on Geographic {
  /// Convert a [Geographic] to a [CLLocationCoordinate2D].
  CLLocationCoordinate2D toCLLocationCoordinate2D() {
    final coords = Struct.create<CLLocationCoordinate2D>();
    coords.latitude = lat;
    coords.longitude = lon;
    return coords;
  }
}

/// Internal extensions on [Offset].
extension OffsetExt on Offset {
  /// Convert a [Geographic] to a [CGPoint].
  CGPoint toCGPoint() {
    final point = Struct.create<CGPoint>();
    point.x = dx;
    point.y = dy;
    return point;
  }
}

/// Internal extension on [Size].
extension SizeExt on Size {
  /// Convert a [Size] to a [CGSize].
  CGSize toCGSize() {
    final size = Struct.create<CGSize>();
    size.width = width;
    size.height = height;
    return size;
  }
}

/// Internal extension on [Rect].
extension RectExt on Rect {
  /// Convert a [Rect] to a [CGRect].
  CGRect toCGRect() {
    final rect = Struct.create<CGRect>();
    rect.origin = topLeft.toCGPoint();
    rect.size = size.toCGSize();
    return rect;
  }
}

/// Internal extensions on [LngLatBounds].
extension LngLatBoundsExt on LngLatBounds {
  /// Convert a [LngLatBounds] to a [CGPoint].
  MLNCoordinateBounds toMLNCoordinateBounds() {
    final bounds = Struct.create<MLNCoordinateBounds>();
    bounds.sw = Struct.create<CLLocationCoordinate2D>()
      ..longitude = longitudeWest
      ..latitude = latitudeSouth;
    bounds.ne = Struct.create<CLLocationCoordinate2D>()
      ..longitude = longitudeEast
      ..latitude = latitudeNorth;
    return bounds;
  }
}

/// Internal extensions on [MLNCoordinateBounds].
extension MLNCoordinateBoundsExt on MLNCoordinateBounds {
  /// Convert a [MLNCoordinateBounds] to a [LngLatBounds].
  LngLatBounds toLngLatBounds() => LngLatBounds(
    longitudeWest: sw.longitude,
    longitudeEast: ne.longitude,
    latitudeSouth: sw.latitude,
    latitudeNorth: ne.latitude,
  );
}

/// Internal extensions on [CGPoint].
extension CGPointExt on CGPoint {
  /// Convert a [CGPoint] to a [Offset].
  Offset toOffset() => Offset(x, y);
}

/// Internal extensions on [String].
extension StringExt on String {
  /// Convert to a [NSURL].
  NSURL? toNSURL() => NSURL.URLWithString(toNSString());

  /// Convert to a [NSURL].
  NSData? toNSDataUTF8() =>
      toNSString().dataUsingEncoding(nsUTF8StringEncoding);

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
    Helpers.parseExpressionWithPropertyName(
      propertyName.toNSString(),
      expression: json.toNSString(),
    );

/// Internal extensions on [MLNStyleLayer].
extension MLNStyleLayerExt on MLNStyleLayer {
  /// Apply all paint or layout properties on the [MLNStyleLayer].
  void setProperties(Map<String, Object> properties) {
    for (final property in properties.entries) {
      // print('${property.key}   ${jsonEncode(property.value)}');
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
    final NSExpression? expression;
    try {
      expression = parseNSExpression(key, rawValue);
    } catch (error, stacktrace) {
      debugPrint(error.toString());
      debugPrintStack(stackTrace: stacktrace);
      return;
    }
    // print('${expression?.description1 ?? 'no expression!'}');
    if (expression == null) return;

    // some variables have a different name in ios than in the style spec
    // https://maplibre.org/maplibre-native/ios/latest/documentation/maplibre-native-for-ios/for_style_authors#Configuring-the-map-contents-appearance
    switch (key) {
      case 'circle-pitch-scale':
        (this as MLNCircleStyleLayer).circleScaleAlignment = expression;
      case 'circle-translate':
        (this as MLNCircleStyleLayer).circleTranslation = expression;
      case 'circle-translate-anchor':
        (this as MLNCircleStyleLayer).circleTranslateAnchor = expression;
      case 'fill-antialias':
        (this as MLNFillStyleLayer).fillAntialiased = expression;
      case 'fill-translate':
        (this as MLNFillStyleLayer).fillTranslation = expression;
      case 'fill-translate-anchor':
        (this as MLNFillStyleLayer).fillTranslationAnchor = expression;
      case 'fill-extrusion-vertical-gradient':
        (this as MLNFillExtrusionStyleLayer).fillExtrusionHasVerticalGradient =
            expression;
      case 'fill-extrusion-translate':
        (this as MLNFillExtrusionStyleLayer).fillExtrusionTranslation =
            expression;
      case 'fill-extrusion-translate-anchor':
        (this as MLNFillExtrusionStyleLayer).fillExtrusionTranslationAnchor =
            expression;
      case 'line-dasharray':
        (this as MLNLineStyleLayer).lineDashPattern = expression;
      case 'line-translate':
        (this as MLNLineStyleLayer).lineTranslation = expression;
      case 'line-translate-anchor':
        (this as MLNLineStyleLayer).lineTranslationAnchor = expression;
      case 'raster-brightness-max':
        (this as MLNRasterStyleLayer).maximumRasterBrightness = expression;
      case 'raster-brightness-min':
        (this as MLNRasterStyleLayer).minimumRasterBrightness = expression;
      case 'raster-hue-rotate':
        (this as MLNRasterStyleLayer).rasterHueRotation = expression;
      case 'raster-resampling':
        (this as MLNRasterStyleLayer).rasterResamplingMode = expression;
      case 'icon-allow-overlap':
        (this as MLNSymbolStyleLayer).iconAllowsOverlap = expression;
      case 'icon-ignore-placement':
        (this as MLNSymbolStyleLayer).iconIgnoresPlacement = expression;
      case 'icon-image':
        (this as MLNSymbolStyleLayer).iconImageName = expression;
      case 'icon-optional':
        (this as MLNSymbolStyleLayer).iconOptional = expression;
      case 'icon-rotate':
        (this as MLNSymbolStyleLayer).iconRotation = expression;
      case 'icon-size':
        (this as MLNSymbolStyleLayer).iconScale = expression;
      case 'icon-keep-upright':
        (this as MLNSymbolStyleLayer).keepsIconUpright = expression;
      case 'text-keep-upright':
        (this as MLNSymbolStyleLayer).keepsTextUpright = expression;
      case 'text-max-angle':
        (this as MLNSymbolStyleLayer).maximumTextAngle = expression;
      case 'text-max-width':
        (this as MLNSymbolStyleLayer).maximumTextWidth = expression;
      case 'symbol-avoid-edges':
        (this as MLNSymbolStyleLayer).symbolAvoidsEdges = expression;
      case 'text-field':
        (this as MLNSymbolStyleLayer).text = expression;
      case 'text-allow-overlap':
        (this as MLNSymbolStyleLayer).textAllowsOverlap = expression;
      case 'text-font':
        (this as MLNSymbolStyleLayer).textFontNames = expression;
      case 'text-size':
        (this as MLNSymbolStyleLayer).textFontSize = expression;
      case 'text-ignore-placement':
        (this as MLNSymbolStyleLayer).textIgnoresPlacement = expression;
      case 'text-justify':
        (this as MLNSymbolStyleLayer).textJustification = expression;
      case 'text-optional':
        (this as MLNSymbolStyleLayer).textOptional = expression;
      case 'text-rotate':
        (this as MLNSymbolStyleLayer).textRotation = expression;
      case 'text-writing-mode':
        (this as MLNSymbolStyleLayer).textWritingModes = expression;
      case 'icon-translate':
        (this as MLNSymbolStyleLayer).iconTranslation = expression;
      case 'icon-translate-anchor':
        (this as MLNSymbolStyleLayer).iconTranslationAnchor = expression;
      case 'text-translate':
        (this as MLNSymbolStyleLayer).textTranslation = expression;
      case 'text-translate-anchor':
        (this as MLNSymbolStyleLayer).textTranslationAnchor = expression;
      default:
        Helpers.setExpressionWithTarget(
          this,
          field: key.dashedToCamelCase().toNSString(),
          expression: expression,
        );
    }
  }
}

/// UTF8 Encoding
const nsUTF8StringEncoding = 4;
