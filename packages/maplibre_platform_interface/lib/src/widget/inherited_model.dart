import 'package:flutter/widgets.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// The [InheritedModel] makes it possible to call `MapController.of(context)`.
///
/// https://api.flutter.dev/flutter/widgets/InheritedModel-class.html
class MapLibreInheritedModel extends InheritedModel<MapController> {
  /// Default constructor
  const MapLibreInheritedModel({
    required super.child,
    required this.mapController,
    required this.cameraPosition,
    super.key,
  });

  /// [MapController] instance.
  final MapController mapController;

  /// [CameraPosition] instance.
  final CameraPosition? cameraPosition;

  /// Get the [InheritedModel] that is used to inject models into the widget
  /// tree that can referenced further down in the widget tree.
  static MapLibreInheritedModel? maybeOf(BuildContext context) =>
      InheritedModel.inheritFrom<MapLibreInheritedModel>(context);

  /// Get the in the widget tree injected [MapController].
  /// Used in [MapController.maybeOf].
  static MapController? maybeMapControllerOf(BuildContext context) =>
      maybeOf(context)?.mapController;

  /// Get the in the widget tree injected [CameraPosition].
  /// Used in [CameraPosition.maybeOf].
  static CameraPosition? maybeCameraPositionOf(BuildContext context) =>
      maybeOf(context)?.cameraPosition;

  @override
  bool updateShouldNotify(covariant MapLibreInheritedModel oldWidget) {
    return true;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant MapLibreInheritedModel oldWidget,
    Set<MapController> dependencies,
  ) {
    return true;
  }
}
