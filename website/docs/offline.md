---
icon: lucide/database
---

# Offline & Cache

!!! note

    The `OfflineManager` runs on Android, iOS, macOS, Windows and Linux. On
    web, `OfflineManager.createInstance()` throws an `UnsupportedError`; a
    service worker cache is the alternative there.

Maps and the `OfflineManager` share one database, `maplibre_native.db` in the
app support directory. Maps cache the resources they load in it, and show the
regions you downloaded without network access.

The `OfflineManager` provides a set of tools to manage the cache and handle
offline maps. It enables users to download and interact with map data in areas
with limited or no internet access. Here, we’ll cover key features, usage
concepts, and API details for `OfflineManager`.

The download manager needs to be created asynchronous by
using `OfflineManager.createInstance()`. You can store the instance for later
use.

```dart

Future<OfflineManager> futureManager = OfflineManager.createInstance();
```

Don't forget to call `manager.dispose()` when you no longer need it. You
can do this for example in the `dispose` override of a flutter widget:

```dart hl_lines="3"
@override
void dispose() {
  manager.dispose();
  super.dispose();
}
```

## Cache Management

There are mutliple methods to manage and control the cache, ensuring efficient
use of storage. Head over to
the [API docs](https://pub.dev/documentation/maplibre/latest/maplibre/OfflineManager-class.html)
to learn more.

## Downloading Map Regions

Using OfflineManager, you can bulk-download specific map regions for offline
access. An `OfflineRegionDefinition` says what a region covers:

- `OfflineTilePyramidRegionDefinition` downloads every tile within
  `LngLatBounds`.
- `OfflineGeometryRegionDefinition` downloads only the tiles that a geometry
  touches, such as a route as a `LineString` or an area as a `Polygon`. It
  needs far fewer tiles than the bounding box of a long or diagonal route.

Both download the tiles from `minZoom` to `maxZoom`, or to the maximum zoom
level of each tile source if that is lower.

```dart
Future<void> downloadMyMap() async {
  final stream = manager.downloadRegion(
    definition: OfflineTilePyramidRegionDefinition(
      bounds: LngLatBounds(/* ... */),
      styleUrl: '...',
      minZoom: 10,
      maxZoom: 14,
      pixelRatio: 1,
    ),
    metadata: {'name': 'Bregenz'},
  );
  await for (final update in stream) {
    if (update.downloadCompleted) {
      print('region downloaded: ${update.region}');
    } else {
      final status = update.status;
      print(
        '${status.completedResourceCount} / ${status.requiredResourceCount} '
            '(${((update.progress ?? 0) * 100).toStringAsFixed(0)}%)',
      );
    }
  }
}

final route = OfflineGeometryRegionDefinition(
  geometry: LineString.from(const [
    Geographic(lon: 9.7471, lat: 47.5031),
    Geographic(lon: 9.6838, lat: 47.5459),
  ]),
  styleUrl: '...',
  minZoom: 10,
  maxZoom: 15,
  pixelRatio: 1,
);
```

Resources that fail to load arrive as `OfflineResourceException` errors on
the stream, with the `reason` they failed, and the download retries them. A
region with more tiles than MapLibre Native allows stops with an
`OfflineTileCountLimitException`. Cancelling the subscription pauses the
download; `manager.resumeDownload(regionId: id)` continues it.

`manager.getRegionStatus(regionId: id)` reports how far the download of a
region got, also while no download runs: the downloaded and required resources
and tiles, their size, and whether it is complete.

## Managing Offline Regions

After regions are downloaded, they can be managed using methods to list, merge,
or retrieve specific region details:

### Listing Offline Regions

Get a list of all downloaded regions for management or display purposes by
using `manager.listOfflineRegions()`.

### Retrieving a Specific Region

Fetch a region’s details with `manager.getOfflineRegion(regionId: 1)`, which is
useful for managing or displaying region-specific data. It returns null when
there is no region with that id.

### Merging Regions

Use `manager.mergeOfflineRegions(path: 'path/to/database')` to merge offline
regions from a secondary MapLibre Native database into the main offline database.
This is typically used when you have multiple MapLibre offline databases that you
want to consolidate.

### Updating and Deleting Regions

`manager.updateRegionMetadata(regionId: 1, metadata: {...})` replaces the
metadata of a region, `manager.invalidateRegion(regionId: 1)` loads its
resources again once they are needed, and `manager.deleteRegion(regionId: 1)`
removes it.