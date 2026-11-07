import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'shared/recording_style_backend.dart';

const _size = Size(800, 600);
const _center = Offset(400, 300);

/// A plate carrée world 1000 px wide, centered on the screen.
Geographic _toLngLat(Offset point) => Geographic(
  lon: (point.dx - _center.dx) * 360 / 1000,
  lat: (_center.dy - point.dy) * 360 / 1000,
);

Offset _toScreen(Geographic point) => Offset(
  _center.dx + point.lon * 1000 / 360,
  _center.dy - point.lat * 1000 / 360,
);

class _Camera implements GestureCameraSink {
  Offset panned = Offset.zero;

  @override
  void gestureStart() {}

  @override
  void gestureUpdate(GestureCameraUpdate update) {
    if (update.pans) panned += update.panTo! - update.panFrom!;
  }

  @override
  void gestureEnd({Velocity velocity = Velocity.zero}) {}

  @override
  void zoomBy(
    double levels,
    Offset around, {
    Duration duration = Duration.zero,
  }) {}
}

/// Renders the point features of the layers where [_toScreen] puts them.
class _State extends MapLibreMapState {
  _State(this.sink);

  final _Camera sink;

  /// Completes the queries once set, to test a slow query.
  Completer<void>? queryGate;

  @override
  StyleController? style;

  /// Hands out [style] and rebuilds, like the platforms once a style loaded.
  void loadStyle(StyleController style) => setState(() => this.style = style);

  /// The features of style layers, by layer id, with where they are on the
  /// screen.
  final styleFeatures = <String, List<(Offset, Object?)>>{};

  @override
  void initState() {
    super.initState();
    isInitialized = true;
  }

  @override
  GestureCameraSink get gestureCamera => sink;

  @override
  Geographic toLngLat(Offset screenLocation) => _toLngLat(screenLocation);

  @override
  Offset toScreenLocation(Geographic lngLat) => _toScreen(lngLat);

  @override
  Future<List<RenderedFeature>> queryRenderedFeatures(
    QueryGeometry geometry, {
    List<String>? layerIds,
    Expression<bool>? filter,
  }) async {
    await queryGate?.future;
    final rect = switch (geometry) {
      QueryGeometryRect(:final rect) => rect,
      QueryGeometryPoint(:final point) => Rect.fromCenter(
        center: point,
        width: 2,
        height: 2,
      ),
      _ => throw UnimplementedError(),
    };
    return [
      for (final (layerIndex, layer) in widget.layers.indexed.toList().reversed)
        if (layerIds!.contains(layer.getLayerId(layerIndex)))
          for (final (index, feature) in layer.list.indexed)
            if (feature.geometry case Point(:final position)
                when rect.contains(_toScreen(Geographic.from(position))))
              RenderedFeature(
                id: null,
                properties: {LayerManager.featureIndexProperty: index},
                layerId: layer.getLayerId(layerIndex),
              ),
      for (final layer in style?.layers.toList().reversed ?? <StyleLayer>[])
        if (layerIds!.contains(layer.id))
          for (final (position, id)
              in styleFeatures[layer.id] ?? const <(Offset, Object?)>[])
            if (rect.contains(position))
              RenderedFeature(id: id, properties: const {}, layerId: layer.id),
    ];
  }

  @override
  Widget buildPlatformWidget(BuildContext context) => const SizedBox.expand();

