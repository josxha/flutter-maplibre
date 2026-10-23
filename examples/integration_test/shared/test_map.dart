import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

/// A style without any network resources, so a map renders offline.
final String offlineStyle = jsonEncode({
  'version': 8,
  'sources': <String, Object>{},
  'layers': [
    {
      'id': 'background',
      'type': 'background',
      'paint': {'background-color': '#dddddd'},
    },
  ],
});

/// Options of a map at [center] that renders without the network.
MapOptions offlineOptions({
  Geographic center = const Geographic(lon: 0, lat: 0),
  double zoom = 4,
  double bearing = 0,
  double pitch = 0,
  double minZoom = 0,
  double maxZoom = 22,
  MapGestures gestures = const MapGestures.all(),
}) => MapOptions(
  initStyle: offlineStyle,
  initCenter: center,
  initZoom: zoom,
  initBearing: bearing,
  initPitch: pitch,
  minZoom: minZoom,
  maxZoom: maxZoom,
  gestures: gestures,
);

/// The default timeout of the `waitFor…` helpers.
const Duration defaultTimeout = Duration(seconds: 15);

/// A map shown by [pumpMap], with its controller, style and every event it
/// reported.
class TestMap {
  TestMap._(this.tester, this.controller, this.events);

  final WidgetTester tester;
  final MapController controller;
  final List<MapEvent> events;

  /// The style of the map, replaced whenever a style loads.
  StyleController get style => controller.style!;

  Finder get finder => find.byType(MapLibreMap);

  /// The size of the map in logical pixels.
  Size get size => tester.getSize(finder);

  /// The center of the map in map coordinates.
  Offset get center => size.center(Offset.zero);

  /// Converts a point of the map to a global position, for gestures.
  Offset toGlobal(Offset local) => tester.getTopLeft(finder) + local;

