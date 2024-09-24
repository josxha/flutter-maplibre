## unreleased

### Features

- Add event system to the map.
- Bump MapLibre Native on Android to version 11.5.0.
- Add and remove sources to the active map style programmatically.
- Add and remove layers to the active map style programmatically.
- Add `minZoom`, `maxZoom`, `minTilt`, `maxTilt` and `maxBounds` parameter.
- Add `duration` parameter to `flyTo()`.
- `flyTo()` returns after the animation completes or throws an exception if it
  has been cancelled.

### Bug fixes

- Fix `jumpTo()` never returns on Android.

## 0.0.1+1

- Fix urls to website and embedded screenshots
- Remove unused `plugin_platform_interface` dependency

## 0.0.1

- Initial release
- Implement map for android and web
- Add docs
