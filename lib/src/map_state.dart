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

  @override
  Widget build(BuildContext context) {
    return MapLibreInheritedModel(
      mapController: this,
      child: Stack(
        children: [
          buildPlatformWidget(context),
          ...widget.children,
        ],
      ),
    );
  }

  /// Build the platform specific widget.
  Widget buildPlatformWidget(BuildContext context);
}
