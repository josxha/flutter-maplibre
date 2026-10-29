import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

void main() {
  group('MapStyle', () {
    test('compares by type and value', () {
      expect(const MapStyle.url('a'), const MapStyle.url('a'));
      expect(
        const MapStyle.url('a').hashCode,
        const MapStyle.url('a').hashCode,
      );
      expect(const MapStyle.url('a'), isNot(const MapStyle.url('b')));
      expect(const MapStyle.url('a'), isNot(const MapStyle.asset('a')));
      expect(const MapStyle.asset('a'), isNot(const MapStyle.file('a')));
      expect(const MapStyle.json('{}'), const MapStyle.json('{}'));
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

  group('InitialCamera', () {
    const bounds = GeoBox(west: -10, south: -5, east: 10, north: 5);

    test('position defaults to zoom 0 at 0, 0', () {
      expect(const InitialCamera.position(), const InitialCameraPosition());
      expect(
        const InitialCamera.position(zoom: 3),
        isNot(const InitialCamera.position(zoom: 4)),
      );
    });

    test('bounds compares by value', () {
      expect(
        const InitialCamera.bounds(bounds, padding: EdgeInsets.all(8)),
        const InitialCamera.bounds(bounds, padding: EdgeInsets.all(8)),
      );
      expect(
        const InitialCamera.bounds(bounds),
        isNot(const InitialCamera.bounds(bounds, pitch: 30)),
      );
      expect(
        const InitialCamera.bounds(bounds),
        isNot(
          const InitialCamera.bounds(
            GeoBox(west: -10, south: -5, east: 10, north: 6),
          ),
        ),
      );
    });

    test('is not set by default, so the style camera applies', () {
      expect(const MapOptions().initCamera, isNull);
    });
  });

  group('MapOptions', () {
    test('compares by value', () {
      expect(
        const MapOptions(
          style: MapStyle.asset('style.json'),
          initCamera: InitialCamera.position(zoom: 3),
          maxBounds: GeoBox(west: 0, south: 0, east: 1, north: 1),
        ),
        const MapOptions(
          style: MapStyle.asset('style.json'),
          initCamera: InitialCamera.position(zoom: 3),
          maxBounds: GeoBox(west: 0, south: 0, east: 1, north: 1),
        ),
      );
      expect(
        const MapOptions(),
        isNot(const MapOptions(style: MapStyle.asset('style.json'))),
      );
    });
  });

  group('MapCamera', () {
    const camera = MapCamera(
      center: Geographic(lon: 12, lat: 2),
      zoom: 2,
      bearing: 213,
      pitch: 12,
    );

    test('compares by value', () {
      expect(
        camera,
        const MapCamera(
          center: Geographic(lon: 12, lat: 2),
          zoom: 2,
          bearing: 213,
          pitch: 12,
        ),
      );
      for (final other in const [
        MapCamera(
          center: Geographic(lon: 13, lat: 2),
          zoom: 2,
          bearing: 213,
          pitch: 12,
        ),
        MapCamera(
          center: Geographic(lon: 12, lat: 2),
          zoom: 3,
          bearing: 213,
          pitch: 12,
        ),
        MapCamera(
          center: Geographic(lon: 12, lat: 2),
          zoom: 2,
          bearing: 0,
          pitch: 12,
        ),
        MapCamera(
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
        'MapCamera(center: Geographic(lon: 12.0, lat: 2.0), zoom: 2.0, '
        'bearing: 213.0, pitch: 12.0)',
      );
    });
  });

  group('RenderedFeature', () {
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
    test('all and none', () {
      const all = MapGestures.all();
      const none = MapGestures.none();
      expect(all.allEnabled, isTrue);
      expect(none.allEnabled, isFalse);
      expect([all.pan, all.zoom, all.rotate, all.pitch], everyElement(isTrue));
      expect([
        none.pan,
        none.zoom,
        none.rotate,
        none.pitch,
      ], everyElement(isFalse));
    });

    test('compares by value', () {
      const all = MapGestures(rotate: true, pan: true, zoom: true, pitch: true);
      expect(all, const MapGestures.all());
      expect(all.hashCode, const MapGestures.all().hashCode);
      const noPitch = MapGestures.all(pitch: false);
      expect(noPitch.allEnabled, isFalse);
      expect(noPitch, isNot(all));
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
        const MapEventDoubleClick(point: point, screenPoint: screenPoint),
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
      const camera = MapCamera(center: point, zoom: 1, bearing: 0, pitch: 0);
      expect(const MapEventMoveCamera(camera: camera).camera, camera);
      expect(
        const MapEventStartMoveCamera(reason: CameraChangeReason.apiGesture)
            .reason,
        CameraChangeReason.apiGesture,
      );
    });
  });
}
