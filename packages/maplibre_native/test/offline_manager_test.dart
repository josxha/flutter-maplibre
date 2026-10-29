import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre_native/src/offline_manager.dart';
import 'package:maplibre_native_ffi/maplibre_native_ffi.dart' as mln;
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// Reads [definition] back as the C API returns it.
OfflineRegionDefinition _roundTrip(OfflineRegionDefinition definition) =>
    toOfflineRegion(
      mln.OfflineRegionInfo(id: 1, definition: toNativeDefinition(definition)),
    ).definition;

void main() {
  test('converts tile pyramid definitions', () {
    const definition = OfflineTilePyramidRegionDefinition(
      bounds: GeoBox(west: 1, east: 3, south: -3, north: 3),
      styleUrl: 'https://example.com/style.json',
      minZoom: 2,
      maxZoom: double.infinity,
      pixelRatio: 2,
      includeIdeographs: true,
    );
    expect(_roundTrip(definition), definition);
  });

  test('converts geometry definitions', () {
    final definition = OfflineGeometryRegionDefinition(
      geometry: Polygon.from(const [
        [
          Geographic(lon: 1, lat: 1),
          Geographic(lon: 2, lat: 1),
          Geographic(lon: 2, lat: 2),
          Geographic(lon: 1, lat: 1),
        ],
      ]),
      styleUrl: 'https://example.com/style.json',
      minZoom: 0,
      maxZoom: 10,
      pixelRatio: 1,
    );
    final native = toNativeDefinition(definition);
    expect(
      (native as mln.OfflineRegionDefinitionGeometry).value.geometry,
      containsPair('type', 'Polygon'),
    );
    expect(_roundTrip(definition), definition);
  });

  test('converts region status', () {
    final status = toRegionStatus(
      const mln.OfflineRegionStatus(
        downloadState: mln.OfflineRegionDownloadState.active,
        completedResourceCount: 3,
        completedResourceSize: 300,
        completedTileCount: 2,
        completedTileSize: 200,
        requiredResourceCount: 6,
        requiredTileCount: 4,
        requiredResourceCountIsPrecise: true,
      ),
    );
    expect(status.downloadState, OfflineRegionDownloadState.active);
    expect(status.completedTileSize, 200);
    expect(status.progress, 0.5);
    expect(status.complete, isFalse);
  });
}
