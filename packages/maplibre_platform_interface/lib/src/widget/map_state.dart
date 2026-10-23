import 'package:flutter/widgets.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_platform_interface/src/widget/inherited_model.dart';

/// The [State] of the [MapLibreMap] widget.
abstract class MapLibreMapState extends State<MapLibreMap>
    implements MapController {
  /// The counter is used to ensure an unique [viewName] for the platform view.
  static int _counter = 0;

  /// A unique name for the platform view.
  final viewName = 'plugins.flutter.io/maplibre${_counter++}';

  /// The [LayerManager] handles the high level markers, polygons,
  /// circles and polylines.
  LayerManager? layerManager;

  /// Get the [MapOptions] from [MapLibreMap.options].
  @override
  MapOptions get options => widget.options;

  @override
  MapCamera? camera;

  /// Set to true once the map is initialized and a [MapController.camera]
  /// is set.
  bool isInitialized = false;

  /// Applies the camera changes of the map gestures that
  /// [MapGestureDetector] recognizes over [buildPlatformWidget], or null if
  /// the platform handles gestures itself.
  GestureCameraSink? get gestureCamera => null;

  @override
  Widget build(BuildContext context) {
    final gestureCamera = this.gestureCamera;
    final platformWidget = buildPlatformWidget(context);
    return Stack(
      children: [
        if (gestureCamera == null)
          platformWidget
        else
          MapGestureDetector(
            gestures: options.gestures,
            camera: gestureCamera,
            toLngLat: (point) => isInitialized ? toLngLat(point) : null,
            onEvent: widget.onEvent,
            child: platformWidget,
          ),
        MapLibreInheritedModel(
          mapController: this,
          mapCamera: camera,
          child: isInitialized
              ? Stack(children: widget.children)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  /// Build the platform specific widget.
  Widget buildPlatformWidget(BuildContext context);
}
