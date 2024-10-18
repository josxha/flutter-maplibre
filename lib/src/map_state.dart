import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/annotation/annotation_manager.dart';
import 'package:maplibre/src/inherited_model.dart';

/// The [State] of the [MapLibreMap] widget.
abstract class MapLibreMapState extends State<MapLibreMap>
    implements MapController {
  /// The counter is used to ensure an unique [viewName] for the platform view.
  static int _counter = 0;

  /// A unique name for the platform view.
  final viewName = 'plugins.flutter.io/maplibre${_counter++}';

  /// The [AnnotationManager] handles the high level markers, polygons,
  /// circles and polylines.
  AnnotationManager? annotationManager;

  /// Get the [MapOptions] from [MapLibreMap.options].
  MapOptions get options => widget.options;

  @override
  late MapCamera camera = MapCamera(
    center: options.initCenter ?? Position(0, 0),
    zoom: options.initZoom,
    bearing: options.initBearing,
    pitch: options.initPitch,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildPlatformWidget(context),
        MapLibreInheritedModel(
          mapController: this,
          mapCamera: camera,
          child: Stack(children: widget.children),
        ),
      ],
    );
  }

  /// Build the platform specific widget.
  Widget buildPlatformWidget(BuildContext context);
}
