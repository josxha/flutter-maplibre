import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/platform_interface.dart';

@immutable
class MapLibreMap extends StatefulWidget {
  const MapLibreMap({
    this.options = const MapOptions(),
    this.gestureRecognizers,
    this.onMapCreated,
    this.onStyleLoaded,
    super.key,
  });

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

  @override
  State<MapLibreMap> createState() => _MapLibreMapState();
}

class _MapLibreMapState extends State<MapLibreMap> {
  late final MapControllerInternal _controller;

  @override
  void initState() {
    _controller = MapLibrePlatform.instance.createMapController(widget);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _controller.buildWidget();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

typedef MapCreatedCallback = void Function(MapController controller);
