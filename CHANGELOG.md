## unreleased

### Features

- Add event system to the map.
- Add and remove sources to the active map style programmatically.
- Add and remove layers to the active map style programmatically.
- Add `minZoom`, `maxZoom`, `minPitch`, `maxPitch` and `maxBounds` parameter.
- Add duration parameters to `flyTo()`.
- `flyTo()` returns after the animation completes or throws an exception if it
  has been cancelled.
- Deprecate `tilt` parameters in favor of `pitch`.
- Deprecate `onClick`, `onDoubleClick`, `onSecondaryClick` and `onLongClick` in
  favor of the event system.

### Bug fixes

- Fix `jumpTo()` never returns on Android.

## 0.0.1+1

- Fix urls to website and embedded screenshots
- Remove unused `plugin_platform_interface` dependency

## 0.0.1

- Initial release
- Implement map for android and web
- Add docs
