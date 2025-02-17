# Supported Features

This side provides a broad orientation about what functionality could and what
functionality is already added.

### Legend

- ✅ implemented
- ❌ not (yet) implemented
- ➖ not supported

### Other Platforms

iOS support is worked on. See the current progress in [#26](https://github.com/josxha/flutter-maplibre/issues/26).

Support for windows, macOS and linux is currently not possible because of the
lack of platform views of these platforms.

- Windows: https://github.com/flutter/flutter/issues/31713
- MacOS: https://github.com/flutter/flutter/issues/41722
- Linux: https://github.com/flutter/flutter/issues/41724

### General Functionality

| Feature       | web | android | iOS | windows | macOS | linux |
|---------------|-----|---------|-----|---------|-------|-------|
| Map           | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| MapController | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| Offline       | ➖   | ✅       | ❌   | ➖       | ➖     | ➖     |
| Events        | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| Annotations   | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| MBTiles       | ➖   | ✅       | ❌   | ➖       | ➖     | ➖     |
| PMTiles       | ❌   | ✅       | ❌   | ➖       | ➖     | ➖     |

### Style Layers

| Feature              | web | android | iOS | windows | macOS | linux |
|----------------------|-----|---------|-----|---------|-------|-------|
| Circle Layer         | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| Fill Layer           | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| Fill Extrusion Layer | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| Heatmap Layer        | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| Hillshade Layer      | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| Line Layer           | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| Raster Layer         | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| Symbol Layer         | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |

### User Gestures

| Feature         | web | android | iOS | windows | macOS | linux |
|-----------------|-----|---------|-----|---------|-------|-------|
| click           | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| double click    | ✅   | ❌       | ❌   | ➖       | ➖     | ➖     |
| secondary click | ✅   | ❌       | ❌   | ➖       | ➖     | ➖     |
| long click      | ❌   | ✅       | ❌   | ➖       | ➖     | ➖     |

### Programmatic Control

| Feature                                | web | android | iOS | windows | macOS | linux |
|----------------------------------------|-----|---------|-----|---------|-------|-------|
| Move Map Camera                        | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| Animate Map Camera                     | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| Add or remove a Map Source             | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| Add or remove a Map Layer              | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| Show the User Location                 | ❌   | ✅       | ❌   | ➖       | ➖     | ➖     |
| Track the User Location                | ❌   | ✅       | ❌   | ➖       | ➖     | ➖     |
| Convert Coordinates to Screen Position | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| Convert Screen Position to Coordinates | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| Get Meters per Pixel                   | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| Get the currently visible Region       | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |