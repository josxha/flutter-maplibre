---
sidebar_position: 45
---

# Offline

The `OfflineManager` provides a set of tools to manage the cache and handle
offline maps. It enables users to download and interact with map data in areas
with limited or no internet access. Here, we’ll cover key features, usage
concepts, and API details for `OfflineManager`.

:::info
The features described on this site have been added in version `0.1.2`.
:::

The download manager needs to be created asynchronous by
using `OfflineManager.createInstance()`. You can store the instance for later
use.

```dart
Future<OfflineManager> futureManager = OfflineManager.createInstance();
```

Don't forget to call `manager.dispose()` when you no longer need it. You
can do this for example in the `dispose` override of a flutter widget:

```dart
@override
void dispose() {
  // highlight-next-line
  manager.dispose();
  super.dispose();
}
```

## Downloading Map Regions

Using OfflineManager, you can bulk-download specific map regions for offline
access.

```dart
Future<void> downloadMyMap() async {
  final stream = await manager.downloadRegion(
    minZoom: 10,
    maxZoom: 14,
    bounds: LngLatBounds(/* ... */),
    mapStyleUrl: '...',
    pixelDensity: 1,
  );
  await for (final update in stream) {
    if (update.downloadCompleted) {
      print('region downloaded: ${update.region}');
    } else {
      print(
        '${update.loadedTiles} / ${update.totalTiles} '
            '(${((update.progress ?? 0) * 100).toStringAsFixed(0)}%)',
      );
    }
  }
}
```

## Managing Offline Regions

After regions are downloaded, they can be managed using methods to list, merge,
or retrieve specific region details:

### Listing Offline Regions

Get a list of all downloaded regions for management or display purposes by
using `manager.listOfflineRegions()`.

### Retrieving a Specific Region

Fetch a region’s details with `manager.getOfflineRegion(regionId: 1)`, which is
useful for managing or displaying region-specific data.

### Merging Regions

Use `manager.mergeOfflineRegions(path: 'path/to/database')` to merge offline
regions from a secondary MapLibre Native database into the main offline database.
This is typically used when you have multiple MapLibre offline databases that you
want to consolidate.

### Cache Management

There are mutliple methods to manage and control the cache, ensuring efficient
use of storage. Head over to
the [API docs](https://pub.dev/documentation/maplibre/latest/maplibre/OfflineManager-class.html)
to learn more.