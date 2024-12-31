---
sidebar_position: 4
title: 'Use the Widget'
---

# Use the Widget

## Display your first Map

Import the maplibre package and use the `MapLibreMap` widget to display a
map.

```dart title="map_screen.dart"
import 'package:flutter/material.dart';

// highlight-next-line
import 'package:maplibre/maplibre.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State createState() => FullMapState();
}

class MapScreenState extends State<MapScreen> {
  MapController? _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // highlight-start
      body: MapLibreMap(
        onMapCreated: (controller) {
          // Don't add additional annotations here,
          // wait for the onStyleLoadedCallback.
          _mapController = controller;
        },
        onStyleLoaded: (style) {
          debugPrint('Map loaded 😎');
        },
      ),
      // highlight-end
    );
  }
}
```

The result should look something like this:

![First map](/img/first_map.jpg)

If the map style isn't specified, the default MapLibre style is used. Read
the [Styles](../styles) chapter to learn how to use other styles.