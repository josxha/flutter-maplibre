import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// The [MapLibreMap] widget that can be inserted into the flutter widget tree.
///
/// {@category Basic}
@immutable
class MapLibreMap extends StatefulWidget {
  /// Default constructor to create a new [MapLibreMap] widget with its
  /// properties.
  const MapLibreMap({
    this.options = const MapOptions(),
    this.gestureRecognizers,
    this.onMapCreated,
    this.onStyleLoaded,
    this.onClick,
    this.onDoubleClick,
    this.onSecondaryClick,
    this.onLongClick,
    this.onCameraMoveStart,
    this.onCameraMove,
    this.onCameraMoveEnd,
    this.onIdle,
    this.onError,
    this.onStyleImageMissing,
    this.onLoadingStarted,
    this.onLoadingFinished,
    this.onSourceChanged,
    this.onTile,
    this.onRenderFrame,
    this.onRenderMap,
    this.onGlyphs,
    this.onSprite,
    this.onRenderingChanged,
    this.onResize,
    this.onContextLost,
    this.onContextRestored,
    this.onProjectionChanged,
    this.layers = const [],
    this.children = const [],
    this.paused = false,
    super.key,
  });

  /// Use the [options] field to customize the map and set default values.
  final MapOptions options;

  /// Flutter widgets that get displayed on top on the map and are within the
  /// [MapLibreMap] context.
  ///
  /// You can use the following included UI elements or build your own:
  /// - MapCompass
  /// - MapControlButtons
  /// - MapScalebar
  /// - SourceAttribution.
  final List<Widget> children;

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

  /// Called when the native platform view has been created and the map is
  /// ready.
  ///
  /// Please note: you should only add style layers (e.g. symbols or circles)
  /// after `onStyleLoadedCallback` has been called.
  final MapCreatedCallback? onMapCreated;

  /// Called when the map style has been successfully loaded and the annotation
  /// manager is active.
  ///
  /// Please note: you should only add style layers (e.g. symbols or circles)
  /// after this callback has been called.
  final StyleLoadedCallback? onStyleLoaded;

  /// Called when the user taps or clicks the map.
  ///
  /// A tap waits for a second one only while [onDoubleClick] is set or the
  /// zoom gesture of [MapOptions.gestures] is on, as a double tap zooms then.
  final MapEventCallback<MapEventClick>? onClick;

  /// Called when the user taps or clicks the map twice in quick succession.
  ///
  /// A double tap zooms in while the zoom gesture of [MapOptions.gestures] is
  /// on. Call [MapEventDoubleClick.preventDefault] to handle the double tap
  /// yourself instead. The callback can be async, for example to query the
  /// features at [MapEventUserInput.screenPoint] first: the map waits for
  /// the returned [Future] before it zooms.
  ///
  /// ```dart
  /// onDoubleClick: (event) async {
  ///   final features = await controller.queryRenderedFeatures(
  ///     .point(event.screenPoint),
  ///   );
  ///   if (features.isNotEmpty) event.preventDefault();
  /// },
  /// ```
  ///
  /// While neither this nor the zoom gesture is set, the map doesn't
  /// recognize double taps, so [onClick] fires right away.
  final FutureOr<void> Function(MapEventDoubleClick event)? onDoubleClick;

  /// Called when the user clicks the map with the secondary mouse button,
  /// usually the right one.
  final MapEventCallback<MapEventSecondaryClick>? onSecondaryClick;

  /// Called when the user presses the map at one location for a while.
  final MapEventCallback<MapEventLongClick>? onLongClick;

  /// Called when the camera starts to move, with the reason.
  final MapEventCallback<MapEventCameraMoveStart>? onCameraMoveStart;

  /// Called whenever the camera changed while it moves.
  final MapEventCallback<MapEventCameraMove>? onCameraMove;

  /// Called when the camera stops moving, with the camera it ended at.
  final MapEventCallback<MapEventCameraMoveEnd>? onCameraMoveEnd;

  /// Called when the map is idle: no camera moves, all requested tiles have
  /// loaded and all fade and transition animations have ended.
  final MapEventCallback<MapEventIdle>? onIdle;

  /// Called when the style, a source, glyphs or a sprite fail to load, or
  /// the map fails to render.
  ///
  /// Native maps print errors to the log while this is not set.
  final MapEventCallback<MapEventError>? onError;

