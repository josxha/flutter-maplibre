import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_platform_interface/src/layer/annotation_manager.dart';

import 'shared/recording_style_backend.dart';

/// A layer of another type than [_TestLayer], which layers without an id
/// match by.
class _HeatmapLayer extends _TestLayer {
  const _HeatmapLayer({required super.list}) : super(type: 'heatmap');
}

/// A style that runs batches and records the images of the annotations.
class _FakeStyle implements StyleController {
  _FakeStyle(this._layers, this._sources);

  final StyleLayers Function() _layers;
  final StyleSources Function() _sources;
  final images = <String>[];
  int batches = 0;

  /// Holds back the images of icons until it completes, if set.
  Completer<void>? imageGate;

  @override
  StyleLayers get layers => _layers();

  @override
  StyleSources get sources => _sources();

  @override
  void batch(void Function() updates) {
    batches++;
    updates();
  }

  @override
  Future<void> addImageFromIconData({
    required String id,
    required IconData iconData,
    double size = 48,
    Color color = const Color(0xFF000000),
    StyleImageOptions options = const StyleImageOptions(),
  }) async {
    if (imageGate case final gate?) await gate.future;
    images.add('add $id');
  }

  @override
  Future<void> addImage(
    String id,
    Uint8List bytes, {
    double pixelRatio = 1,
    StyleImageOptions options = const StyleImageOptions(),
  }) async => images.add('add $id');

