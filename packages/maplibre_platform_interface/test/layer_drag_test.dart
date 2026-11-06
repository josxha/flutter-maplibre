import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

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
    final rect = (geometry as QueryGeometryRect).rect;
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
    ];
  }

  @override
  Widget buildPlatformWidget(BuildContext context) => const SizedBox.expand();

  // The other controller calls are not under test.
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
  late List<(String, LayerDragEvent)> drags;
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
    final below = <(String, LayerDragEvent)>[];
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

  test('callbacks need the draggable flag', () {
    expect(
      () => _PointLayer(list: const [], onDragEnd: (_) {}),
      throwsAssertionError,
    );
  });
}
