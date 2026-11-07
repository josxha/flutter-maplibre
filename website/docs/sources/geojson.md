---
title: 'GeoJSON'
description: 'Add points, lines and polygons from GeoJSON, and cluster points.'
icon: lucide/braces
---

# GeoJSON Source

You can use
the [GeoJsonSource](https://pub.dev/documentation/maplibre/latest/maplibre/GeoJsonSource-class.html)
to attach data like points, lines or polygons, from a GeoJSON file with
`GeoJsonSource.url` or from `GeoJsonData` with `GeoJsonSource.data`. The data can then be used in a
[CircleStyleLayer](../style-layers/index.md#circle),
[FillStyleLayer](../style-layers/index.md#fill),
[HeatmapStyleLayer](../style-layers/index.md#heatmap),
[LineStyleLayer](../style-layers/index.md#line) or
[SymbolStyleLayer](../style-layers/index.md#symbol).

`GeoJsonData` takes geobase objects, or GeoJSON that you already have as text
or as decoded JSON. Text skips building objects in Dart, which matters for large
data: on web the browser parses it.

```dart
// geobase objects
await style.sources.add(
  GeoJsonSource.data(
    id: 'points',
    data: .featureCollection(
      FeatureCollection([
        Feature(geometry: Point(Geographic(lon: 9.17, lat: 47.68))),
      ]),
    ),
  ),
);

// GeoJSON text, such as a file or a response body
await style.sources.add(
  GeoJsonSource.data(id: 'routes', data: .text(response.body)),
);
```

## Clusters

A `GeoJsonCluster` groups nearby points into clusters. Cluster features have
the properties `cluster`, `cluster_id` and `point_count`, plus the cluster
properties you define:

```dart
await style.sources.add(
  GeoJsonSource.url(
    id: 'earthquakes',
    url: 'https://example.com/earthquakes.geojson',
    cluster: GeoJsonCluster(
      radius: 50,
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
  ),
);

final clusterId = feature.properties['cluster_id']! as int;
final zoom = await controller.getClusterExpansionZoom('earthquakes', clusterId);
final points = await controller.getClusterLeaves('earthquakes', clusterId, limit: 100);
final children = await controller.getClusterChildren('earthquakes', clusterId);
```

## Update the data

Replace the data of a GeoJSON source without removing its layers:

```dart
await style.sources.updateGeoJsonData('points', .text(geoJsonString));
await style.sources.updateGeoJsonUrl('points', 'https://example.com/data.geojson');
```

Large updates don't block the UI thread, as the map prepares the data in the
background (not on web).