  // The other controller calls are not under test.
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Style implements StyleController {
  _Style() {
    final sources = StyleSources(_backend, layers: () => layers);
    layers = StyleLayers(_backend, sources: sources);
  }

  final _backend = RecordingStyleBackend();

  @override
  late final StyleLayers layers;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Platform extends MapLibrePlatform with MockPlatformInterfaceMixin {
  final camera = _Camera();
  late _State state;

  @override
  MapLibreMapState createWidgetState() => state = _State(camera);
}

class _PointLayer extends Layer<Feature<Point>> {
  const _PointLayer({
    required super.list,
    super.draggable,
    super.onDragStart,
    super.onDrag,
    super.onDragEnd,
    super.onClick,
    super.onEnter,
    super.onLeave,
  });

  @override
  StyleLayer createStyleLayer(int index) =>
      CircleStyleLayer(id: getLayerId(index), sourceId: getSourceId(index));
}

Feature<Point> _point(double lon, double lat) => Feature(
  geometry: Point(Geographic(lon: lon, lat: lat)),
);

void main() {
  late _Platform platform;
  late List<(String, LayerFeatureEvent)> drags;
  late List<MapEvent> mapEvents;

  setUp(() {
    platform = _Platform();
    MapLibrePlatform.instance = platform;
    drags = [];
    mapEvents = [];
  });

  Future<void> pumpMap(WidgetTester tester, List<Layer> layers) async {
    tester.view
      ..physicalSize = _size
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: MapLibreMap(
          layers: layers,
          onDragStart: mapEvents.add,
          onDrag: mapEvents.add,
          onDragEnd: mapEvents.add,
        ),
      ),
    );
  }

  _PointLayer draggable(List<Feature<Point>> list) => _PointLayer(
    list: list,
    draggable: true,
    onDragStart: (event) => drags.add(('start', event)),
    onDrag: (event) => drags.add(('drag', event)),
    onDragEnd: (event) => drags.add(('end', event)),
  );

  Future<void> drag(WidgetTester tester, Offset from, Offset by) async {
    final gesture = await tester.startGesture(from);
    for (var i = 0; i < 10; i++) {
      await gesture.moveBy(by / 10);
      await tester.pump(const Duration(milliseconds: 16));
    }
    await gesture.up();
    await tester.pumpAndSettle();
  }

  testWidgets('a drag on a feature moves it instead of the map', (
    tester,
  ) async {
    await pumpMap(tester, [
      draggable([_point(0, 0), _point(36, 0)]),
    ]);
    // Grab the second point 5 px left of its center.
    await drag(tester, const Offset(495, 300), const Offset(0, 100));
    expect(platform.camera.panned, Offset.zero);
    expect(drags.first.$1, 'start');
    expect(drags.first.$2.index, 1);
    expect(drags.first.$2.screenPoint, const Offset(500, 300));
    expect(drags.where((d) => d.$1 == 'drag'), isNotEmpty);
    final (kind, end) = drags.last;
    expect(kind, 'end');
    expect(end.index, 1);
    // The point keeps its offset from the pointer.
    expect(end.screenPoint, const Offset(500, 400));
    expect(end.point.lon, closeTo(36, 1e-9));
    expect(end.point.lat, closeTo(-36, 1e-9));
    final moved = end.geometry as Point;
    expect(moved.position.x, closeTo(36, 1e-9));
    expect(moved.position.y, closeTo(-36, 1e-9));
    // The map callbacks see the drag too, already prevented.
    final start = mapEvents.first as MapEventDragStart;
    expect(start.defaultPrevented, isTrue);
    expect(mapEvents.last, isA<MapEventDragEnd>());
  });

  testWidgets('a drag beside the features pans the map', (tester) async {
    await pumpMap(tester, [
      draggable([_point(0, 0)]),
    ]);
    await drag(tester, const Offset(200, 300), const Offset(-100, 0));
    expect(drags, isEmpty);
    expect(platform.camera.panned.dx, lessThan(-50));
    expect((mapEvents.first as MapEventDragStart).defaultPrevented, isFalse);
  });

  testWidgets('of features close together, the nearest is grabbed', (
    tester,
  ) async {
    // 10 px apart.
    await pumpMap(tester, [
      draggable([_point(0, 0), _point(3.6, 0)]),
    ]);
    await drag(tester, const Offset(408, 300), const Offset(0, 50));
    expect(drags.first.$2.index, 1);
  });

