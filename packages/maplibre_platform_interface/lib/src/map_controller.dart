import 'package:flutter/widgets.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_platform_interface/src/widget/inherited_model.dart';

/// The [MapController] can be used to control, update and manipulate a
/// rendered [MapLibreMap].
///
/// {@category Basic}
abstract interface class MapController {
  /// Find the [MapController] of the closest [MapLibreMap] in the widget tree.
  /// Returns null if called outside of the [MapLibreMap.children].
  static MapController? maybeOf(BuildContext context) =>
      MapLibreInheritedModel.maybeMapControllerOf(context);

  /// Find the [MapController] of the closest [MapLibreMap] in the widget tree.
  /// Throws an [StateError] if called outside of the [MapLibreMap.children].
  static MapController of(BuildContext context) =>
      maybeOf(context) ??
      (throw StateError('Unable to find an instance of MapController'));

  /// Get the [MapOptions] from [MapLibreMap.options].
  MapOptions get options;

  /// Get the [StyleController] for the map. It returns null null if
  /// accessed before [MapLibreMap.onStyleLoaded] has been called.
  StyleController? get style;

  /// Convert a latitude/longitude coordinate to a screen location in logical
  /// pixels.
  Offset toScreenLocation(Geographic lngLat);

  /// Get the latitude/longitude coordinate for a screen location in logical
  /// pixels.
  Geographic toLngLat(Offset screenLocation);

  /// Convert a latitude/longitude coordinate to a screen location in logical
  /// pixels.
  List<Offset> toScreenLocations(List<Geographic> lngLats);

  /// Get the latitude/longitude coordinate for a screen location in logical
  /// pixels.
  List<Geographic> toLngLats(List<Offset> screenLocations);

  /// Moves the camera to [update] without an animation.
  ///
  /// It stops a running [animateCamera].
  Future<void> moveCamera(CameraUpdate update);

  /// Animates the camera to [update], see [CameraAnimation] for the kinds of
  /// animation.
  ///
  /// The returned future completes when the animation ends, with
  /// [CameraAnimationResult.cancelled] if a gesture, [stopCamera] or
  /// [moveCamera] stopped it.
  ///
  /// ```dart
  /// final result = await controller.animateCamera(
  ///   const CameraUpdate.position(center: munich, zoom: 12),
  ///   animation: const CameraAnimation.fly(),
  /// );
  /// ```
  Future<CameraAnimationResult> animateCamera(
    CameraUpdate update, {
    CameraAnimation animation = const CameraAnimation.ease(),
  });

  /// Stops a running [animateCamera], whose future then completes with
  /// [CameraAnimationResult.cancelled].
  Future<void> stopCamera();

  /// The camera that [update] would move the map to, without moving it.
  ///
  /// [CameraUpdatePosition.anchor] is not taken into account: the camera
  /// keeps the center of [update], or the current one.
  Future<CameraPosition> cameraFor(CameraUpdate update);

  /// Get the current camera position on the map.
  CameraPosition getCamera();

  /// Get the current camera position on the map.
  CameraPosition? get camera;

  /// Whether the map stopped rendering, because [MapLibreMap.paused] is set
  /// or the map is hidden. See [MapLibreMap.paused].
  bool get isRenderingPaused;

  /// Returns the distance spanned by one logical pixel at the specified
  /// latitude and current zoom level.
  ///
  /// The distance between pixels decreases as the latitude approaches the
  /// poles. This relationship parallels the relationship between longitudinal
  /// coordinates at different latitudes.
  double getMetersPerPixelAtLatitude(double latitude);

  /// The smallest bounding box that includes the visible part of the map.
  ///
  /// With a bearing or pitch, the visible part is not an axis-aligned
  /// rectangle, and the box is larger than it.
  GeoBox getVisibleBounds();

  /// The features that the map draws in [geometry], topmost first.
  ///
  /// If [layerIds] is non-null, only features from those layers are
  /// returned; an empty list returns none. If [filter] is non-null, only
  /// features for which it is true are returned.
  ///
  /// A feature can appear more than once, for example if it crosses tile
  /// boundaries or more than one layer draws it.
  ///
  /// Returns an empty list if the map has been disposed.
  Future<List<RenderedFeature>> queryRenderedFeatures(
    QueryGeometry geometry, {
    List<String>? layerIds,
    Expression<bool>? filter,
  });

  /// The features of the source [sourceId] in the tiles that it loaded,
  /// including features that are hidden or outside the visible part of the
  /// map, but only while a visible layer uses the source.
  ///
  /// For a vector tile source, [sourceLayer] names the source layer to
  /// query, and is required. If [filter] is non-null, only features for which
  /// it is true are returned.
  ///
  /// A feature can appear more than once, for example if it crosses tile
  /// boundaries.
  ///
  /// Returns an empty list if the map has been disposed.
  Future<List<SourceFeature>> querySourceFeatures(
    String sourceId, {
    String? sourceLayer,
    Expression<bool>? filter,
  });

  /// The zoom level at which the cluster [clusterId] of the GeoJSON source
  /// [sourceId] breaks up into its children.
  ///
  /// [clusterId] is the `cluster_id` property of a cluster feature, see
  /// [GeoJsonCluster].
  Future<double> getClusterExpansionZoom(String sourceId, int clusterId);

  /// The clusters and points one zoom level below the cluster [clusterId] of
  /// the GeoJSON source [sourceId].
  ///
  /// Returns an empty list if the map has been disposed.
  Future<List<SourceFeature>> getClusterChildren(
    String sourceId,
    int clusterId,
  );

  /// The points of the cluster [clusterId] of the GeoJSON source [sourceId],
  /// [limit] of them after skipping [offset].
  ///
  /// Returns an empty list if the map has been disposed.
  Future<List<SourceFeature>> getClusterLeaves(
    String sourceId,
    int clusterId, {
    int limit = 10,
    int offset = 0,
  });
}
