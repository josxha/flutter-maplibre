import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:mocktail/mocktail.dart';

import 'shared/recording_style_backend.dart';

class _MockStyleController extends Mock implements StyleController {}

class _TestLayer extends Layer<Feature<Point>> {
  const _TestLayer({
    required super.list,
    this.radius = 1,
    this.type = 'circle',
    this.sourceLayerId,
  });

  final num radius;
  final String type;
  final String? sourceLayerId;

  @override
  Map<String, Object> getLayout() => {};

  @override
  Map<String, Object> getPaint() => {};

  @override
  StyleLayer createStyleLayer(int index) => type == 'circle'
      ? CircleStyleLayer(
          id: getLayerId(index),
          sourceId: getSourceId(index),
          sourceLayerId: sourceLayerId,
          minZoom: minZoom,
          maxZoom: maxZoom,
          radius: Expression.literal(radius),
        )
      : HeatmapStyleLayer(id: getLayerId(index), sourceId: getSourceId(index));

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
    sources = StyleSources(backend);
    layers = StyleLayers(backend, sources: sources);
  });

  List<String> ids() => layers.map((layer) => layer.id).toList();

  group('StyleLayers', () {
    setUp(() {
      sources.load({
        'src': {'type': 'geojson', 'data': 'https://example.com/a.json'},
      });
      layers.load([
        {'id': 'bottom', 'type': 'background'},
        {'id': 'middle', 'type': 'circle', 'source': 'src'},
        {'id': 'top', 'type': 'line', 'source': 'src'},
      ]);
    });

    test('reads layers in order, typed, without calling the map', () {
      expect(ids(), ['bottom', 'middle', 'top']);
      expect(layers.length, 3);
      expect(layers['middle'], isA<CircleStyleLayer>());
      expect(layers['top'], isA<LineStyleLayer>());
      expect(layers['missing'], isNull);
      expect(backend.calls, isEmpty);
    });

    test('adds on top and below, in the cache at once', () async {
      final a = FillStyleLayer(id: 'a', sourceId: 'src');
      final added = layers.add(a);
      expect(ids().last, 'a');
      await added;
      await layers.add(
        FillStyleLayer(id: 'b', sourceId: 'src'),
        belowLayerId: 'middle',
      );
      expect(ids(), ['bottom', 'b', 'middle', 'top', 'a']);
      expect(backend.calls, [
        'addLayer a below null',
        'addLayer b below middle',
      ]);
    });

    test('rejects a taken id, a missing source and a missing position', () {
      expect(
        layers.add(BackgroundStyleLayer(id: 'top')),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        layers.add(CircleStyleLayer(id: 'x', sourceId: 'none')),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        layers.add(BackgroundStyleLayer(id: 'x'), belowLayerId: 'none'),
        throwsA(isA<ArgumentError>()),
      );
      expect(ids(), ['bottom', 'middle', 'top']);
      expect(backend.calls, isEmpty);
    });

    test('rejects a layer object that already is on a map', () {
      expect(layers.add(layers['top']!), throwsA(isA<StateError>()));
    });

    test('takes a layer the map rejects out again', () async {
      backend.failNext = true;
      final layer = BackgroundStyleLayer(id: 'x');
      final added = layers.add(layer);
      expect(ids().last, 'x');
      await expectLater(added, throwsA(isA<StateError>()));
      expect(layers['x'], isNull);
      // It is detached, so it can go to the map again.
      backend.calls.clear();
      layer.color = const .literal(Color(0xFF000000));
      expect(backend.calls, isEmpty);
      await layers.add(layer);
      expect(layers['x'], layer);
    });

    test('removes and ignores what is not there', () async {
      await layers.remove('middle');
      await layers.remove('missing');
      expect(ids(), ['bottom', 'top']);
      expect(backend.calls, ['removeLayer middle']);
    });

    test('moves, also through the layer', () {
      layers.move('bottom');
      expect(ids(), ['middle', 'top', 'bottom']);
      layers.move('bottom', belowLayerId: 'top');
      expect(ids(), ['middle', 'bottom', 'top']);
      layers['top']!.moveBelow('middle');
      expect(ids(), ['top', 'middle', 'bottom']);
      layers['top']!.moveBelow(null);
      expect(ids(), ['middle', 'bottom', 'top']);
      layers.move('top', belowLayerId: 'top');
      expect(ids(), ['middle', 'bottom', 'top']);
      expect(backend.calls, [
        'moveLayer bottom below null',
        'moveLayer bottom below top',
        'moveLayer top below middle',
        'moveLayer top below null',
      ]);
      expect(() => layers.move('none'), throwsArgumentError);
      expect(
        () => layers.move('top', belowLayerId: 'none'),
        throwsArgumentError,
      );
    });

    test('setters of a layer on the map reach it in order', () {
      final layer = layers['top']! as LineStyleLayer;
      layer
        ..width = const .literal(2)
        ..cap = const .literal(LineCap.round)
        ..visible = false
        ..visible = true
        ..filter = Expression.has('a')
        ..filter = null
        ..minZoom = 1
        ..maxZoom = 2
        ..width = null;
      expect(backend.calls, [
        'setPaint top line-width 2',
        'setLayout top line-cap round',
        'setLayout top visibility none',
        'setLayout top visibility null',
        'setFilter top [has, a]',
        'setFilter top null',
        'setZoomRange top 1.0 24.0',
        'setZoomRange top 1.0 2.0',
        'setPaint top line-width null',
      ]);
    });

    test('a removed layer only changes the object', () async {
      final layer = layers['top']! as LineStyleLayer;
      await layers.remove('top');
      backend.calls.clear();
      layer
        ..width = const .literal(2)
        ..moveBelow('bottom');
      expect(layer.width, const Literal<num>(2));
      expect(backend.calls, isEmpty);
    });

    test('disposing the style detaches every layer', () {
      final layer = layers['top']! as LineStyleLayer;
      layers.dispose();
      expect(layers, isEmpty);
      layer.width = const .literal(2);
      expect(backend.calls, isEmpty);
    });

    test('a layer not on a map sends nothing', () {
      LineStyleLayer(id: 'x', sourceId: 'src').width = const .literal(2);
      expect(backend.calls, isEmpty);
    });
  });

  group('StyleSources', () {
    const quad = LngLatQuad(
      bottomLeft: Geographic(lon: 0, lat: 0),
      bottomRight: Geographic(lon: 1, lat: 0),
      topLeft: Geographic(lon: 0, lat: 1),
      topRight: Geographic(lon: 1, lat: 1),
    );

    test('reads every source type back', () {
      sources.load({
        'geo-url': {
          'type': 'geojson',
          'data': 'https://a',
          'lineMetrics': true,
        },
        'geo-data': {
          'type': 'geojson',
          'data': {'type': 'FeatureCollection', 'features': <Object?>[]},
          'attribution': 'A',
        },
        'raster-url': {'type': 'raster', 'url': 'https://b', 'tileSize': 256},
        'raster-tiles': {
          'type': 'raster',
          'tiles': ['https://c'],
          'scheme': 'tms',
        },
        'dem': {
          'type': 'raster-dem',
          'url': 'https://d',
          'encoding': 'terrarium',
        },
        'vector': {
          'type': 'vector',
          'tiles': ['https://e'],
          'maxzoom': 10,
        },
        'image': {
          'type': 'image',
          'url': 'https://f',
          'coordinates': [
            [0, 1],
            [1, 1],
            [1, 0],
            [0, 0],
          ],
        },
        'future': {'type': 'future'},
      });
      expect(sources.length, 8);
      expect((sources['geo-url']! as GeoJsonSourceUrl).lineMetrics, isTrue);
      expect(
        (sources['geo-data']! as GeoJsonSourceData).data,
        '{"type":"FeatureCollection","features":[]}',
      );
      expect((sources['geo-data']! as GeoJsonSourceData).attribution, 'A');
      expect((sources['raster-url']! as RasterSourceUrl).tileSize, 256);
      expect((sources['raster-tiles']! as RasterSourceTiles).tiles, [
        'https://c',
      ]);
      expect(
        (sources['raster-tiles']! as RasterSourceTiles).scheme,
        TileScheme.tms,
      );
      expect(
        (sources['dem']! as RasterDemSourceUrl).encoding,
        isA<RasterDemTerrariumEncoding>(),
      );
      expect((sources['vector']! as VectorSourceTiles).maxZoom, 10);
      final image = sources['image']! as ImageSourceUrl;
      expect(image.coordinates.topLeft, const Geographic(lon: 0, lat: 1));
      expect(image.coordinates.bottomLeft, const Geographic(lon: 0, lat: 0));
      expect(sources['future'].runtimeType, Source);
      expect(sources['missing'], isNull);
      expect(backend.calls, isEmpty);
    });

    test('adds, rejects a taken id and removes', () async {
      const source = GeoJsonSource.url(id: 'a', url: 'https://a');
      await sources.add(source);
      expect(sources['a'], source);
      expect(sources.add(source), throwsArgumentError);
      await sources.remove('a');
      await sources.remove('a');
      expect(sources, isEmpty);
      expect(backend.calls, ['addSource a', 'removeSource a']);
    });

    test('takes a source the map rejects out again', () async {
      backend.failNext = true;
      await expectLater(
        sources.add(const GeoJsonSource.url(id: 'a', url: 'https://a')),
        throwsA(isA<StateError>()),
      );
      expect(sources['a'], isNull);
    });

    test('updates GeoJSON sources, keeping their options', () async {
      await sources.add(
        const GeoJsonSource.url(
          id: 'a',
          url: 'https://a',
          lineMetrics: true,
          attribution: 'A',
        ),
      );
      await sources.updateGeoJsonData('a', '{}');
      final data = sources['a']! as GeoJsonSourceData;
      expect(data.data, '{}');
      expect(data.lineMetrics, isTrue);
      expect(data.attribution, 'A');
      await sources.updateGeoJsonUrl('a', 'https://b');
      final url = sources['a']! as GeoJsonSourceUrl;
      expect(url.url, 'https://b');
      expect(url.lineMetrics, isTrue);
      expect(backend.calls.skip(1), [
        'setGeoJsonData a {}',
        'setGeoJsonUrl a https://b',
      ]);
      expect(sources.updateGeoJsonData('none', '{}'), throwsArgumentError);
    });

    test('updates image coordinates', () async {
      await sources.add(
        const ImageSource.url(id: 'i', url: 'https://i', coordinates: quad),
      );
      const other = LngLatQuad(
        bottomLeft: Geographic(lon: 2, lat: 2),
        bottomRight: Geographic(lon: 3, lat: 2),
        topLeft: Geographic(lon: 2, lat: 3),
        topRight: Geographic(lon: 3, lat: 3),
      );
      await sources.updateImageCoordinates('i', other);
      expect((sources['i']! as ImageSourceUrl).coordinates, other);
      expect(backend.calls.last, 'setImageCoordinates i');
      expect(
        sources.updateImageCoordinates('none', other),
        throwsArgumentError,
      );
    });

    test('updates the tiles and URL of tile sources', () async {
      await sources.add(const VectorSource.url(id: 'v', url: 'https://a'));
      await sources.updateTiles('v', ['https://t']);
      expect((sources['v']! as VectorSourceTiles).tiles, ['https://t']);
      expect(backend.lastSpecification?['tiles'], ['https://t']);
      expect(backend.lastSpecification, isNot(contains('url')));

      await sources.updateTileJsonUrl('v', 'https://b');
      expect((sources['v']! as VectorSourceUrl).url, 'https://b');
      expect(backend.lastSpecification?['url'], 'https://b');
      expect(backend.lastSpecification, isNot(contains('tiles')));

      await sources.add(const GeoJsonSource.url(id: 'g', url: 'https://g'));
      expect(sources.updateTiles('g', const []), throwsArgumentError);
      expect(sources.updateTileJsonUrl('none', ''), throwsArgumentError);
    });

    test('merges TileJSON info, which an update does not carry over', () async {
      await sources.add(const RasterSource.url(id: 'r', url: 'https://a'));
      expect(
        sources.applyTileJson(
          'r',
          attribution: 'A',
          minZoom: 2,
          maxZoom: 9,
          bounds: const [1, 2, 3, 4],
        ),
        isTrue,
      );
      final source = sources['r']! as RasterSourceUrl;
      expect(source.attribution, 'A');
      expect(source.minZoom, 2);
      expect(source.maxZoom, 9);
      expect(source.bounds, [1, 2, 3, 4]);
      expect(source.url, 'https://a');
      expect(
        sources.applyTileJson('r', attribution: 'A', minZoom: 2, maxZoom: 9),
        isFalse,
      );

      await sources.updateTileJsonUrl('r', 'https://b');
      expect(
        backend.lastSpecification,
        isNot(containsPair('attribution', 'A')),
      );
      expect((sources['r']! as RasterSourceUrl).maxZoom, 22);
      expect(sources.applyTileJson('none', attribution: 'A'), isFalse);
    });

    test('disposing forgets the sources', () async {
      await sources.add(const GeoJsonSource.url(id: 'a', url: 'https://a'));
      sources.dispose();
      expect(sources, isEmpty);
    });
  });

  group('LayerManager', () {
    late _MockStyleController style;
    var batches = 0;

    setUp(() {
      batches = 0;
      style = _MockStyleController();
      when(() => style.layers).thenReturn(layers);
      when(() => style.sources).thenReturn(sources);
      when(() => style.batch(any())).thenAnswer((invocation) {
        batches++;
        (invocation.positionalArguments.single as void Function())();
      });
    });

    const point = Feature<Point>(geometry: Point(Geographic(lon: 0, lat: 0)));
    const other = Feature<Point>(geometry: Point(Geographic(lon: 1, lat: 1)));
    const list = [point];

    test('adds sources and layers in one batch', () {
      LayerManager(style, const [
        _TestLayer(list: list),
        _TestLayer(list: list),
      ]);
      expect(batches, 1);
      expect(ids(), ['maplibre-layer-0', 'maplibre-layer-1']);
      expect(sources.map((source) => source.id), [
        'maplibre-source-0',
        'maplibre-source-1',
      ]);
    });

    test('does nothing when nothing changed', () {
      final manager = LayerManager(style, const [_TestLayer(list: list)]);
      backend.calls.clear();
      manager.updateLayers(const [_TestLayer(list: list)]);
      expect(backend.calls, isEmpty);
    });

    test('sets only the changed properties, in place', () {
      final manager = LayerManager(style, const [
        _TestLayer(list: list),
        _TestLayer(list: list),
      ]);
      final layer = layers['maplibre-layer-0'];
      backend.calls.clear();
      manager.updateLayers(const [
        _TestLayer(list: list, radius: 2),
        _TestLayer(list: list),
      ]);
      expect(backend.calls, ['setPaint maplibre-layer-0 circle-radius 2']);
      expect(layers['maplibre-layer-0'], same(layer));
      expect(ids(), ['maplibre-layer-0', 'maplibre-layer-1']);
    });

    test('updates only the data when only the features changed', () {
      final manager = LayerManager(style, const [_TestLayer(list: list)]);
      backend.calls.clear();
      manager.updateLayers(const [
        _TestLayer(list: [other]),
      ]);
      expect(
        backend.calls.single,
        startsWith('setGeoJsonData maplibre-source-0'),
      );
    });

    test('updates a list that grew in place', () {
      final features = [point];
      final manager = LayerManager(style, [_TestLayer(list: features)]);
      backend.calls.clear();
      features.add(other);
      manager.updateLayers([_TestLayer(list: features)]);
      expect(
        backend.calls.single,
        startsWith('setGeoJsonData maplibre-source-0'),
      );
      backend.calls.clear();
      manager.updateLayers([_TestLayer(list: features)]);
      expect(backend.calls, isEmpty);
    });

    test('re-creates a layer whose type changed, at its position', () {
      final manager = LayerManager(style, const [
        _TestLayer(list: list),
        _TestLayer(list: list),
        _TestLayer(list: list),
      ]);
      backend.calls.clear();
      manager.updateLayers(const [
        _TestLayer(list: list),
        _TestLayer(list: list, type: 'heatmap'),
        _TestLayer(list: list),
      ]);
      expect(backend.calls, [
        'removeLayer maplibre-layer-1',
        'addLayer maplibre-layer-1 below maplibre-layer-2',
      ]);
      expect(ids(), [
        'maplibre-layer-0',
        'maplibre-layer-1',
        'maplibre-layer-2',
      ]);
      expect(layers['maplibre-layer-1'], isA<HeatmapStyleLayer>());

      // The new layer is the one that updates from now on.
      backend.calls.clear();
      manager.updateLayers(const [
        _TestLayer(list: list),
        _TestLayer(list: list, type: 'heatmap'),
        _TestLayer(list: list),
      ]);
      expect(backend.calls, isEmpty);
    });

    test('re-creates a layer whose source layer changed', () {
      final manager = LayerManager(style, const [_TestLayer(list: list)]);
      backend.calls.clear();
      manager.updateLayers(const [_TestLayer(list: list, sourceLayerId: 'a')]);
      expect(backend.calls, [
        'removeLayer maplibre-layer-0',
        'addLayer maplibre-layer-0 below null',
      ]);
    });

    test('adds new layers on top and removes left-over ones', () {
      final manager = LayerManager(style, const [_TestLayer(list: list)]);
      backend.calls.clear();
      manager.updateLayers(const [
        _TestLayer(list: list),
        _TestLayer(list: list),
      ]);
      expect(backend.calls, [
        'addSource maplibre-source-1',
        'addLayer maplibre-layer-1 below null',
      ]);
      backend.calls.clear();
      manager.updateLayers(const []);
      expect(backend.calls, [
        'removeLayer maplibre-layer-1',
        'removeSource maplibre-source-1',
        'removeLayer maplibre-layer-0',
        'removeSource maplibre-source-0',
      ]);
      expect(layers, isEmpty);
      expect(sources, isEmpty);
    });
  });
}
