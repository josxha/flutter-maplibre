/// Conversions between the types of this plugin and those of
/// `maplibre_native_ffi`: `toMln()` converts to the C API, `to<Type>()`
/// converts back. Not exported publicly.
library;

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/widgets.dart' show EdgeInsets;
import 'package:geobase/geobase.dart' show GeometryBuilder;
import 'package:maplibre_native/src/offline_manager.dart'
    show decodeRegionMetadata;
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

/// Extension methods for the [MapLibreMap] widget.
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

/// Extension methods for the [GeoJsonSource] class.
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

/// Extension methods for the [StyleImageOptions] class.
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

/// Extension methods for the [ImageTextFit] enum.
extension ImageTextFitExt on ImageTextFit {
  /// This fit in MapLibre Native.
  mln.StyleImageTextFit toMln() => switch (this) {
    .stretchOrShrink => mln.StyleImageTextFit.stretchOrShrink,
    .stretchOnly => mln.StyleImageTextFit.stretchOnly,
    .proportional => mln.StyleImageTextFit.proportional,
  };
}

/// Extension methods for the [Geographic] class.
extension GeographicExt on Geographic {
  /// This position in the C API.
  mln.LatLng toMln() => mln.LatLng(latitude: lat, longitude: lon);
}

/// Extension methods for the [GeoBox] class.
extension GeoBoxExt on GeoBox {
  /// These bounds in the C API.
  mln.LatLngBounds toMln() => mln.LatLngBounds(
    southwest: mln.LatLng(latitude: south, longitude: west),
    northeast: mln.LatLng(latitude: north, longitude: east),
  );
}

/// Extension methods for the [Offset] class.
extension OffsetExt on Offset {
  /// This screen location in the C API.
  mln.ScreenPoint toMln() => mln.ScreenPoint(x: dx, y: dy);
}

/// Extension methods for the [Rect] class.
extension RectExt on Rect {
  /// This rectangle on screen in the C API.
  mln.ScreenBox toMln() =>
      mln.ScreenBox(min: topLeft.toMln(), max: bottomRight.toMln());
}

/// Extension methods for the [EdgeInsets] class.
extension EdgeInsetsExt on EdgeInsets {
  /// This padding in the C API.
  mln.EdgeInsets toMln() =>
      mln.EdgeInsets(top: top, left: left, bottom: bottom, right: right);
}

/// Extension methods for the [CameraAnimation] class.
extension CameraAnimationExt on CameraAnimation {
  /// This animation in the C API.
  mln.AnimationOptions toMln() {
    final easing = mln.UnitBezier(
      x1: curve.a,
      y1: curve.b,
      x2: curve.c,
      y2: curve.d,
    );
    return switch (this) {
      CameraAnimationEase(:final duration) => mln.AnimationOptions(
        durationMs: duration.inMicroseconds / 1000,
        easing: easing,
      ),
      CameraAnimationFly(:final duration, :final speed, :final peakZoom) =>
        mln.AnimationOptions(
          durationMs: duration == null ? null : duration.inMicroseconds / 1000,
          velocity: duration == null ? speed : null,
          minZoom: peakZoom,
          easing: easing,
        ),
    };
  }
}

/// Extension methods for the [OfflineRegionDefinition] class.
extension OfflineRegionDefinitionExt on OfflineRegionDefinition {
  /// This region definition in the C API.
  mln.OfflineRegionDefinition toMln() => switch (this) {
    final OfflineTilePyramidRegionDefinition definition =>
      mln.OfflineRegionDefinition.tilePyramid(
        mln.OfflineTilePyramidRegionDefinition(
          styleUrl: definition.styleUrl,
          bounds: definition.bounds.toMln(),
          minZoom: definition.minZoom,
          maxZoom: definition.maxZoom,
          pixelRatio: definition.pixelRatio,
          includeIdeographs: definition.includeIdeographs,
        ),
      ),
    final OfflineGeometryRegionDefinition definition =>
      mln.OfflineRegionDefinition.geometry(
        mln.OfflineGeometryRegionDefinition(
          styleUrl: definition.styleUrl,
          geometry: jsonDecode(definition.geometry.toText()),
          minZoom: definition.minZoom,
          maxZoom: definition.maxZoom,
          pixelRatio: definition.pixelRatio,
          includeIdeographs: definition.includeIdeographs,
        ),
      ),
  };
}

