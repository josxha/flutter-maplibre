import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/annotation/annotations.dart';
import 'package:maplibre/src/platform_interface.dart';

/// The [MapLibreMap] widget that can be inserted into the flutter widget tree.
@immutable
class MapLibreMap extends StatefulWidget {
  /// Default constructor to create a new [MapLibreMap] widget with its
  /// properties.
  const MapLibreMap({
    this.options = const MapOptions(),
    this.gestureRecognizers,
    this.onMapCreated,
    this.onStyleLoaded,
    this.onEvent,
    this.layers = const [],
    super.key,
  });

  /// Use the [options] field to customize the map and set default values.
  final MapOptions options;

  /// Which gestures should be consumed by the map.
  ///
  /// It is possible for other gesture recognizers to be competing with the map
  /// on pointer events, e.g if the map is inside a [ListView] the [ListView]
  /// will want to handle vertical drags. The map will claim gestures that are
  /// recognized by any of the recognizers on this list.
  ///
  /// When this set is empty or null, the map will only handle pointer events
  /// for gestures that were not claimed by any other gesture recognizer.
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  /// Please note: you should only add annotations (e.g. symbols or circles)
  /// after `onStyleLoadedCallback` has been called.
  final MapCreatedCallback? onMapCreated;

  /// Called when the map style has been successfully loaded and the annotation
  /// managers have been enabled.
  /// Please note: you should only add annotations (e.g. symbols or circles)
  /// after this callback has been called.
  final VoidCallback? onStyleLoaded;

  /// Use this callback to handle emitted map events.
  final MapEventCallback? onEvent;

  /// Annotation layers like [MarkerAnnotationLayer] or [PolylineAnnotationLayer].
  final List<AnnotationLayer> layers;

  @override
  State<MapLibreMap> createState() =>
      // ignore: no_logic_in_create_state
      PlatformInterface.instance.createWidgetState();
}

/// Callback that fires once the native MapLibre map has been created for a
/// [MapLibreMap] widget. It provides the [MapController] to the user.
typedef MapCreatedCallback = void Function(MapController controller);

/// Callback that fires every time a [MapEvent] gets emitted by the map.
typedef MapEventCallback = void Function(MapEvent event);
