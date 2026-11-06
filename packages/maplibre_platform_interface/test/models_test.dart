import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

// Equal values from separate calls, which const would canonicalize into one
// instance.
MapStyle _url(String url) => MapStyle.url(url);
MapStyle _json(String json) => MapStyle.json(json);
CameraUpdate _position(double zoom) => CameraUpdate.position(zoom: zoom);
CameraUpdate _bounds(double north) => CameraUpdate.bounds(
  GeoBox(west: -10, south: -5, east: 10, north: north),
  padding: const EdgeInsets.all(8),
);
MapOptions _options(String asset) => MapOptions(
  style: MapStyle.asset(asset),
  initCamera: _position(3),
  maxBounds: const GeoBox(west: 0, south: 0, east: 1, north: 1),
);

void main() {
  group('MapStyle', () {
    test('compares by type and value', () {
      expect(_url('a'), _url('a'));
      expect(_url('a').hashCode, _url('a').hashCode);
      expect(_json('{}'), _json('{}'));
      expect(const MapStyle.url('a'), isNot(const MapStyle.url('b')));
      expect(const MapStyle.url('a'), isNot(const MapStyle.asset('a')));
      expect(const MapStyle.asset('a'), isNot(const MapStyle.file('a')));
    });

    test('demo is the MapLibre demo style', () {
      expect(
        MapStyle.demo,
        isA<MapStyleUrl>().having(
          (style) => style.url,
          'url',
          'https://demotiles.maplibre.org/style.json',
        ),
      );
      expect(const MapOptions().style, MapStyle.demo);
    });
  });

  group('CameraUpdate', () {
    const bounds = GeoBox(west: -10, south: -5, east: 10, north: 5);

    test('position compares by value', () {
      expect(const CameraUpdate.position(), const CameraUpdatePosition());
      expect(_position(3), _position(3));
      expect(_position(3).hashCode, _position(3).hashCode);
      expect(
        const CameraUpdate.position(zoom: 3),
        isNot(const CameraUpdate.position(zoom: 4)),
      );
      expect(
        const CameraUpdate.position(anchor: Offset(1, 2)),
        isNot(const CameraUpdate.position(anchor: Offset(2, 1))),
      );
    });

    test('bounds compares by value', () {
      expect(_bounds(5), _bounds(5));
      expect(_bounds(5).hashCode, _bounds(5).hashCode);
      expect(
        const CameraUpdate.bounds(bounds),
        isNot(const CameraUpdate.bounds(bounds, pitch: 30)),
      );
      expect(
        const CameraUpdate.bounds(bounds),
        isNot(const CameraUpdate.bounds(bounds, maxZoom: 10)),
      );
      expect(
        const CameraUpdate.bounds(bounds),
        isNot(
          const CameraUpdate.bounds(
            GeoBox(west: -10, south: -5, east: 10, north: 6),
          ),
        ),
      );
    });

    test('points compare by their list and fit into their bounds', () {
      const points = CameraUpdate.points([
        Geographic(lon: 4, lat: -2),
        Geographic(lon: -3, lat: 7),
        Geographic(lon: 1, lat: 1),
      ]);
      expect(
        points,
        CameraUpdatePoints(
          List.of(const [
            Geographic(lon: 4, lat: -2),
            Geographic(lon: -3, lat: 7),
            Geographic(lon: 1, lat: 1),
          ]),
        ),
      );
      expect(
        points,
        isNot(const CameraUpdate.points([Geographic(lon: 4, lat: -2)])),
      );
      expect(
        (points as CameraUpdateFit).bounds,
        const GeoBox(west: -3, south: -2, east: 4, north: 7),
      );
      expect(() => const CameraUpdatePoints([]).bounds, throwsArgumentError);
    });

    test('geometry fits into its bounds', () {
      final update = CameraUpdate.geometry(
        LineString.from(const [
          Geographic(lon: 2, lat: 3),
          Geographic(lon: -1, lat: 8),
        ]),
      );
      expect(
        (update as CameraUpdateFit).bounds,
        const GeoBox(west: -1, south: 3, east: 2, north: 8),
      );
    });

    test('a camera turns into the update that restores it', () {
      const camera = CameraPosition(
        center: Geographic(lon: 1, lat: 2),
        zoom: 3,
        bearing: 4,
        pitch: 5,
        roll: 6,
        padding: EdgeInsets.only(top: 7),
      );
      expect(
        camera.toCameraUpdate(),
        const CameraUpdate.position(
          center: Geographic(lon: 1, lat: 2),
          zoom: 3,
          bearing: 4,
          pitch: 5,
          roll: 6,
          padding: EdgeInsets.only(top: 7),
        ),
      );
    });

    test('is not set by default, so the style camera applies', () {
      expect(const MapOptions().initCamera, isNull);
    });
  });

  group('CameraAnimation', () {
    test('defaults to a 300 ms ease', () {
      expect(const CameraAnimation.ease(), const CameraAnimationEase());
      expect(
        (const CameraAnimation.ease() as CameraAnimationEase).duration,
        const Duration(milliseconds: 300),
      );
      expect(const CameraAnimation.ease().curve, Curves.ease);
    });

    test('compares by value', () {
      expect(
        const CameraAnimation.fly(speed: 2),
        isNot(const CameraAnimation.fly()),
      );
      expect(
        const CameraAnimation.fly(peakZoom: 3),
        const CameraAnimationFly(peakZoom: 3),
      );
      expect(
        const CameraAnimation.ease(),
        isNot(const CameraAnimation.ease(curve: Curves.easeIn)),
      );
    });
  });

  group('MapOptions', () {
    test('compares by value', () {
      expect(_options('style.json'), _options('style.json'));
      expect(_options('style.json').hashCode, _options('style.json').hashCode);
      expect(_options('style.json'), isNot(_options('other.json')));
      expect(
        const MapOptions(),
        isNot(const MapOptions(style: MapStyle.asset('style.json'))),
      );
      expect(
        const MapOptions(),
        isNot(const MapOptions(fastPforEnabled: true)),
      );
    });

    test('leaves FastPFOR decoding off by default, as MapLibre Native', () {
      expect(const MapOptions().fastPforEnabled, isFalse);
    });
  });

  group('CameraPosition', () {
    const camera = CameraPosition(
      center: Geographic(lon: 12, lat: 2),
      zoom: 2,
      bearing: 213,
      pitch: 12,
    );

    test('compares by value', () {
      expect(
        camera,
        const CameraPosition(
          center: Geographic(lon: 12, lat: 2),
          zoom: 2,
          bearing: 213,
          pitch: 12,
        ),
      );
      for (final other in const [
        CameraPosition(
          center: Geographic(lon: 13, lat: 2),
          zoom: 2,
          bearing: 213,
          pitch: 12,
        ),
        CameraPosition(
          center: Geographic(lon: 12, lat: 2),
          zoom: 3,
          bearing: 213,
          pitch: 12,
        ),
        CameraPosition(
          center: Geographic(lon: 12, lat: 2),
          zoom: 2,
          bearing: 0,
          pitch: 12,
        ),
        CameraPosition(
          center: Geographic(lon: 12, lat: 2),
          zoom: 2,
          bearing: 213,
          pitch: 0,
        ),
      ]) {
        expect(camera, isNot(other));
      }
    });

    test('toString names every value', () {
      expect(
        camera.toString(),
        'CameraPosition(center: Geographic(lon: 12.0, lat: 2.0), zoom: 2.0, '
        'bearing: 213.0, pitch: 12.0, roll: 0.0, padding: EdgeInsets.zero)',
      );
    });
  });

  group('RenderedFeature', () {
    test('geometryFromJson parses GeoJSON geometries', () {
      final point = RenderedFeature.geometryFromJson({
        'type': 'Point',
        'coordinates': [1.5, 2.5],
      });
      expect(point, isA<Point>());
      expect((point! as Point).position, const Geographic(lon: 1.5, lat: 2.5));
      expect(
        RenderedFeature.geometryFromJson({
          'type': 'LineString',
          'coordinates': [
            [0, 0],
            [1, 1],
          ],
        }),
        isA<LineString>(),
      );
      expect(RenderedFeature.geometryFromJson(null), isNull);
      expect(RenderedFeature.geometryFromJson({'type': 'Unknown'}), isNull);
      expect(RenderedFeature.geometryFromJson('Point'), isNull);
    });

    test('compares by ID, source, and layer, not by properties', () {
      const feature = RenderedFeature(
        id: 1,
        properties: {'name': 'a'},
        sourceId: 'source',
        sourceLayer: 'layer',
      );
      const sameFeature = RenderedFeature(
        id: 1,
        properties: {'name': 'b'},
        sourceId: 'source',
        sourceLayer: 'layer',
      );
      expect(feature, sameFeature);
      expect(feature.hashCode, sameFeature.hashCode);
      expect(
        feature,
        isNot(const RenderedFeature(id: 2, properties: {}, sourceId: 'source')),
      );
      expect(
        feature,
        isNot(const RenderedFeature(id: 1, properties: {}, sourceId: 'other')),
      );
      expect(
        feature,
        isNot(
          const RenderedFeature(
            id: 1,
            properties: {},
            sourceId: 'source',
            sourceLayer: 'layer',
            layerId: 'roads',
          ),
        ),
      );
    });

    test('toString names every value', () {
      const feature = RenderedFeature(
        id: 'x',
        properties: {'name': 'a'},
        sourceId: 'source',
      );
      expect(
        feature.toString(),
        'RenderedFeature(id: x, properties: {name: a}, geometry: null, '
        'sourceId: source, sourceLayer: null, layerId: null)',
      );
    });
  });

  group('MapGestures', () {
    test('turns every gesture on by default and off with none', () {
      const all = MapGestures();
      const none = MapGestures.none();
      expect(all.allEnabled, isTrue);
      expect(all.anyEnabled, isTrue);
      expect(none.allEnabled, isFalse);
      expect(none.anyEnabled, isFalse);
      expect([all.pan.drag, all.pan.fling], everyElement(isTrue));
      expect(
        none.zoom,
        const ZoomGestures(
          pinch: false,
          scrollWheel: false,
          doubleTap: false,
          doubleTapDrag: false,
        ),
      );
      expect(none.rotate, const RotateGestures(twist: false, mouseDrag: false));
      expect(
        none.pitch,
        const PitchGestures(twoFingerDrag: false, mouseDrag: false),
      );
    });

    test('turns off a category or a single gesture', () {
      const noPitch = MapGestures(pitch: PitchGestures.none());
      expect(noPitch.allEnabled, isFalse);
      expect(noPitch.anyEnabled, isTrue);
      expect(noPitch.pitch.anyEnabled, isFalse);
      expect(noPitch.zoom.allEnabled, isTrue);

      const noWheel = MapGestures(zoom: ZoomGestures(scrollWheel: false));
      expect(noWheel.zoom.anyEnabled, isTrue);
      expect(noWheel.zoom.allEnabled, isFalse);
      expect(noWheel.zoom.pinch, isTrue);

      const onlyZoom = MapGestures.none(zoom: ZoomGestures());
      expect(onlyZoom.zoom.allEnabled, isTrue);
      expect(onlyZoom.pan.anyEnabled, isFalse);
    });

    test('a fling alone does not pan', () {
      expect(const PanGestures(drag: false).anyEnabled, isFalse);
    });

    test('compares by value', () {
      const a = MapGestures(rotate: RotateGestures(twist: false));
      final b = const MapGestures().copyWith(
        rotate: const RotateGestures().copyWith(twist: false),
      );
      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(const MapGestures()));
      expect(
        const ZoomGestures().copyWith(doubleTap: false),
        const ZoomGestures(doubleTap: false),
      );
      expect(
        const PitchGestures().copyWith(mouseDrag: false),
        const PitchGestures(mouseDrag: false),
      );
      expect(
        const PanGestures().copyWith(fling: false),
        const PanGestures(fling: false),
      );
    });
  });

  group('offline models', () {
    const bounds = GeoBox(west: 1, east: 3, south: -3, north: 3);
    const definition = OfflineTilePyramidRegionDefinition(
      bounds: bounds,
      minZoom: 2,
      maxZoom: 4,
      pixelRatio: 1,
      styleUrl: 'https://example.com/style.json',
    );
    const region = OfflineRegion(id: 23, definition: definition);

    test('OfflineRegion compares by value', () {
      const same = OfflineRegion(
        id: 23,
        definition: OfflineTilePyramidRegionDefinition(
          bounds: bounds,
          minZoom: 2,
          maxZoom: 4,
          pixelRatio: 1,
          styleUrl: 'https://example.com/style.json',
        ),
      );
      expect(region, same);
      expect(region.hashCode, same.hashCode);
      expect(
        region,
        isNot(const OfflineRegion(id: 24, definition: definition)),
      );
      expect(region.toString(), contains('styleUrl: ${definition.styleUrl}'));
      expect(definition.includeIdeographs, isFalse);
    });

    test('a geometry definition has the bounds of its geometry', () {
      OfflineGeometryRegionDefinition route() =>
          OfflineGeometryRegionDefinition(
            geometry: LineString.from(const [
              Geographic(lon: 1, lat: 3),
              Geographic(lon: 3, lat: -3),
              Geographic(lon: 2, lat: 0),
            ]),
            minZoom: 2,
            maxZoom: double.infinity,
            pixelRatio: 1,
            styleUrl: 'https://example.com/style.json',
          );
      expect(route().bounds, bounds);
      // Geometries with the same coordinates are equal.
      expect(route(), route());
      expect(route().hashCode, route().hashCode);
      expect(
        route(),
        isNot(
          OfflineGeometryRegionDefinition(
            geometry: LineString.from(const [
              Geographic(lon: 1, lat: 3),
              Geographic(lon: 3, lat: -3),
            ]),
            minZoom: 2,
            maxZoom: double.infinity,
            pixelRatio: 1,
            styleUrl: 'https://example.com/style.json',
          ),
        ),
      );
      expect(route().toString(), contains('"type":"LineString"'));
    });

    test('DownloadProgress reports its progress', () {
      DownloadProgress progress({
        int completed = 1,
        int required = 4,
        bool precise = true,
        bool complete = false,
      }) => DownloadProgress(
        region: region,
        status: OfflineRegionStatus(
          downloadState: OfflineRegionDownloadState.active,
          completedResourceCount: completed,
          completedResourceSize: 100,
          completedTileCount: completed,
          completedTileSize: 80,
          requiredResourceCount: required,
          requiredTileCount: required,
          requiredResourceCountIsPrecise: precise,
          complete: complete,
        ),
      );
      expect(progress().progress, 0.25);
      expect(progress().downloadCompleted, isFalse);
      expect(progress(completed: 0, required: 0).progress, 1);
      expect(progress(precise: false).progress, isNull);
      expect(progress(precise: false, complete: true).progress, 1);
      expect(progress(complete: true).downloadCompleted, isTrue);
      expect(progress(), progress());
      expect(progress().hashCode, progress().hashCode);
      expect(progress(), isNot(progress(completed: 2)));
      expect(progress().toString(), contains('completedTileCount: 1'));
      expect(progress().toString(), contains('downloadState: active'));
    });

    test('download exceptions describe the problem', () {
      const resource = OfflineResourceException(
        regionId: 3,
        reason: OfflineResourceErrorReason.notFound,
        details: 'HTTP 404',
      );
      expect(
        resource.toString(),
        'OfflineDownloadException: A resource of offline region 3 failed to '
        'load (notFound): HTTP 404',
      );
      const limit = OfflineTileCountLimitException(regionId: 3, limit: 6000);
      expect(limit.message, contains('6000 tiles'));
      expect(limit, isA<OfflineDownloadException>());
      expect(limit.regionId, 3);
    });
  });

  group('ColorExtension.toHexString', () {
    test('writes RGB with a hash sign', () {
      expect(const Color(0xFF12AB34).toHexString(), '#12AB34');
    });

    test('can leave out the hash sign and add the alpha', () {
      expect(
        const Color(0x8012AB34).toHexString(hashSign: false, alpha: true),
        '8012AB34',
      );
    });
  });

  group('MapEvent', () {
    const point = Geographic(lon: 1, lat: 2);
    const screenPoint = Offset(3, 4);

    test('user input events carry their location', () {
      final events = <MapEventUserInput>[
        const MapEventClick(point: point, screenPoint: screenPoint),
        MapEventDoubleClick(point: point, screenPoint: screenPoint),
        const MapEventSecondaryClick(point: point, screenPoint: screenPoint),
        const MapEventLongClick(point: point, screenPoint: screenPoint),
      ];
      for (final event in events) {
        expect(event.point, point);
        expect(event.screenPoint, screenPoint);
        expect(event.toString(), startsWith('${event.runtimeType}('));
        expect(event.toString(), contains('screenPoint: $screenPoint'));
      }
    });

    test('camera events carry the camera and the reason', () {
      const camera = CameraPosition(
        center: point,
        zoom: 1,
        bearing: 0,
        pitch: 0,
      );
      const move = MapEventCameraMove(
        camera: camera,
        reason: CameraChangeReason.gesture,
      );
      expect(move.camera, camera);
      expect(move.reason, CameraChangeReason.gesture);
      const end = MapEventCameraMoveEnd(
        camera: camera,
        reason: CameraChangeReason.programmatic,
      );
      expect(end.camera, camera);
      expect(end.reason, CameraChangeReason.programmatic);
      expect(
        const MapEventCameraMoveStart(reason: CameraChangeReason.map).reason,
        CameraChangeReason.map,
      );
    });
  });

  group('QueryGeometry', () {
    test('compares by value', () {
      expect(
        const QueryGeometry.point(Offset(1, 2)),
        const QueryGeometry.point(Offset(1, 2)),
      );
      expect(
        const QueryGeometry.point(Offset(1, 2)),
        isNot(const QueryGeometry.point(Offset(2, 1))),
      );
      const rect = Rect.fromLTWH(0, 0, 10, 10);
      expect(const QueryGeometry.rect(rect), const QueryGeometry.rect(rect));
      expect(
        const QueryGeometry.rect(rect).hashCode,
        const QueryGeometry.rect(rect).hashCode,
      );
      expect(const QueryGeometry.viewport(), const QueryGeometry.viewport());
      expect(
        const QueryGeometry.viewport(),
        isNot(const QueryGeometry.rect(rect)),
      );
    });
  });

  group('SourceFeature', () {
    test('compares id, source layer and properties', () {
      const feature = SourceFeature(id: 1, properties: {'a': 1});
      expect(feature, const SourceFeature(id: 1, properties: {'a': 1}));
      expect(
        feature.hashCode,
        const SourceFeature(id: 1, properties: {'a': 1}).hashCode,
      );
      expect(feature, isNot(const SourceFeature(id: 2, properties: {'a': 1})));
      expect(feature, isNot(const SourceFeature(id: 1, properties: {'a': 2})));
      expect(
        feature,
        isNot(
          const SourceFeature(id: 1, properties: {'a': 1}, sourceLayer: 'l'),
        ),
      );
    });
  });

  group('GeoJsonData', () {
    const point = Point(Geographic(lon: 1, lat: 2));
    const json = {
      'type': 'Point',
      'coordinates': [1.0, 2.0],
    };

    test('gives every kind as text and as JSON', () {
      for (final data in [
        const GeoJsonData.geometry(point),
        const GeoJsonData.json(json),
        GeoJsonData.text(point.toText()),
      ]) {
        expect(data.toJson(), json, reason: '$data');
        expect(jsonDecode(data.toText()), json, reason: '$data');
      }
      const feature = GeoJsonData.feature(Feature(geometry: point, id: 1));
      expect(feature.toJson()['type'], 'Feature');
      final collection = GeoJsonData.featureCollection(
        FeatureCollection(const [Feature(geometry: point)]),
      );
      expect(collection.toJson()['features'], hasLength(1));
    });

    test('compares by kind and value', () {
      expect(GeoJsonData.json(Map.of(json)), GeoJsonData.json(Map.of(json)));
      expect(
        GeoJsonData.json(Map.of(json)).hashCode,
        GeoJsonData.json(Map.of(json)).hashCode,
      );
      expect(GeoJsonData.text('{}' * 1), GeoJsonData.text('{}' * 1));
      expect(const GeoJsonData.text('{}'), isNot(const GeoJsonData.json({})));
    });
  });

  group('GeoJsonSource', () {
    test('reads back its JSON, with clustering', () {
      final source = GeoJsonSourceData(
        id: 'g',
        data: const .json({'type': 'FeatureCollection', 'features': []}),
        maxZoom: 14,
        attribution: 'A',
        buffer: 64,
        tolerance: 1,
        lineMetrics: true,
        cluster: GeoJsonCluster(
          radius: 40,
          maxZoom: 12,
          minPoints: 3,
          properties: {
            'sum': ClusterProperty(
              reduce: .sum([
                Expression.accumulated().asNumber(),
                Expression.get('sum').asNumber(),
              ]),
              map: .get('mag'),
            ),
          },
        ),
      );
      final json = source.toJson();
      expect(json['clusterProperties'], {
        'sum': [
          [
            '+',
            [
              'number',
              ['accumulated'],
            ],
            [
              'number',
              ['get', 'sum'],
            ],
          ],
          ['get', 'mag'],
        ],
      });
      final read = Source.fromJson('g', json) as GeoJsonSourceData;
      expect(read.toJson(), json);
      expect(read.cluster, source.cluster);
      expect(read.data, source.data);
    });

    test('reads back constant cluster expressions as they were', () {
      final json = {
        'type': 'geojson',
        'data': 'https://g',
        'cluster': true,
        'clusterProperties': {
          'color': [
            ['accumulated'],
            ['rgb', 255, 0, 0],
          ],
        },
      };
      final read = Source.fromJson('g', json) as GeoJsonSource;
      expect(read.toJson()['clusterProperties'], json['clusterProperties']);
    });

    test('has no cluster options without clustering', () {
      const source = GeoJsonSource.url(id: 'g', url: 'https://g');
      expect(source.toJson().keys, isNot(contains('cluster')));
      expect(
        (Source.fromJson('g', {
          'type': 'geojson',
          'data': 'https://g',
          'clusterRadius': 10,
        }) as GeoJsonSource).cluster,
        isNull,
      );
    });
  });

  group('MapProjection', () {
    test('serializes to the projection definitions of the spec', () {
      expect(
        const Expression<MapProjection>.literal(.verticalPerspective).toJson(),
        'vertical-perspective',
      );
      expect(
        Expression.interpolate<MapProjection>(const .linear(), .zoom(), {
          10: const .literal(.globe),
          12: const .literal(.mercator),
        }).toJson(),
        [
          'interpolate',
          ['linear'],
          ['zoom'],
          10,
          'globe',
          12,
          'mercator',
        ],
      );
    });
  });

  group('StyleImageOptions', () {
    const options = StyleImageOptions(
      sdf: true,
      stretchX: [(1, 2)],
      stretchY: [(3, 4)],
      content: Rect.fromLTRB(1, 2, 3, 4),
      textFitWidth: .stretchOnly,
      textFitHeight: .proportional,
    );

    test('scales its positions', () {
      expect(options.scaled(1), same(options));
      expect(
        options.scaled(2),
        const StyleImageOptions(
          sdf: true,
          stretchX: [(2, 4)],
          stretchY: [(6, 8)],
          content: Rect.fromLTRB(2, 4, 6, 8),
          textFitWidth: .stretchOnly,
          textFitHeight: .proportional,
        ),
      );
    });

    test('compares by value', () {
      expect(options.scaled(2), options.scaled(2));
      expect(options.scaled(2).hashCode, options.scaled(2).hashCode);
      expect(options, isNot(const StyleImageOptions()));
    });
  });
}