  /// Called when a layer uses an image that the style doesn't have. Add it
  /// with [StyleController.addImage] to show it.
  final MapEventCallback<MapEventStyleImageMissing>? onStyleImageMissing;

  /// Called when the map starts to load a style.
  final MapEventCallback<MapEventLoadingStarted>? onLoadingStarted;

  /// Called when the map has loaded its style and everything the view needs,
  /// once per style. On the web it is the first [onIdle] after the style
  /// changed.
  final MapEventCallback<MapEventLoadingFinished>? onLoadingFinished;

  /// Called when a source of the style changes, such as when its TileJSON
  /// arrives or its GeoJSON data is replaced. On the web only when a
  /// source's metadata, such as its TileJSON, arrives.
  final MapEventCallback<MapEventSourceChanged>? onSourceChanged;

  /// Called when a tile moves to another step of loading.
  ///
  /// Supported platforms: native only.
  final MapEventCallback<MapEventTile>? onTile;

  /// Called whenever the map rendered a frame. Native maps report the
  /// frame's statistics.
  final MapEventCallback<MapEventRenderFrame>? onRenderFrame;

  /// Called when the map finished rendering a view, partially while tiles
  /// still load, or fully.
  ///
  /// Supported platforms: native only.
  final MapEventCallback<MapEventRenderMap>? onRenderMap;

  /// Called when the map requests or loads glyphs of a font. Failures go to
  /// [onError].
  ///
  /// Supported platforms: native only.
  final MapEventCallback<MapEventGlyphs>? onGlyphs;

  /// Called when the map requests or loads a sprite. Failures go to
  /// [onError].
  ///
  /// Supported platforms: native only.
  final MapEventCallback<MapEventSprite>? onSprite;

  /// Called when the map stops or resumes rendering, see [paused].
  final MapEventCallback<MapEventRenderingChanged>? onRenderingChanged;

  /// Called when the map changed its size after its first layout.
  final MapEventCallback<MapEventResize>? onResize;

  /// Called when the browser takes the map's WebGL context away, for
  /// example after a GPU reset. The map is blank until [onContextRestored].
  ///
  /// Supported platforms: web only.
  final MapEventCallback<MapEventContextLost>? onContextLost;

  /// Called when the browser gives the map's WebGL context back.
  ///
  /// Supported platforms: web only.
  final MapEventCallback<MapEventContextRestored>? onContextRestored;

  /// Called when the map switched its projection, see
  /// [StyleController.setProjection].
  ///
  /// Supported platforms: web only, native maps always use mercator.
  final MapEventCallback<MapEventProjectionChanged>? onProjectionChanged;

  /// Declarative layers that get displayed.
  final List<Layer> layers;

  /// Whether the map stops rendering while it stays mounted, for example
  /// while it is in a tab that is not shown.
  ///
  /// A paused map keeps its style, camera, sources and cached tiles. Changes
  /// made while it is paused, such as camera moves or new layers, show once
  /// it resumes. Tiles load and camera animations advance only while the map
  /// renders, so a camera animation that runs when the map pauses ends at
  /// its target right away.
  ///
  /// The map also pauses on its own while it is hidden by an [IndexedStack]
  /// or a [Visibility] that keeps its state, or while [TickerMode] is
  /// disabled, as for a route that another route covers. Set [paused] for
  /// the cases Flutter does not report, such as a kept-alive page of a
  /// [PageView] or `TabBarView` while another page shows.
  /// [MapController.isRenderingPaused] and [onRenderingChanged] tell
  /// whether the map renders.
  ///
  /// On the web the browser already skips hidden maps, and the map only
  /// renders when it changes, so the flag has no effect there.
  final bool paused;

  @override
  State<MapLibreMap> createState() =>
      // ignore: no_logic_in_create_state
      MapLibrePlatform.instance.createWidgetState();
}

/// Callback that fires once the native MapLibre map has been created for a
/// [MapLibreMap] widget. It provides the [MapController] to the user.
///
/// {@category Basic}
typedef MapCreatedCallback = void Function(MapController controller);

/// Callback that fires once the map style has successfully loaded.
/// It provides the [StyleController] to the user.
///
/// {@category Basic}
/// {@category Style}
typedef StyleLoadedCallback = void Function(StyleController style);