/// Extension methods for the [mln.LatLng] class.
extension MlnLatLngExt on mln.LatLng {
  /// This position as a [Geographic].
  Geographic toGeographic() => Geographic(lon: longitude, lat: latitude);
}

/// Extension methods for the [mln.ScreenPoint] class.
extension MlnScreenPointExt on mln.ScreenPoint {
  /// This screen location as an [Offset].
  Offset toOffset() => Offset(x, y);
}

/// Extension methods for the [mln.EdgeInsets] class.
extension MlnEdgeInsetsExt on mln.EdgeInsets {
  /// This padding as [EdgeInsets].
  EdgeInsets toEdgeInsets() => EdgeInsets.fromLTRB(left, top, right, bottom);
}

/// Extension methods for the [mln.Camera] class.
extension MlnCameraExt on mln.Camera {
  /// This camera as a [CameraPosition]. The native center is unwrapped to the
  /// visible world copy; the public camera wraps its longitude into
  /// [-180, 180).
  CameraPosition toCameraPosition() => CameraPosition(
    center: Geographic(
      lon: (center.longitude + 180) % 360 - 180,
      lat: center.latitude,
    ),
    zoom: zoom,
    bearing: bearing,
    pitch: pitch,
    roll: roll,
    padding: padding.toEdgeInsets(),
  );
}

/// Extension methods for the [mln.TileOperation] class.
extension MlnTileOperationExt on mln.TileOperation {
  /// This operation as a [MapTileOperation], or null for one that the plugin
  /// doesn't report.
  MapTileOperation? toMapTileOperation() => switch (this) {
    mln.TileOperation.requestedFromCache => .requestedFromCache,
    mln.TileOperation.requestedFromNetwork => .requestedFromNetwork,
    mln.TileOperation.loadFromNetwork => .loadFromNetwork,
    mln.TileOperation.loadFromCache => .loadFromCache,
    mln.TileOperation.startParse => .startParse,
    mln.TileOperation.endParse => .endParse,
    mln.TileOperation.error => .error,
    mln.TileOperation.cancelled => .cancelled,
    _ => null,
  };
}

/// Extension methods for the [mln.OfflineRegionStatus] class.
extension MlnOfflineRegionStatusExt on mln.OfflineRegionStatus {
  /// This status as an [OfflineRegionStatus].
  OfflineRegionStatus toOfflineRegionStatus() => OfflineRegionStatus(
    downloadState: downloadState == mln.OfflineRegionDownloadState.active
        ? OfflineRegionDownloadState.active
        : OfflineRegionDownloadState.inactive,
    completedResourceCount: completedResourceCount,
    completedResourceSize: completedResourceSize,
    completedTileCount: completedTileCount,
    completedTileSize: completedTileSize,
    requiredResourceCount: requiredResourceCount,
    requiredTileCount: requiredTileCount,
    requiredResourceCountIsPrecise: requiredResourceCountIsPrecise,
    complete: complete,
  );
}

/// Extension methods for the [mln.ResourceErrorReason] class.
extension MlnResourceErrorReasonExt on mln.ResourceErrorReason {
  /// This reason as an [OfflineResourceErrorReason].
  OfflineResourceErrorReason toOfflineResourceErrorReason() => switch (this) {
    mln.ResourceErrorReason.notFound => .notFound,
    mln.ResourceErrorReason.server => .server,
    mln.ResourceErrorReason.connection => .connection,
    mln.ResourceErrorReason.rateLimit => .rateLimit,
    _ => .other,
  };
}

