---
title: 'Widget'
description: 'Add Flutter Widget to the map.'
icon: lucide/layout-grid
---

# Widget Annotations

The `WidgetLayer` jumps a bit out of the row when compared to the other
annotation layers.

## Differences to other Layers

- The `WidgetLayer` is the only built-in map layer that has support for all kind
  of flutter widgets.
- As the `WidgetLayer` is just a Widget itself, it needs to be placed in
  the `children` list. All the map layers need to be placed in the `layers`
  list.
- `WidgetLayer`s will always be displayed above other layers as it is not part
  of the map style but displayed above.

## Basic Usage

```dart linenums="1" hl_lines="11-29"
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Widget Layer')),
    body: MapLibreMap(
      options: MapOptions(
        initZoom: 3,
        initCenter: Geographic(lon: 0, lat: 0),
      ),
      children: [
        WidgetLayer(
          markers: [
            Marker(
              // must be the same dimension as the inner widget
              size: const Size.square(50),
              // the longitude / latitude position on the map
              point: Geographic(lon: -10, lat: 0),
              // child can be any flutter widget tree
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
                // must be the same as Marker.size
                size: 50,
              ),
              // the used Icon should be attached to the map at the bottom center 
              alignment: Alignment.bottomCenter,
            ),
          ],
        ),
        // display the UI widgets above the widget markers.
        const SourceAttribution(),
      ],
    ),
  );
}
```

By default, widgets in the `WidgetLayer` will stay upright when the map gets
rotated or pitched. You are able to change this behavior with the `flat`
and `rotate` flags.

## Clustering

Set `cluster: true` to group markers that are close to each other on screen
into clusters. Unlike the native clustering of the
[`MarkerLayer`](markers.md#clustering), widget marker clustering is computed in
Dart based on the on-screen distance between markers, so clusters split apart as
you zoom in.

```dart
WidgetLayer(
  markers: _markers,
  cluster: true,
  // markers within 80 logical pixels are grouped together
  clusterRadius: 80,
  // at least 2 markers are needed to form a cluster
  clusterMinPoints: 2,
  // the size of the cluster widget (used for positioning)
  clusterSize: const Size.square(40),
  // optional: provide your own cluster widget
  clusterBuilder: (context, cluster) => GestureDetector(
    onTap: () {
      // e.g. animate the camera to cluster.point
    },
    child: DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Center(child: Text('${cluster.markers.length}')),
    ),
  ),
),
```

If you don't provide a `clusterBuilder`, a default circular badge showing the
number of markers is used. The `MarkerCluster` passed to the builder contains
the grouped `markers` and their geographic center `point`.

Tapping a cluster animates the camera to the cluster and zooms in by two levels
(which usually splits it apart). Provide an `onClusterTap` callback to customize
this behavior, e.g. to fit all of the cluster's markers into view.

!!! note

    Widget marker clustering recomputes on every camera movement and compares
    every marker with every other marker. It is intended for a moderate number
    of markers. For large datasets prefer the native clustering of the
    [`MarkerLayer`](markers.md#clustering).

## Update

To add, remove or alter annotation layers, just use `setState()` like you'd do
with Flutter widgets.

Check out
the [example app](https://github.com/josxha/flutter-maplibre/blob/v0.3.4/examples/lib/widget_layer_page.dart)
if you want to see how things come together.
