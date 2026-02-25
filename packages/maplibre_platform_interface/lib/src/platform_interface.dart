import 'package:flutter/painting.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MapLibrePlatform extends PlatformInterface {
  MapLibrePlatform() : super(token: _token);

  static final Object _token = Object();

  // A plugin can have a default implementation, as shown here, or `instance`
  // can be nullable, and the default instance can be null.
  static MapLibrePlatform _instance = _MapLibrePluginStub();

  static MapLibrePlatform get instance => _instance;

  /// Platform-specific implementations should set this to their own
  /// platform-specific class that extends [MapLibrePlatform] when they
  /// register themselves.
  static set instance(MapLibrePlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Return a platform specific [MapLibreMapState] object.
  MapLibreMapState createWidgetState() =>
      throw UnsupportedError('MapLibre is not supported on this platform.');

  /// Return a platform specific [OfflineManager] object.
  Future<OfflineManager> createOfflineManager() => throw UnsupportedError(
    'MapLibre OfflineManager is not supported on this platform.',
  );

  /// Return a platform specific [PermissionManager] object.
  PermissionManager createPermissionManager() => throw UnsupportedError(
    'MapLibre PermissionManager is not supported on this platform.',
  );

  /// Return whether offline manager is supported on the current platform.
  bool get offlineManagerIsSupported => false;

  /// Return whether permission manager is supported on the current platform.
  bool get permissionManagerIsSupported => false;

  /// Return whether user location is supported on the current platform.
  bool get userLocationIsSupported => false;

  /// Create a platform specific [BackgroundStyleLayer] object.
  BackgroundStyleLayer createBackgroundStyleLayer({
    required String id,
    required bool visible,
    required PropertyValue<Color> color,
    required PropertyValue<String>? pattern,
    required PropertyValue<double> opacity,
    required double minZoom,
    required double maxZoom,
  }) => throw UnsupportedError(
    'BackgroundStyleLayer is not supported on this platform.',
  );

  /// Create a platform specific [CircleStyleLayer] object.
  CircleStyleLayer createCircleStyleLayer({
    required String id,
    required String sourceId,
    required String? sourceLayerId,
    required Expression? filter,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<Offset> translate,
    required PropertyValue<ReferenceSpace> translateAnchor,
    required PropertyValue<double>? sortKey,
    required PropertyValue<double> radius,
    required PropertyValue<Color> color,
    required PropertyValue<double> blur,
    required PropertyValue<double> opacity,
    required PropertyValue<ReferenceSpace> pitchScale,
    required PropertyValue<ReferenceSpace> pitchAlignment,
    required PropertyValue<double> strokeWidth,
    required PropertyValue<Color> strokeColor,
    required PropertyValue<double> strokeOpacity,
  }) => throw UnsupportedError(
    'CircleStyleLayer is not supported on this platform.',
  );

  /// Create a platform specific [ColorReliefStyleLayer] object.
  ColorReliefStyleLayer createColorReliefStyleLayer({
    required String id,
    required String sourceId,
    required bool visible,
    required PropertyValue<Color>? color,
    required PropertyValue<double> opacity,
    required double minZoom,
    required double maxZoom,
  }) => throw UnsupportedError(
    'ColorReliefStyleLayer is not supported on this platform.',
  );

  /// Create a platform specific [FillExtrusionStyleLayer] object.
  FillExtrusionStyleLayer createFillExtrusionStyleLayer({
    required String id,
    required String sourceId,
    required double minZoom,
    required double maxZoom,
    required bool visible,
    required Expression? filter,
    required String? sourceLayerId,
    required PropertyValue<double> opacity,
    required PropertyValue<Color> color,
    required PropertyValue<String>? pattern,
    required PropertyValue<double> height,
    required PropertyValue<double> base,
    required PropertyValue<bool> verticalGradient,
    required PropertyValue<Offset> translate,
    required PropertyValue<ReferenceSpace> translateAnchor,
  }) => throw UnsupportedError(
    'FillExtrusionStyleLayer is not supported on this platform.',
  );

  /// Create a platform specific [FillStyleLayer] object.
  FillStyleLayer createFillStyleLayer({
    required String id,
    required String sourceId,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required String? sourceLayerId,
    required Expression? filter,
    required PropertyValue<double>? sortKey,
    required PropertyValue<Offset> translate,
    required PropertyValue<ReferenceSpace> translateAnchor,
    required PropertyValue<bool> antialias,
    required PropertyValue<Color> color,
    required PropertyValue<double> opacity,
    required PropertyValue<Color> outlineColor,
    required PropertyValue<String>? pattern,
  }) => throw UnsupportedError(
    'FillStyleLayer is not supported on this platform.',
  );

  /// Create a platform specific [HeatmapStyleLayer] object.
  HeatmapStyleLayer createHeatmapStyleLayer({
    required String id,
    required String sourceId,
    required String? sourceLayerId,
    required Expression? filter,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<double> radius,
    required PropertyValue<double> weight,
    required PropertyValue<double> intensity,
    required PropertyValue<Color>? color,
    required PropertyValue<double> opacity,
  }) => throw UnsupportedError(
    'HeatmapStyleLayer is not supported on this platform.',
  );

  /// Create a platform specific [HillshadeStyleLayer] object.
  HillshadeStyleLayer createHillshadeStyleLayer({
    required String id,
    required String sourceId,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<NumberArray> illuminationDirection,
    required PropertyValue<NumberArray> illuminationAltitude,
    required PropertyValue<IlluminationAnchor> illuminationAnchor,
    required PropertyValue<double> exaggeration,
    required PropertyValue<Color> shadowColor,
    required PropertyValue<Color> highlightColor,
    required PropertyValue<Color> accentColor,
    required PropertyValue<HillshadeMethod> method,
  }) => throw UnsupportedError(
    'HillshadeStyleLayer is not supported on this platform.',
  );

  /// Create a platform specific [LineStyleLayer] object.
  LineStyleLayer createLineStyleLayer({
    required String id,
    required String sourceId,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required String? sourceLayerId,
    required Expression? filter,
    required PropertyValue<double>? sortKey,
    required PropertyValue<Offset> translate,
    required PropertyValue<ReferenceSpace> translateAnchor,
    required PropertyValue<LineCap> cap,
    required PropertyValue<LineJoin> join,
    required PropertyValue<double> miterLimit,
    required PropertyValue<double> roundLimit,
    required PropertyValue<double> opacity,
    required PropertyValue<Color> color,
    required PropertyValue<double> width,
    required PropertyValue<double> gapWidth,
    required PropertyValue<double> offset,
    required PropertyValue<double> blur,
    required PropertyValue<List<double>>? dashArray,
    required PropertyValue<String>? pattern,
    required PropertyValue<Color>? gradient,
  }) => throw UnsupportedError(
    'LineStyleLayer is not supported on this platform.',
  );

  /// Create a platform specific [RasterStyleLayer] object.
  RasterStyleLayer createRasterStyleLayer({
    required String id,
    required String sourceId,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<double> opacity,
    required PropertyValue<double> hueRotate,
    required PropertyValue<double> brightnessMin,
    required PropertyValue<double> brightnessMax,
    required PropertyValue<double> saturation,
    required PropertyValue<double> contrast,
    required PropertyValue<RasterResampling> resampling,
    required PropertyValue<double> fadeDuration,
  }) => throw UnsupportedError(
    'RasterStyleLayer is not supported on this platform.',
  );

  /// Create a platform specific [SymbolStyleLayer] object.
  SymbolStyleLayer createSymbolStyleLayer({
    required String id,
    required String sourceId,
    required bool visible,
    required double minZoom,
    required double maxZoom,
    required String? sourceLayerId,
    required Expression? filter,
    required PropertyValue<double>? sortKey,
    required PropertyValue<SymbolPlacement> placement,
    required PropertyValue<double> spacing,
    required PropertyValue<bool> avoidEdges,
    required PropertyValue<SymbolZOrder> zOrder,
    required PropertyValue<bool> iconAllowOverlap,
    required PropertyValue<SymbolOverlap> iconOverlap,
    required PropertyValue<bool> iconIgnorePlacement,
    required PropertyValue<bool> iconOptional,
    required PropertyValue<IconRotationAlignment> iconRotationAlignment,
    required PropertyValue<double> iconSize,
    required PropertyValue<IconTextFit> iconTextFit,
    required PropertyValue<EdgeInsets> iconTextFitPadding,
    required PropertyValue<String>? iconImage,
    required PropertyValue<double> iconRotate,
    required PropertyValue<EdgeInsets> iconPadding,
    required PropertyValue<bool> iconKeepUpright,
    required PropertyValue<Offset> iconOffset,
    required PropertyValue<IconAnchor> iconAnchor,
    required PropertyValue<IconPitchAlignment> iconPitchAlignment,
    required PropertyValue<TextPitchAlignment> textPitchAlignment,
    required PropertyValue<TextRotationAlignment> textRotationAlignment,
    required PropertyValue<String> textField,
    required PropertyValue<List<String>> textFont,
    required PropertyValue<double> textSize,
    required PropertyValue<double> textMaxWidth,
    required PropertyValue<double> textLineHeight,
    required PropertyValue<double> textLetterSpacing,
    required PropertyValue<TextJustify> textJustify,
    required PropertyValue<double> textRadialOffset,
    required PropertyValue<List<IconAnchor>>? textVariableAnchor,
    required PropertyValue<List<OneOf2<String, Offset>>>?
    textVariableAnchorOffset,
    required PropertyValue<TextAnchor> textAnchor,
    required PropertyValue<double> textMaxAngle,
    required PropertyValue<List<TextWritingMode>>? textWritingMode,
    required PropertyValue<double> textRotate,
    required PropertyValue<double> textPadding,
    required PropertyValue<bool> textKeepUpright,
    required PropertyValue<TextTransform> textTransform,
    required PropertyValue<Offset> textOffset,
    required PropertyValue<bool> textAllowOverlap,
    required PropertyValue<SymbolOverlap>? textOverlap,
    required PropertyValue<bool> textIgnorePlacement,
    required PropertyValue<bool> textOptional,
    required PropertyValue<double> iconOpacity,
    required PropertyValue<Color> iconColor,
    required PropertyValue<Color> iconHaloColor,
    required PropertyValue<double> iconHaloWidth,
    required PropertyValue<double> iconHaloBlur,
    required PropertyValue<Offset> iconTranslate,
    required PropertyValue<ReferenceSpace> iconTranslateAnchor,
    required PropertyValue<double> textOpacity,
    required PropertyValue<Color> textColor,
    required PropertyValue<Color> textHaloColor,
    required PropertyValue<double> textHaloWidth,
    required PropertyValue<double> textHaloBlur,
    required PropertyValue<Offset> textTranslate,
    required PropertyValue<ReferenceSpace> textTranslateAnchor,
  }) => throw UnsupportedError(
    'SymbolStyleLayer is not supported on this platform.',
  );
}

/// A stub implementation of the MapLibrePlatform interface.
///
/// This class is used when no actual platform implementation is provided so
/// that e.g. unit tests can still detect [offlineManagerIsSupported],
/// [permissionManagerIsSupported], and [userLocationIsSupported] without causing
/// errors.
class _MapLibrePluginStub extends MapLibrePlatform {}