  testWidgets('the top layer wins', (tester) async {
    final below = <(String, LayerFeatureEvent)>[];
    await pumpMap(tester, [
      _PointLayer(
        list: [_point(0, 0)],
        draggable: true,
        onDrag: (event) => below.add(('drag', event)),
      ),
      draggable([_point(0, 0)]),
    ]);
    await drag(tester, _center, const Offset(0, 50));
    expect(below, isEmpty);
    expect(drags, isNotEmpty);
  });

  testWidgets('the top layer wins over a nearer feature below', (tester) async {
    final below = <(String, LayerFeatureEvent)>[];
    await pumpMap(tester, [
      _PointLayer(
        list: [_point(0, 0)],
        draggable: true,
        onDragStart: (event) => below.add(('start', event)),
      ),
      // 8 px right of the pointer.
      draggable([_point(2.88, 0)]),
    ]);
    await drag(tester, _center, const Offset(0, 50));
    expect(below, isEmpty);
    expect(drags.first.$1, 'start');
  });

  testWidgets('a layer is not draggable without the flag', (tester) async {
    await pumpMap(tester, [
      _PointLayer(list: [_point(0, 0)]),
    ]);
    await drag(tester, _center, const Offset(-100, 0));
    expect(platform.camera.panned.dx, lessThan(-50));
  });

  testWidgets('the map holds the pan while it looks for a feature', (
    tester,
  ) async {
    await pumpMap(tester, [
      draggable([_point(0, 0)]),
    ]);
    final gate = platform.state.queryGate = Completer<void>();
    final gesture = await tester.startGesture(_center);
    for (var i = 0; i < 5; i++) {
      await gesture.moveBy(const Offset(0, 10));
      await tester.pump(const Duration(milliseconds: 16));
    }
    expect(platform.camera.panned, Offset.zero);
    gate.complete();
    await tester.pump();
    for (var i = 0; i < 5; i++) {
      await gesture.moveBy(const Offset(0, 10));
      await tester.pump(const Duration(milliseconds: 16));
    }
    await gesture.up();
    await tester.pumpAndSettle();
    expect(platform.camera.panned, Offset.zero);
    expect(drags.last.$2.screenPoint, const Offset(400, 400));
  });

  testWidgets('a drag that ends while it looks for a feature ends after it', (
    tester,
  ) async {
    await pumpMap(tester, [
      draggable([_point(0, 0)]),
    ]);
    final gate = platform.state.queryGate = Completer<void>();
    final gesture = await tester.startGesture(_center);
    for (var i = 0; i < 5; i++) {
      await gesture.moveBy(const Offset(0, 10));
      await tester.pump(const Duration(milliseconds: 16));
    }
    await gesture.up();
    await tester.pump();
    expect(drags, isEmpty);
    expect(mapEvents, isEmpty);
    gate.complete();
    await tester.pumpAndSettle();
    expect(drags.map((d) => d.$1), ['start', 'drag', 'end']);
    expect(mapEvents.map((e) => e.runtimeType), [
      MapEventDragStart,
      MapEventDrag,
      MapEventDragEnd,
    ]);
    expect(platform.camera.panned, Offset.zero);

    // The next drag doesn't move the feature of the last one.
    drags.clear();
    platform.state.queryGate = null;
    await drag(tester, const Offset(200, 300), const Offset(-100, 0));
    expect(drags, isEmpty);
  });

  testWidgets('moves while it looks for a feature come after the start', (
    tester,
  ) async {
    await pumpMap(tester, [
      draggable([_point(0, 0)]),
    ]);
    final gate = platform.state.queryGate = Completer<void>();
    final gesture = await tester.startGesture(_center);
    for (var i = 0; i < 5; i++) {
      await gesture.moveBy(const Offset(0, 10));
      await tester.pump(const Duration(milliseconds: 16));
    }
    expect(mapEvents, isEmpty);
    gate.complete();
    await tester.pump();
    // The last move is reported right after the start.
    expect(mapEvents.map((e) => e.runtimeType), [
      MapEventDragStart,
      MapEventDrag,
    ]);
    expect(drags.map((d) => d.$1), ['start', 'drag']);
    expect(drags.last.$2.screenPoint, const Offset(400, 350));
    await gesture.up();
    await tester.pumpAndSettle();
    expect(drags.last.$1, 'end');
  });