  /// Pumps frames until [condition] holds, and fails after [timeout] with
  /// the message that [reason] returns then.
  Future<void> pumpUntil(
    bool Function() condition, {
    required String Function() reason,
    Duration timeout = defaultTimeout,
  }) async {
    final deadline = DateTime.now().add(timeout);
    while (!condition()) {
      if (DateTime.now().isAfter(deadline)) fail('Timed out: ${reason()}');
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  /// Pumps frames until [future] completes, and fails after [timeout].
  Future<T> pumpFuture<T>(
    Future<T> future, {
    required String reason,
    Duration timeout = defaultTimeout,
  }) async {
    var done = false;
    late T result;
    Object? error;
    StackTrace? stackTrace;
    unawaited(
      future
          .then(
            (value) => result = value,
            onError: (Object e, StackTrace s) {
              error = e;
              stackTrace = s;
            },
          )
          .whenComplete(() => done = true),
    );
    await pumpUntil(() => done, reason: () => reason, timeout: timeout);
    if (error case final Object error) {
      Error.throwWithStackTrace(error, stackTrace!);
    }
    return result;
  }

  /// Waits for an event of type [T] that arrives after [since] events, and
  /// that matches [where].
  Future<T> waitForEvent<T extends MapEvent>({
    int since = 0,
    bool Function(T event)? where,
    Duration timeout = defaultTimeout,
  }) async {
    T? match() => events
        .skip(since)
        .whereType<T>()
        .where((event) => where?.call(event) ?? true)
        .firstOrNull;
    await pumpUntil(
      () => match() != null,
      reason: () => 'waiting for $T, got ${events.skip(since).toList()}',
      timeout: timeout,
    );
    return match()!;
  }

  /// Waits until the camera matches [matches], and returns it.
  Future<MapCamera> waitForCamera(
    bool Function(MapCamera camera) matches, {
    Duration timeout = defaultTimeout,
  }) async {
    await pumpUntil(
      () => matches(controller.getCamera()),
      reason: () => 'camera never matched, last: ${controller.getCamera()}',
      timeout: timeout,
    );
    return controller.getCamera();
  }

  /// Waits until the frame on screen shows a camera that [matches]. Screen
  /// locations and [MapController.camera] follow that frame.
  Future<void> waitForFrame(
    bool Function(MapCamera camera) matches, {
    Duration timeout = defaultTimeout,
  }) async {
    await pumpUntil(
      () => controller.camera != null && matches(controller.camera!),
      reason: () => 'frame never matched, last: ${controller.camera}',
      timeout: timeout,
    );
    await tester.pump();
  }

  /// Waits until the frame on screen shows the latest camera, which screen
  /// locations then follow.
  Future<void> waitForLatestFrame({Duration timeout = defaultTimeout}) =>
      waitForFrame((shown) {
        final latest = controller.getCamera();
        return (shown.center.lon - latest.center.lon).abs() < 1e-9 &&
            (shown.center.lat - latest.center.lat).abs() < 1e-9 &&
            (shown.zoom - latest.zoom).abs() < 1e-9 &&
            (shown.bearing - latest.bearing).abs() < 1e-9 &&
            (shown.pitch - latest.pitch).abs() < 1e-9;
      }, timeout: timeout);

  /// Waits until a feature query at [point] finds what [matches] accepts.
  /// Rendering is asynchronous, so a feature appears a few frames after its
  /// source or layer was added.
  Future<List<RenderedFeature>> waitForFeatures(
    Offset point,
    bool Function(List<RenderedFeature> features) matches, {
    List<String>? layerIds,
    Duration timeout = defaultTimeout,
  }) async {
    final deadline = DateTime.now().add(timeout);
    while (true) {
      final features = await controller.featuresAtPoint(
        point,
        layerIds: layerIds,
      );
      if (matches(features)) return features;
      if (DateTime.now().isAfter(deadline)) {
        fail('Features at $point never matched, last: $features');
      }
      await tester.pump(const Duration(milliseconds: 100));
    }
  }
}

/// Shows a [MapLibreMap] with [options] and waits until its style has loaded.
Future<TestMap> pumpMap(
  WidgetTester tester, {
  MapOptions? options,
  List<Layer> layers = const [],
  List<Widget> children = const [],
}) async {
  final events = <MapEvent>[];
  final controller = Completer<MapController>();
  final style = Completer<StyleController>();
  await tester.pumpWidget(
    MapApp(
      options: options ?? offlineOptions(),
      layers: layers,
      onMapCreated: controller.complete,
      onStyleLoaded: (style_) {
        if (!style.isCompleted) style.complete(style_);
      },
      onEvent: events.add,
      children: children,
    ),
  );
  final map = TestMap._(
    tester,
    await controller.future.timeout(defaultTimeout),
    events,
  );
  await style.future.timeout(defaultTimeout);
  // Let the first frame reach Flutter, so projections follow the camera.
  await map.pumpUntil(
    () => map.controller.camera != null,
    reason: () => 'waiting for the first frame',
  );
  // Rebuild the widgets over the map with that camera.
  await tester.pump();
  return map;
}

/// The app that [pumpMap] shows: a full-screen map.
class MapApp extends StatelessWidget {
  const MapApp({
    required this.options,
    this.layers = const [],
    this.onMapCreated,
    this.onStyleLoaded,
    this.onEvent,
    this.children = const [],
    super.key,
  });

  final MapOptions options;
  final List<Layer> layers;
  final MapCreatedCallback? onMapCreated;
  final StyleLoadedCallback? onStyleLoaded;
  final MapEventCallback? onEvent;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: MapLibreMap(
        options: options,
        layers: layers,
        onMapCreated: onMapCreated,
        onStyleLoaded: onStyleLoaded,
        onEvent: onEvent,
        children: children,
      ),
    ),
  );
}

/// A GeoJSON feature collection of [features].
String featureCollection(List<Feature> features) =>
    FeatureCollection(features).toText();

/// The ID of [feature] as text. Web and native report numeric IDs as numbers
/// or as text.
String? idOf(RenderedFeature feature) => feature.id?.toString();
