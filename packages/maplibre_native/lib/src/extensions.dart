import 'package:maplibre_native_ffi/maplibre_native_ffi.dart' as mln;
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// The map events that the state always handles. Others, such as the render
/// events of every frame, are only queued while [MapLibreMap] has a callback
/// for them, see [MapLibreMapExt.eventMask].
final mln.RuntimeEventFlag _baseEventMask =
    mln.RuntimeEventFlag.mapCameraWillChange |
    mln.RuntimeEventFlag.mapCameraIsChanging |
    mln.RuntimeEventFlag.mapCameraDidChange |
    mln.RuntimeEventFlag.mapStyleLoaded |
    mln.RuntimeEventFlag.mapIdle |
    mln.RuntimeEventFlag.mapSourceChanged |
    mln.RuntimeEventFlag.mapLoadingFailed |
    mln.RuntimeEventFlag.mapRenderError |
    mln.RuntimeEventFlag.mapGlyphsError |
    mln.RuntimeEventFlag.mapSpriteError;

/// Extension methods for the [MapLibreMap] widget. Not exported publicly.
extension MapLibreMapExt on MapLibreMap {
  /// The events that the callbacks of this map need.
  mln.RuntimeEventFlag get eventMask =>
      _baseEventMask |
      (onLoadingStarted != null
          ? mln.RuntimeEventFlag.mapLoadingStarted
          : mln.RuntimeEventFlag.none) |
      (onLoadingFinished != null
          ? mln.RuntimeEventFlag.mapLoadingFinished
          : mln.RuntimeEventFlag.none) |
      (onStyleImageMissing != null
          ? mln.RuntimeEventFlag.mapStyleImageMissing
          : mln.RuntimeEventFlag.none) |
      (onTile != null
          ? mln.RuntimeEventFlag.mapTileAction
          : mln.RuntimeEventFlag.none) |
      (onRenderFrame != null
          ? mln.RuntimeEventFlag.mapRenderFrameFinished
          : mln.RuntimeEventFlag.none) |
      (onRenderMap != null
          ? mln.RuntimeEventFlag.mapRenderMapFinished
          : mln.RuntimeEventFlag.none) |
      (onGlyphs != null
          ? mln.RuntimeEventFlag.mapGlyphsRequested |
                mln.RuntimeEventFlag.mapGlyphsLoaded
          : mln.RuntimeEventFlag.none) |
      (onSprite != null
          ? mln.RuntimeEventFlag.mapSpriteRequested |
                mln.RuntimeEventFlag.mapSpriteLoaded
          : mln.RuntimeEventFlag.none);
}

/// Extension methods for the [GeoJsonSource] class. Not exported publicly.
extension GeoJsonSourceExt on GeoJsonSource {
  /// The options that data for this source must be prepared with.
  mln.GeoJsonSourceOptions toMlnOptions() {
    final json = geoJsonOptionsOf(this);
    return mln.GeoJsonSourceOptions(
      maxZoom: (json['maxzoom'] as num?)?.toDouble(),
      tolerance: (json['tolerance'] as num?)?.toDouble(),
      buffer: (json['buffer'] as num?)?.toInt(),
      lineMetrics: json['lineMetrics'] as bool?,
      cluster: json['cluster'] as bool?,
      clusterRadius: (json['clusterRadius'] as num?)?.toInt(),
      clusterMaxZoom: (json['clusterMaxZoom'] as num?)?.toDouble(),
      clusterMinPoints: (json['clusterMinPoints'] as num?)?.toInt(),
      clusterProperties: json['clusterProperties'],
    );
  }
}

/// Extension methods for the [StyleImageOptions] class. Not exported
/// publicly.
extension StyleImageOptionsExt on StyleImageOptions {
  /// These options for an image of [pixelRatio].
  mln.StyleImageOptions toMln(double pixelRatio) => mln.StyleImageOptions(
    pixelRatio: pixelRatio,
    sdf: sdf,
    stretchX: [
      for (final (from, to) in stretchX) mln.ImageStretch(from: from, to: to),
    ],
    stretchY: [
      for (final (from, to) in stretchY) mln.ImageStretch(from: from, to: to),
    ],
    content: switch (content) {
      null => null,
      final content => mln.ImageContent(
        left: content.left,
        top: content.top,
        right: content.right,
        bottom: content.bottom,
      ),
    },
    textFitWidth: textFitWidth?.toMln(),
    textFitHeight: textFitHeight?.toMln(),
  );
}

/// Extension methods for the [ImageTextFit] enum. Not exported publicly.
extension ImageTextFitExt on ImageTextFit {
  /// This fit in MapLibre Native.
  mln.StyleImageTextFit toMln() => switch (this) {
    .stretchOrShrink => mln.StyleImageTextFit.stretchOrShrink,
    .stretchOnly => mln.StyleImageTextFit.stretchOnly,
    .proportional => mln.StyleImageTextFit.proportional,
  };
}