/// Extension methods for the [mln.OfflineRegionInfo] class.
extension MlnOfflineRegionInfoExt on mln.OfflineRegionInfo {
  /// This region as an [OfflineRegion].
  OfflineRegion toOfflineRegion() => OfflineRegion(
    id: id,
    definition: switch (definition) {
      mln.OfflineRegionDefinitionUnknown(:final tag) => throw UnsupportedError(
        'Offline region $id has a definition of unknown type $tag.',
      ),
      mln.OfflineRegionDefinitionTilePyramid(:final value) =>
        OfflineTilePyramidRegionDefinition(
          bounds: GeoBox(
            west: value.bounds.southwest.longitude,
            south: value.bounds.southwest.latitude,
            east: value.bounds.northeast.longitude,
            north: value.bounds.northeast.latitude,
          ),
          styleUrl: value.styleUrl,
          minZoom: value.minZoom,
          maxZoom: value.maxZoom,
          pixelRatio: value.pixelRatio,
          includeIdeographs: value.includeIdeographs,
        ),
      mln.OfflineRegionDefinitionGeometry(:final value) =>
        OfflineGeometryRegionDefinition(
          geometry: GeometryBuilder.parse(jsonEncode(value.geometry)),
          styleUrl: value.styleUrl,
          minZoom: value.minZoom,
          maxZoom: value.maxZoom,
          pixelRatio: value.pixelRatio,
          includeIdeographs: value.includeIdeographs,
        ),
    },
    metadata: decodeRegionMetadata(metadata),
  );
}

/// Converts a resource kind of the C API.
extension MlnResourceKindExt on mln.ResourceKind {
  /// The [MapResourceKind] of this kind.
  MapResourceKind toMapResourceKind() => switch (this) {
    mln.ResourceKind.style => MapResourceKind.style,
    mln.ResourceKind.source => MapResourceKind.source,
    mln.ResourceKind.tile => MapResourceKind.tile,
    mln.ResourceKind.glyphs => MapResourceKind.glyphs,
    mln.ResourceKind.spriteImage => MapResourceKind.spriteImage,
    mln.ResourceKind.spriteJson => MapResourceKind.spriteJson,
    mln.ResourceKind.image => MapResourceKind.image,
    _ => MapResourceKind.unknown,
  };
}

/// Converts a resource kind to the C API.
extension MapResourceKindExt on MapResourceKind {
  /// The flag of this kind.
  mln.ResourceKindFlag toMln() => switch (this) {
    MapResourceKind.unknown => mln.ResourceKindFlag.unknown,
    MapResourceKind.style => mln.ResourceKindFlag.style,
    MapResourceKind.source => mln.ResourceKindFlag.source,
    MapResourceKind.tile => mln.ResourceKindFlag.tile,
    MapResourceKind.glyphs => mln.ResourceKindFlag.glyphs,
    MapResourceKind.spriteImage => mln.ResourceKindFlag.spriteImage,
    MapResourceKind.spriteJson => mln.ResourceKindFlag.spriteJson,
    MapResourceKind.image => mln.ResourceKindFlag.image,
  };
}

/// Converts request headers to the C API.
extension RequestHeadersExt on RequestHeaders {
  /// The header rule of these headers. Leave out ones with no [kinds],
  /// which match nothing.
  mln.HttpHeaderRule toMln() => mln.HttpHeaderRule(
    // No flags select every kind. An empty set of kinds matches nothing,
    // so it has no rule.
    kinds: switch (kinds) {
      null => mln.ResourceKindFlag.none,
      final kinds => kinds.fold(
        mln.ResourceKindFlag.none,
        (flags, kind) => flags | kind.toMln(),
      ),
    },
    flags: mln.UrlMatchFlag.glob,
    url: url,
    headers: [
      for (final MapEntry(:key, :value) in headers.entries)
        mln.HttpHeader(name: key, value: value),
    ],
  );
}
