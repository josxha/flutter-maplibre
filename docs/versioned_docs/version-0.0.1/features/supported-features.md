---
sidebar_position: 1
---

# Supported Features

This is a broad orientation about what functionality could be added. The list
is orientated on MapLibre GL JS and the flutter-maplibre-gl map controller.
Some controller methods will be changed to provide a different annotation API.

| Feature                                  | web | android | iOS | windows | macOS | linux |
|------------------------------------------|-----|---------|-----|---------|-------|-------|
| Map                                      | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| MapController                            | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| maplibre-gl-js Web Controls              | ✅   | ➖       | ➖   | ➖       | ➖     | ➖     |
| Offline                                  | ➖   | ❌       | ❌   | ➖       | ➖     | ➖     |
| click callback                           | ✅   | ❌       | ❌   | ➖       | ➖     | ➖     |
| long click callback                      | ❌   | ❌       | ❌   | ➖       | ➖     | ➖     |
| secondary click callback                 | ✅   | ❌       | ❌   | ➖       | ➖     | ➖     |
| controller.jumpTo()                      | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| controller.flyTo()                       | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| controller.addSource()                   | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| controller.addLayer()                    | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| controller.setMyLocationTrackingMode()   | ❌   | ❌       | ❌   | ➖       | ➖     | ➖     |
| controller.setMapLanguage()              | ❌   | ❌       | ❌   | ➖       | ➖     | ➖     |
| controller.toScreenLocation()            | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| controller.toLatLng()                    | ✅   | ✅       | ❌   | ➖       | ➖     | ➖     |
| controller.getMetersPerPixelAtLatitude() | ❌   | ❌       | ❌   | ➖       | ➖     | ➖     |

#### Legend

- ✅ implemented
- ❌ not (yet) implemented
- ➖ not supported

Support for windows, macOS and linux is currently not possible because of the
lack of platform views of these platforms.

- Windows: https://github.com/flutter/flutter/issues/31713
- MacOS: https://github.com/flutter/flutter/issues/41722
- Linux: https://github.com/flutter/flutter/issues/41724