  @override
  Future<void> removeImage(String id) async => images.add('remove $id');

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _TestLayer extends Layer<Feature<Point>> {
  const _TestLayer({
    required super.list,
    super.id,
    super.anchor,
    this.radius = 1,
    this.type = 'circle',
    this.sourceLayerId,
    this.testIcon,
  });

  final num radius;
  final String type;
  final String? sourceLayerId;
  final MarkerIcon? testIcon;

  @override
  MarkerIcon? get icon => testIcon;

  @override
  StyleLayer createStyleLayer({required String id, required String sourceId}) =>
      switch (type) {
        'circle' => CircleStyleLayer(
          id: id,
          sourceId: sourceId,
          sourceLayerId: sourceLayerId,
          minZoom: minZoom,
          maxZoom: maxZoom,
          radius: Expression.literal(radius),
        ),
        'symbol' => SymbolStyleLayer(id: id, sourceId: sourceId),
        _ => HeatmapStyleLayer(id: id, sourceId: sourceId),
      };

  @override
  bool operator ==(Object other) =>
      other is _TestLayer &&
      super == other &&
      radius == other.radius &&
      type == other.type &&
      sourceLayerId == other.sourceLayerId;

  @override
  int get hashCode => Object.hash(super.hashCode, radius, type, sourceLayerId);
}

void main() {
  late RecordingStyleBackend backend;
  late StyleSources sources;
  late StyleLayers layers;

  setUp(() {
    backend = RecordingStyleBackend();
    sources = StyleSources(backend, layers: () => layers);
    layers = StyleLayers(backend, sources: sources);
  });

  List<String> ids() => layers.map((layer) => layer.id).toList();

  group('AnnotationManager', () {
    late _FakeStyle style;
    late List<String> images;

    setUp(() {
      style = _FakeStyle(() => layers, () => sources);
      images = style.images;
    });

    const point = Feature<Point>(geometry: Point(Geographic(lon: 0, lat: 0)));
    const other = Feature<Point>(geometry: Point(Geographic(lon: 1, lat: 1)));
    const list = [point];

    AnnotationManager attached(List<Layer> layers) =>
        AnnotationManager(layers)..attach(style);

    List<String> sourceIds() => sources.map((source) => source.id).toList();

    test('adds sources and layers in one batch, named by type', () {
      attached(const [
        _TestLayer(list: list),
        _TestLayer(list: list, type: 'heatmap'),
        _TestLayer(list: list),
      ]);
      expect(style.batches, 1);
      expect(ids(), [
        'maplibre-circle-1',
        'maplibre-heatmap-1',
        'maplibre-circle-2',
      ]);
      expect(sourceIds(), ids());
    });

    test('waits for a style and adds its layers to every style', () {
      final manager = AnnotationManager(const [
        _TestLayer(list: list, id: 'a'),
        _TestLayer(list: list),
      ]);
      expect(backend.calls, isEmpty);
      // The layers change while no style is loaded.
      manager.update(const [
        _TestLayer(list: [other], id: 'a'),
        _TestLayer(list: list),
      ]);
      manager.attach(style);
      expect(ids(), ['a', 'maplibre-circle-1']);
      expect(backend.calls.first, 'addSource a');

      // Another style loads.
      manager.detach();
      layers.dispose();
      sources.dispose();
      backend.calls.clear();
      manager.attach(style);
      expect(ids(), ['a', 'maplibre-circle-1']);
      expect(sourceIds(), ['a', 'maplibre-circle-1']);
      expect(backend.calls, [
        'addSource a',
        'addSource maplibre-circle-1',
        'addLayer maplibre-circle-1 below null',
        'addLayer a below maplibre-circle-1',
      ]);
    });

    test('does nothing when nothing changed', () {
      final manager = attached(const [_TestLayer(list: list)]);
      backend.calls.clear();
      manager.update(const [_TestLayer(list: list)]);
      expect(backend.calls, isEmpty);
    });

    test('sets only the changed properties, in place', () {
      final manager = attached(const [
        _TestLayer(list: list),
        _TestLayer(list: list),
      ]);
      final layer = layers['maplibre-circle-1'];
      backend.calls.clear();
      manager.update(const [
        _TestLayer(list: list, radius: 2),
        _TestLayer(list: list),
      ]);
      expect(backend.calls, ['setPaint maplibre-circle-1 circle-radius 2']);
      expect(layers['maplibre-circle-1'], same(layer));
      expect(ids(), ['maplibre-circle-1', 'maplibre-circle-2']);
    });

    test('updates only the data when only the features changed', () {
      final manager = attached(const [_TestLayer(list: list)]);
      backend.calls.clear();
      manager.update(const [
        _TestLayer(list: [other]),
      ]);
      expect(
        backend.calls.single,
        startsWith('setGeoJsonData maplibre-circle-1'),
      );
    });

    test('updates a list that grew in place', () {
      final features = [point];
      final manager = attached([_TestLayer(list: features)]);
      backend.calls.clear();
      features.add(other);
      manager.update([_TestLayer(list: features)]);
      expect(
        backend.calls.single,
        startsWith('setGeoJsonData maplibre-circle-1'),
      );
      backend.calls.clear();
      manager.update([_TestLayer(list: features)]);
      expect(backend.calls, isEmpty);
    });

    test('re-creates a layer whose type changed, at its position', () {
      final manager = attached(const [
        _TestLayer(list: list, id: 'a'),
        _TestLayer(list: list, id: 'b'),
        _TestLayer(list: list, id: 'c'),
      ]);
      backend.calls.clear();
      manager.update(const [
        _TestLayer(list: list, id: 'a'),
        _TestLayer(list: list, id: 'b', type: 'heatmap'),
        _TestLayer(list: list, id: 'c'),
      ]);
      expect(backend.calls, ['removeLayer b', 'addLayer b below c']);
      expect(ids(), ['a', 'b', 'c']);
      expect(layers['b'], isA<HeatmapStyleLayer>());

      // The new layer is the one that updates from now on.
      backend.calls.clear();
      manager.update(const [
        _TestLayer(list: list, id: 'a'),
        _TestLayer(list: list, id: 'b', type: 'heatmap'),
        _TestLayer(list: list, id: 'c'),
      ]);
      expect(backend.calls, isEmpty);
    });

    test('re-creates a layer whose source layer changed', () {
      final manager = attached(const [_TestLayer(list: list)]);
      backend.calls.clear();
      manager.update(const [_TestLayer(list: list, sourceLayerId: 'a')]);
      expect(backend.calls, [
        'removeLayer maplibre-circle-1',
        'addLayer maplibre-circle-1 below null',
      ]);
    });

    test('adds new layers on top and removes left-over ones', () {
      final manager = attached(const [_TestLayer(list: list)]);
      backend.calls.clear();
      manager.update(const [_TestLayer(list: list), _TestLayer(list: list)]);
      expect(backend.calls, [
        'addSource maplibre-circle-2',
        'addLayer maplibre-circle-2 below null',
      ]);
      backend.calls.clear();
      manager.update(const []);
      expect(backend.calls, [
        'removeLayer maplibre-circle-1',
        'removeSource maplibre-circle-1',
        'removeLayer maplibre-circle-2',
        'removeSource maplibre-circle-2',
      ]);
      expect(layers, isEmpty);
      expect(sources, isEmpty);
    });

    test('moves the style layers of reordered layers', () {
      final manager = attached(const [
        _TestLayer(list: list, id: 'a'),
        _TestLayer(list: list, id: 'b'),
        _TestLayer(list: list, id: 'c'),
      ]);
      final a = layers['a'];
      backend.calls.clear();
      manager.update(const [
        _TestLayer(list: list, id: 'c'),
        _TestLayer(list: list, id: 'a'),
        _TestLayer(list: list, id: 'b'),
      ]);
      expect(backend.calls, ['moveLayer c below a']);
      expect(ids(), ['c', 'a', 'b']);
      expect(layers['a'], same(a));

      backend.calls.clear();
      manager.update(const [
        _TestLayer(list: list, id: 'b'),
        _TestLayer(list: list, id: 'a'),
        _TestLayer(list: list, id: 'c'),
      ]);
      expect(ids(), ['b', 'a', 'c']);
      expect(backend.calls, everyElement(startsWith('moveLayer')));
    });

    test('a layer inserted at the front goes below the others', () {
      final manager = attached(const [
        _TestLayer(list: list, id: 'a'),
        _TestLayer(list: list),
      ]);
      backend.calls.clear();
      manager.update(const [
        _HeatmapLayer(list: [other]),
        _TestLayer(list: list, id: 'a'),
        _TestLayer(list: list),
      ]);
      expect(backend.calls, [
        'addSource maplibre-heatmap-1',
        'addLayer maplibre-heatmap-1 below a',
      ]);
      expect(ids(), ['maplibre-heatmap-1', 'a', 'maplibre-circle-1']);
    });

    test('layers without an id match by type, in order', () {
      final manager = attached(const [
        _TestLayer(list: list),
        _HeatmapLayer(list: list),
      ]);
      final circle = manager.entries.first;
      manager.update(const [
        _HeatmapLayer(list: list),
        _TestLayer(list: [other]),
      ]);
      expect(manager.entries.last, same(circle));
      expect(ids(), ['maplibre-heatmap-1', 'maplibre-circle-1']);
    });

    test('a layer with an id keeps it for its style layer and source', () {
      final manager = attached(const [_TestLayer(list: list, id: 'pins')]);
      expect(ids(), ['pins']);
      expect(sourceIds(), ['pins']);
      expect(manager['pins']!.layer.id, 'pins');
    });

    test('rejects an id that the style or another layer uses', () {
      sources.load({
        'src': {'type': 'geojson', 'data': 'https://example.com/a.json'},
      });
      layers.load([
        {'id': 'water', 'type': 'circle', 'source': 'src'},
      ]);
      final manager = attached(const [_TestLayer(list: list)]);
      backend.calls.clear();
      expect(
        () => manager.update(const [_TestLayer(list: list, id: 'water')]),
        throwsA(
          isA<ArgumentError>().having(
            (error) => error.invalidValue,
            'invalidValue',
            'water',
          ),
        ),
      );
      expect(
        () => manager.update(const [_TestLayer(list: list, id: 'src')]),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => manager.update(const [
          _TestLayer(list: list, id: 'maplibre-circle-1'),
          _TestLayer(list: list),
        ]),
        throwsA(isA<ArgumentError>()),
      );
      // Nothing changed.
      expect(backend.calls, isEmpty);
      expect(ids(), ['water', 'maplibre-circle-1']);
    });

    test('rejects the ids of the dragged feature', () {
      final manager = attached(const []);
      for (final id in ['maplibre-drag-layer', 'maplibre-drag-source']) {
        expect(
          () => manager.update([_TestLayer(list: list, id: id)]),
          throwsA(isA<ArgumentError>()),
        );
      }
      expect(layers, isEmpty);
    });

    test('adds a layer the map rejected again, and gives up its id', () async {
      final errors = <FlutterErrorDetails>[];
      final onError = FlutterError.onError;
      FlutterError.onError = errors.add;
      addTearDown(() => FlutterError.onError = onError);
      backend.rejectLayerId = 'a';
      final manager = attached(const [_TestLayer(list: list, id: 'a')]);
      await pumpEventQueue();
      expect(errors.single.exception, isA<StateError>());
      expect(layers['a'], isNull);
      // The id no longer counts as the annotation's style layer.
      backend.rejectLayerId = null;
      await layers.add(CircleStyleLayer(id: 'a', sourceId: 'a'));
      await layers.remove('a');

      manager.update(const [
        _TestLayer(list: [other], id: 'a'),
      ]);
      expect(ids(), ['a']);
      expect(() => layers.remove('a'), throwsStateError);
    });

    test('reserves the ids that start with maplibre-', () {
      const layer = _TestLayer(list: list, id: 'maplibre-a');
      final manager = attached(const []);
      expect(() => manager.update(const [layer]), throwsArgumentError);
    });

    test('gives a generated id that a new style uses another number', () {
      final errors = <FlutterErrorDetails>[];
      final onError = FlutterError.onError;
      FlutterError.onError = errors.add;
      addTearDown(() => FlutterError.onError = onError);
      final manager = attached(const [_TestLayer(list: list)]);
      expect(ids(), ['maplibre-circle-1']);
      manager.detach();
      layers.dispose();
      sources.dispose();
      layers.load([
        {'id': 'maplibre-circle-1', 'type': 'background'},
      ]);
      manager.attach(style);
      expect(errors, isEmpty);
      expect(manager.entries.single.id, 'maplibre-circle-2');
      expect(ids(), ['maplibre-circle-1', 'maplibre-circle-2']);
      expect(sourceIds(), ['maplibre-circle-2']);
    });

    test('rejects duplicate ids', () {
      expect(
        () => AnnotationManager(const [
          _TestLayer(list: list, id: 'a'),
          _TestLayer(list: list, id: 'a'),
        ]),
        throwsA(isA<FlutterError>()),
      );
    });

    test('leaves out a layer whose id a new style uses, and reports it', () {
      final errors = <FlutterErrorDetails>[];
      final onError = FlutterError.onError;
      FlutterError.onError = errors.add;
      addTearDown(() => FlutterError.onError = onError);
      layers.load([
        {'id': 'pins', 'type': 'background'},
      ]);
      final manager = attached(const [
        _TestLayer(list: list, id: 'pins'),
        _TestLayer(list: list),
      ]);
      expect(errors.single.exception, isA<ArgumentError>());
      expect(ids(), ['pins', 'maplibre-circle-1']);
      expect(layers['pins'], isA<BackgroundStyleLayer>());
      // Taps and the mouse go to the style's layer of that id.
      expect(manager.owns('pins'), isFalse);
      expect(manager.owns('maplibre-circle-1'), isTrue);
      // Its changes stay off the map.
      backend.calls.clear();
      manager.update(const [
        _TestLayer(list: [other], id: 'pins'),
        _TestLayer(list: list),
      ]);
      expect(backend.calls, isEmpty);
    });

    group('anchors', () {
      setUp(() {
        sources.load({
          'src': {'type': 'geojson', 'data': 'https://example.com/a.json'},
        });
        layers.load([
          {'id': 'background', 'type': 'background'},
          {'id': 'water', 'type': 'circle', 'source': 'src'},
          {'id': 'labels', 'type': 'circle', 'source': 'src'},
        ]);
      });

      test('place layers among the layers of the style', () {
        attached(const [
          _TestLayer(list: list, id: 'a', anchor: .below('labels')),
          _TestLayer(list: list, id: 'b'),
          _TestLayer(list: list, id: 'c', anchor: .bottom()),
          _TestLayer(list: list, id: 'd', anchor: .above('background')),
          _TestLayer(list: list, id: 'e', anchor: .below('labels')),
          _TestLayer(list: list, id: 'f', anchor: .bottom()),
        ]);
        expect(ids(), [
          'c',
          'f',
          'background',
          'd',
          'water',
          'a',
          'e',
          'labels',
          'b',
        ]);
      });

      test('move a layer whose anchor changed', () {
        final manager = attached(const [
          _TestLayer(list: list, id: 'a'),
          _TestLayer(list: list, id: 'b'),
        ]);
        backend.calls.clear();
        manager.update(const [
          _TestLayer(list: list, id: 'a', anchor: .below('water')),
          _TestLayer(list: list, id: 'b'),
        ]);
        expect(backend.calls, ['moveLayer a below water']);
        expect(ids(), ['background', 'a', 'water', 'labels', 'b']);
      });

      test('move a layer to an anchor next to where it is', () {
        final manager = attached(const [_TestLayer(list: list, id: 'a')]);
        manager.update(const [
          _TestLayer(list: list, id: 'a', anchor: .above('water')),
        ]);
        expect(ids(), ['background', 'water', 'a', 'labels']);
        manager.update(const [
          _TestLayer(list: list, id: 'a', anchor: .bottom()),
        ]);
        expect(ids(), ['a', 'background', 'water', 'labels']);
        manager.update(const [
          _TestLayer(list: list, id: 'a', anchor: .below('labels')),
        ]);
        expect(ids(), ['background', 'water', 'a', 'labels']);
      });

      test('keep when the app adds layers later, without a rebuild', () async {
        final print = debugPrint;
        debugPrint = (message, {wrapWidth}) {};
        addTearDown(() => debugPrint = print);
        attached(const [
          _TestLayer(list: list, id: 'a'),
          _TestLayer(list: list, id: 'b', anchor: .below('divider')),
        ]);
        expect(ids(), ['background', 'water', 'labels', 'a', 'b']);
        await layers.add(CircleStyleLayer(id: 'divider', sourceId: 'src'));
        await pumpEventQueue();
        expect(ids(), ['background', 'water', 'labels', 'b', 'divider', 'a']);
      });

      test('a missing anchor puts the layer on top, with a warning', () {
        final printed = <String?>[];
        final print = debugPrint;
        debugPrint = (message, {wrapWidth}) => printed.add(message);
        addTearDown(() => debugPrint = print);
        final manager = attached(const [
          _TestLayer(list: list, id: 'a', anchor: .below('missing')),
          _TestLayer(list: list, id: 'b'),
          // The anchor names a layer of the list, not of the style.
          _TestLayer(list: list, id: 'c', anchor: .above('a')),
        ]);
        expect(ids(), ['background', 'water', 'labels', 'a', 'b', 'c']);
        expect(printed, hasLength(2));
        expect(printed.first, contains('"missing"'));
        // It warns once.
        manager.update(const [
          _TestLayer(list: [other], id: 'a', anchor: .below('missing')),
          _TestLayer(list: list, id: 'b'),
          _TestLayer(list: list, id: 'c', anchor: .above('a')),
        ]);
        expect(printed, hasLength(2));
      });

      test('a layer of the app above the layers goes below them', () async {
        final manager = attached(const [
          _TestLayer(list: list, id: 'a'),
          _TestLayer(list: list, id: 'b'),
        ]);
        await layers.add(CircleStyleLayer(id: 'app', sourceId: 'src'));
        backend.calls.clear();
        manager.update(const [
          _TestLayer(list: [other], id: 'a'),
          _TestLayer(list: list, id: 'b'),
        ]);
        expect(ids(), ['background', 'water', 'labels', 'app', 'a', 'b']);
      });
    });

    group('style layers of the annotations', () {
      late AnnotationManager manager;

      setUp(() {
        manager = attached(const [
          _TestLayer(list: list, id: 'a'),
          _TestLayer(list: list, id: 'b'),
        ]);
      });

      test('cannot be removed or moved through the style', () {
        expect(
          () => layers.remove('a'),
          throwsA(
            isA<StateError>().having(
              (error) => error.message,
              'message',
              contains('MapLibreMap.layers'),
            ),
          ),
        );
        expect(() => layers.move('a'), throwsA(isA<StateError>()));
        expect(() => layers['b']!.moveBelow('a'), throwsA(isA<StateError>()));
        expect(ids(), ['a', 'b']);
      });

      test('warn about changes through the style', () {
        final printed = <String?>[];
        final print = debugPrint;
        debugPrint = (message, {wrapWidth}) => printed.add(message);
        addTearDown(() => debugPrint = print);
        layers['a']!
          ..minZoom = 3
          ..maxZoom = 9;
        expect(printed.single, contains('MapLibreMap.layers'));
        // The manager changes them without a warning.
        manager.update(const [
          _TestLayer(list: list, id: 'a', radius: 4),
          _TestLayer(list: list, id: 'b'),
        ]);
        expect(printed, hasLength(1));
      });

      test('warn about writes to their sources', () async {
        final printed = <String?>[];
        final print = debugPrint;
        debugPrint = (message, {wrapWidth}) => printed.add(message);
        addTearDown(() => debugPrint = print);
        await sources.updateGeoJsonData(
          'a',
          GeoJsonData.featureCollection(FeatureCollection(const [])),
        );
        expect(printed.single, contains('MapLibreMap.layers'));
        // The manager writes them without a warning.
        manager.update(const [
          _TestLayer(list: [other], id: 'a'),
          _TestLayer(list: list, id: 'b'),
        ]);
        expect(printed, hasLength(1));
      });

      test('can be removed once they left the list', () async {
        manager.update(const [_TestLayer(list: list, id: 'b')]);
        await sources.add(const GeoJsonSource.url(id: 's', url: 'https://s'));
        await layers.add(CircleStyleLayer(id: 'a', sourceId: 's'));
        await layers.remove('a');
        expect(ids(), ['b']);
      });
    });

    group('icons', () {
      const pin = MarkerIcon.iconData(IconData(0xe55f), size: 24);
      const flag = MarkerIcon.iconData(IconData(0xe153));

      String? imageOf(String id) =>
          (layers[id]! as SymbolStyleLayer).iconImage?.toJson() as String?;

      test('are added once for the layers that share them', () async {
        attached(const [
          _TestLayer(list: list, id: 'a', type: 'symbol', testIcon: pin),
          _TestLayer(list: list, id: 'b', type: 'symbol', testIcon: pin),
          _TestLayer(list: list, id: 'c', type: 'symbol', testIcon: flag),
        ]);
        await pumpEventQueue();
        expect(images, ['add maplibre-icon-1', 'add maplibre-icon-2']);
        expect(imageOf('a'), 'maplibre-icon-1');
        expect(imageOf('b'), 'maplibre-icon-1');
        expect(imageOf('c'), 'maplibre-icon-2');
      });

      test('are removed once no layer shows them', () async {
        final manager = attached(const [
          _TestLayer(list: list, id: 'a', type: 'symbol', testIcon: pin),
          _TestLayer(list: list, id: 'b', type: 'symbol', testIcon: pin),
        ]);
        await pumpEventQueue();
        images.clear();
        manager.update(const [
          _TestLayer(list: list, id: 'a', type: 'symbol', testIcon: flag),
          _TestLayer(list: list, id: 'b', type: 'symbol', testIcon: pin),
        ]);
        await pumpEventQueue();
        expect(images, ['add maplibre-icon-2']);
        expect(imageOf('a'), 'maplibre-icon-2');
        manager.update(const [
          _TestLayer(list: list, id: 'a', type: 'symbol', testIcon: flag),
        ]);
        await pumpEventQueue();
        expect(images, ['add maplibre-icon-2', 'remove maplibre-icon-1']);
      });

      test('keep the old image until the new one is on the style', () async {
        final manager = attached(const [
          _TestLayer(list: list, id: 'a', type: 'symbol', testIcon: pin),
        ]);
        await pumpEventQueue();
        images.clear();
        final gate = style.imageGate = Completer();
        manager.update(const [
          _TestLayer(list: list, id: 'a', type: 'symbol', testIcon: flag),
        ]);
        await pumpEventQueue();
        expect(imageOf('a'), 'maplibre-icon-1');
        expect(images, isEmpty);
        gate.complete();
        await pumpEventQueue();
        expect(imageOf('a'), 'maplibre-icon-2');
        expect(images, ['add maplibre-icon-2', 'remove maplibre-icon-1']);
      });

      test('keep the old image if the new one fails', () async {
        final errors = <FlutterErrorDetails>[];
        final onError = FlutterError.onError;
        FlutterError.onError = errors.add;
        addTearDown(() => FlutterError.onError = onError);
        final manager = attached(const [
          _TestLayer(list: list, id: 'a', type: 'symbol', testIcon: pin),
        ]);
        await pumpEventQueue();
        images.clear();
        final gate = style.imageGate = Completer();
        manager.update(const [
          _TestLayer(list: list, id: 'a', type: 'symbol', testIcon: flag),
        ]);
        gate.completeError(StateError('no image'));
        await pumpEventQueue();
        expect(errors.single.exception, isA<StateError>());
        expect(imageOf('a'), 'maplibre-icon-1');
        expect(images, isEmpty);
      });

      test('are added again to a new style', () async {
        final manager = attached(const [
          _TestLayer(list: list, id: 'a', type: 'symbol', testIcon: pin),
        ]);
        await pumpEventQueue();
        manager.detach();
        layers.dispose();
        sources.dispose();
        images.clear();
        manager.attach(style);
        await pumpEventQueue();
        expect(images, ['add maplibre-icon-1']);
        expect(imageOf('a'), 'maplibre-icon-1');
      });

      test('of an image of the style are not added', () async {
        attached(const [
          _TestLayer(
            list: list,
            id: 'a',
            type: 'symbol',
            testIcon: .named('sprite-pin'),
          ),
        ]);
        await pumpEventQueue();
        expect(images, isEmpty);
        expect(imageOf('a'), 'sprite-pin');
      });

      test('compare bytes by content', () {
        expect(
          MarkerIcon.bytes(Uint8List.fromList([1, 2, 3])),
          MarkerIcon.bytes(Uint8List.fromList([1, 2, 3])),
        );
        expect(
          MarkerIcon.bytes(Uint8List.fromList([1, 2, 3])),
          isNot(MarkerIcon.bytes(Uint8List.fromList([1, 2, 4]))),
        );
      });
    });
  });
}
