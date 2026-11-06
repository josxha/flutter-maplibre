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
  Future<MapCamera> cameraFor(CameraUpdate update);

  /// Get the current camera position on the map.
  MapCamera getCamera();

  /// Get the current camera position on the map.
  MapCamera? get camera;

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

  /// Returns an array of rendered map features that intersect with a given
  /// screen location measured in logical pixels.
  ///
  /// If [layerIds] is non-null, only features from those layers will be
  /// returned.
  ///
  /// NOTE: features may appear multiple times in query results, for example if
  /// they cross tile boundaries.
  ///
  /// Returns an empty list if either the map or underlying render surface has
  /// been destroyed.
  // TODO(mhernz): add filter parameter
  //
  // [filter] is an array of filter expressions. If provided, only features
  // that match all of the filters will be returned.
  Future<List<RenderedFeature>> featuresAtPoint(
    Offset point, {
    List<String>? layerIds,
  });

  /// Returns an array of rendered map features that intersect with a given
  /// on-screen rectangle measured in logical pixels.
  ///
  /// If [layerIds] is non-null, only features from those layers will be
  /// returned.
  ///
  /// NOTE: features may appear multiple times in query results, for example if
  /// they cross tile boundaries.
  ///
  /// Returns an empty list if either the map or underlying render surface has
  /// been destroyed.
  // TODO(mhernz): add filter parameter
  //
  // [filter] is an array of filter expressions. If provided, only features
  // that match all of the filters will be returned.
  Future<List<RenderedFeature>> featuresInRect(
    Rect rect, {
    List<String>? layerIds,
  });
}
