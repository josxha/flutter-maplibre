---
title: Features
hide: [ navigation ]
---

# Supported Features

This page gives an overview of the functionality that is available on each
platform. Android, iOS, macOS, Windows and Linux share one implementation on
the MapLibre Native C API.

### General Functionality

| Feature       | Web | Android | iOS | Windows | macOS | Linux |
|---------------|-----|---------|-----|---------|-------|-------|
| Map           | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| MapController | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Offline       | ❌   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Events        | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Annotations   | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Widget Layer  | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| User Location | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Paused Rendering | ➖ | ✅      | ✅   | ✅       | ✅     | ✅     |
| Globe Projection | ✅ | ❌      | ❌   | ❌       | ❌     | ❌     |
| MBTiles       | ❌   | ✅       | ✅   | ✅       | ✅     | ✅     |
| PMTiles       | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |

### Layers

| Feature              | Web | Android | iOS | Windows | macOS | Linux |
|----------------------|-----|---------|-----|---------|-------|-------|
| Background Layer     | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Circle Layer         | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Fill Layer           | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Fill Extrusion Layer | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Heatmap Layer        | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Hillshade Layer      | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Line Layer           | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Raster Layer         | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Symbol Layer         | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Color Relief Layer   | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |

### Sources

| Feature        | Web | Android | iOS | Windows | macOS | Linux |
|----------------|-----|---------|-----|---------|-------|-------|
| GeoJSON Source | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Image Source   | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Video Source   | ✅   | ❌       | ❌   | ❌       | ❌     | ❌     |
| Raster Source  | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Raster DEM Source | ✅ | ✅      | ✅   | ✅       | ✅     | ✅     |
| Vector Source  | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |

### User Gestures

| Feature         | Web | Android | iOS | Windows | macOS | Linux |
|-----------------|-----|---------|-----|---------|-------|-------|
| click           | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| double click    | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| secondary click | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| long click      | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| pan, pinch zoom, twist, tilt | ✅ | ✅ | ✅ | ✅  | ✅     | ✅     |
| scroll wheel zoom | ✅ | ✅      | ✅   | ✅       | ✅     | ✅     |
| mouse rotate and tilt | ✅ | ✅   | ✅   | ✅       | ✅     | ✅     |

### Programmatic Control

| Feature                                | Web | Android | iOS | Windows | macOS | Linux |
|----------------------------------------|-----|---------|-----|---------|-------|-------|
| Move Map Camera                        | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Animate Map Camera                     | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Add or remove a Map Source             | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Add or remove a Map Layer              | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Show the User Location                 | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Track the User Location                | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Convert Coordinates to Screen Position | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Convert Screen Position to Coordinates | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Get Meters per Pixel                   | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Get the currently visible Region       | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |
| Query rendered Features                | ✅   | ✅       | ✅   | ✅       | ✅     | ✅     |

➖ On web, the browser already skips hidden maps, so `MapLibreMap.paused` has
no effect there.
