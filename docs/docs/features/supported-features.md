---
sidebar_position: 1
---

# Supported Features

This side provides a broad orientation about what functionality could and what 
functionality is already added.

### Legend

- ✅ implemented
- ❌ not (yet) implemented
- ➖ not supported

### Other Platforms

iOS support is planned. However, there is currently no ETA.

Support for windows, macOS and linux is currently not possible because of the
lack of platform views of these platforms.

- Windows: https://github.com/flutter/flutter/issues/31713
- MacOS: https://github.com/flutter/flutter/issues/41722
- Linux: https://github.com/flutter/flutter/issues/41724

### General Functionality

| Feature             | web | android | iOS | windows | macOS | linux |
|---------------------|-----|---------|-----|---------|-------|-------|
| Map                 | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| MapController       | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| UI Controls for web | ✅   | ➖       | ➖   | ➖       | ➖     | ➖     |
| Offline             | ➖   | ❌       | ❌   | ➖       | ➖     | ➖     |
| Events              | ❌   | ❌       | ❌   | ➖       | ➖     | ➖     |
| Snapshotter         | ❌   | ❌       | ❌   | ➖       | ➖     | ➖     |
| Annotations         | ❌   | ❌       | ❌   | ➖       | ➖     | ➖     |

### Gestures and other Callbacks

| Feature          | web | android | iOS | windows | macOS | linux |
|------------------|-----|---------|-----|---------|-------|-------|
| onMapCreated     | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| onStyleLoaded    | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| onClick          | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| onDoubleClick    | ✅   | ❌       | ❌   | ➖       | ➖     | ➖     |
| onSecondaryClick | ✅   | ❌       | ❌   | ➖       | ➖     | ➖     |
| onLongClick      | ❌   | ✅       | ❌   | ➖       | ➖     | ➖     |

### Map Controller

| Feature                      | web | android | iOS | windows | macOS | linux |
|------------------------------|-----|---------|-----|---------|-------|-------|
| jumpTo                       | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| flyTo                        | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| addSource                    | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| addLayer                     | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| setMyLocationTrackingMode    | ❌   | ❌       | ❌   | ➖       | ➖     | ➖     |
| setMapLanguage               | ❌   | ❌       | ❌   | ➖       | ➖     | ➖     |
| toScreenLocation             | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| toLatLng                     | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| getMetersPerPixelAtLatitude  | ❌   | ❌       | ❌   | ➖       | ➖     | ➖     |