  testWidgets('a drag that starts while the last one looks for a feature', (
    tester,
  ) async {
    await pumpMap(tester, [
      draggable([_point(0, 0)]),
    ]);
    final gate = platform.state.queryGate = Completer<void>();
    var gesture = await tester.startGesture(_center);
    for (var i = 0; i < 3; i++) {
      await gesture.moveBy(const Offset(0, 10));
      await tester.pump(const Duration(milliseconds: 16));
    }
    await gesture.up();
    await tester.pump(const Duration(milliseconds: 500));
    // The second drag goes beside the feature, so it pans.
    gesture = await tester.startGesture(const Offset(200, 300));
    for (var i = 0; i < 3; i++) {
      await gesture.moveBy(const Offset(-10, 0));
      await tester.pump(const Duration(milliseconds: 16));
    }
    gate.complete();
    await tester.pump();
    for (var i = 0; i < 5; i++) {
      await gesture.moveBy(const Offset(-10, 0));
      await tester.pump(const Duration(milliseconds: 16));
    }
    await gesture.up();
    await tester.pumpAndSettle();
    // The first query found the feature, but its drag was over.
    expect(drags, isEmpty);
    expect(platform.camera.panned.dx, lessThan(-30));
  });

  testWidgets('a feature removed during the drag stops it', (tester) async {
    final points = [_point(0, 0)];
    await pumpMap(tester, [draggable(points)]);
    final gesture = await tester.startGesture(_center);
    for (var i = 0; i < 5; i++) {
      await gesture.moveBy(const Offset(0, 10));
      await tester.pump(const Duration(milliseconds: 16));
    }
    expect(drags, isNotEmpty);
    await pumpMap(tester, [draggable([])]);
    drags.clear();
    await gesture.moveBy(const Offset(0, 10));
    await tester.pump(const Duration(milliseconds: 16));
    await gesture.up();
    await tester.pumpAndSettle();
    expect(drags, isEmpty);
  });

  group('layer events', () {
    _PointLayer interactive(List<Feature<Point>> list) => _PointLayer(
      list: list,
      onClick: (event) => drags.add(('click', event)),
      onEnter: (event) => drags.add(('enter', event)),
      onLeave: (event) => drags.add(('leave', event)),
    );

    testWidgets('a tap next to a point reports it to onClick', (tester) async {
      final clicks = <MapEventClick>[];
      tester.view
        ..physicalSize = _size
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MapLibreMap(
            layers: [
              interactive([_point(0, 0), _point(36, 0)]),
            ],
            onClick: clicks.add,
          ),
        ),
      );
      await tester.tapAt(const Offset(505, 303));
      // Past the double tap timeout.
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();
      expect(clicks, hasLength(1));
      expect(drags.map((d) => d.$1), ['click']);
      final click = drags.single.$2;
      expect(click.index, 1);
      expect(click.screenPoint, const Offset(505, 303));
      expect(click.geometry, _point(36, 0).geometry);
    });

    testWidgets('a tap beside the features reports no layer click', (
      tester,
    ) async {
      await pumpMap(tester, [
        interactive([_point(0, 0)]),
      ]);
      await tester.tapAt(const Offset(200, 300));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();
      expect(drags, isEmpty);
    });

    testWidgets('the mouse enters and leaves features', (tester) async {
      final moves = <MapEvent>[];
      tester.view
        ..physicalSize = _size
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MapLibreMap(
            layers: [
              interactive([_point(0, 0), _point(36, 0)]),
            ],
            onPointerMove: moves.add,
            onPointerLeave: moves.add,
          ),
        ),
      );
      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      addTearDown(mouse.removePointer);
      await mouse.addPointer(location: const Offset(200, 200));
      await tester.pump();
      for (final position in const [
        Offset(300, 300),
        _center,
        Offset(400.5, 300),
        Offset(500, 300),
        Offset(600, 300),
      ]) {
        await mouse.moveTo(position);
        await tester.pump();
      }
      expect(
        [for (final (kind, event) in drags) '$kind ${event.index}'],
        ['enter 0', 'leave 0', 'enter 1', 'leave 1'],
      );
      expect(drags[1].$2.screenPoint, const Offset(500, 300));
      expect(moves.whereType<MapEventPointerMove>(), hasLength(5));

      drags.clear();
      await mouse.moveTo(const Offset(500, 300));
      await tester.pump();
      await mouse.moveTo(const Offset(900, 300));
      await tester.pump();
      expect(drags.map((d) => d.$1), ['enter', 'leave']);
      expect(moves.last, isA<MapEventPointerLeave>());
    });

    testWidgets('a layer gets the feature index property once it has a '
        'callback', (tester) async {
      final layer = _PointLayer(list: [_point(0, 0)]);
      expect(layer.interactive, isFalse);
      expect(interactive([_point(0, 0)]).interactive, isTrue);
      expect(layer == interactive(layer.list), isFalse);
    });
  });

  group('style layer events', () {
    late List<String> events;
    late _Style style;

    setUp(() {
      events = [];
      style = _Style();
    });

    /// Loads style layers [ids] that report their events, bottom to top.
    Future<void> loadLayers(WidgetTester tester, List<String> ids) async {
      platform.state.loadStyle(style);
      await tester.pump();
      style.layers.load([
        for (final id in ids) {'id': id, 'type': 'circle', 'source': 's'},
      ]);
      for (final layer in style.layers) {
        String name(StyleLayerFeatureEvent event) =>
            '${layer.id} ${event.feature.id}';
        layer
          ..onClick = ((event) => events.add('click ${name(event)}'))
          ..onEnter = ((event) => events.add('enter ${name(event)}'))
          ..onLeave = ((event) => events.add('leave ${name(event)}'));
      }
      platform.state.styleFeatures.clear();
      // Setting the callbacks rebuilds the map.
      await tester.pump();
    }

    testWidgets('a tap reports the topmost feature of every layer under it', (
      tester,
    ) async {
      await pumpMap(tester, []);
      await loadLayers(tester, ['a', 'b', 'c']);
      platform.state.styleFeatures.addAll({
        'a': [(_center, 1), (_center, 2)],
        'b': [(_center, 3)],
        'c': [(const Offset(100, 100), 4)],
      });
      await tester.tapAt(_center);
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();
      expect(events, ['click b 3', 'click a 1']);

      // A removed layer reports no more taps.
      events.clear();
      await style.layers.remove('b');
      await tester.tapAt(_center);
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();
      expect(events, ['click a 1']);
    });

    testWidgets('the mouse enters and leaves features by id, and layers of '
        'features without one as a whole', (tester) async {
      await pumpMap(tester, []);
      await loadLayers(tester, ['a', 'b']);
      platform.state.styleFeatures.addAll({
        'a': [(const Offset(300, 300), 1), (const Offset(500, 300), 2)],
        'b': [(const Offset(300, 400), null), (const Offset(500, 400), null)],
      });
      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      addTearDown(mouse.removePointer);
      await mouse.addPointer(location: const Offset(200, 200));
      await tester.pump();
      for (final position in const [
        Offset(300, 300),
        Offset(500, 300),
        Offset(600, 300),
        Offset(300, 400),
        Offset(500, 400),
        Offset(500, 400.5),
      ]) {
        await mouse.moveTo(position);
        await tester.pump();
      }
      expect(events, [
        'enter a 1',
        'leave a 1',
        'enter a 2',
        'leave a 2',
        'enter b null',
      ]);

      events.clear();
      await mouse.moveTo(const Offset(900, 400));
      await tester.pump();
      expect(events, ['leave b null']);
    });
  });

  test('callbacks need the draggable flag', () {
    expect(
      () => _PointLayer(list: const [], onDragEnd: (_) {}),
      throwsAssertionError,
    );
  });
}
