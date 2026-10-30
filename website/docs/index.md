---
title: 'Docs'
---

# Overview

This is the documentation of [maplibre](https://pub.dev/packages/maplibre),
MapLibre for Flutter. It renders maps with
[MapLibre Native](https://github.com/maplibre/maplibre-native) on Android,
iOS, macOS, Windows and Linux, and with
[MapLibre GL JS](https://github.com/maplibre/maplibre-gl-js) on web.

!!! info "Version 0.4"

    These docs describe the 0.4 series, available as the pre-release
    `0.4.0-pre.1`. If you upgrade from 0.3.x, read the
    [migration guide](migrate/upgrade-from-v0.3.x.md).

## Getting started

- [Installation](getting-started/setup.md): add the package and check the
  supported platforms.
- [Platform setup](getting-started/platforms.md): the setup each platform
  needs.
- [First map](getting-started/usage.md): show a map and control it.

## Guides

- [Map & Camera](map.md): map options, camera, gestures, feature queries and
  paused rendering.
- [Styles](styles.md): load a map style.
- [Events](events.md): react to taps, camera changes and more.
- [User Interface](ui.md): compass, scale bar, attribution and zoom buttons.
- [User Location](user-location.md): show and follow the location of the
  user.
- [Offline & Cache](offline.md): download regions for offline use.

## Data on the map

- [Annotations](annotations/index.md): circles, markers, polygons, polylines
  and widgets, updated with `setState()`.
- [Sources](sources.md) and [Style Layers](style-layers/index.md): the full
  MapLibre style spec, with typed [expressions](style-layers/expressions.md).

## More

- [Migration guides](migrate/upgrade-from-v0.3.x.md) from earlier versions
  and from other map packages.
- [Architecture](contributing/architecture.md) and
  [Local development](contributing/development.md) for contributors.
