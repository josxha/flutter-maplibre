---
sidebar_position: 100
title: 'Upgrade from 0.2.x'
---

# Upgrade from version 0.2.x

Version `0.3.0` introduced some breaking changes. This site will guide you
through all of them.

## General Information on Breaking Changes

We are using
the [pub.dev version convention](https://dart.dev/tools/pub/versioning#semantic-versions)
for the package. While the package is prior its `1.0.0` release, the following
rules apply:

- Every minor `0.x.0` release can introduce breaking changes.
- Every increase of the patch value `0.0.x` adds new features and functionality.
- Every increase of 0.0.1+x indicates changes that don't affect the public API
  like bug fixes.

## Step-by-Step guide

### 1. iOS Support

Version `0.3.0` finally added iOS as a supported platform. Head over to
[Setup iOS](getting-started/setup-ios) to read how to use.

### 2. Migration to the `geobase` package

`maplibre` was previously based on a package
called [geotypes](https://pub.dev/packages/geotypes) for easy use
with [turf](https://pub.dev/packages/turf). The package now uses the
package [geobase](https://pub.dev/packages/geobase) instead.
All `geobase` classes are exported together with the default `maplibre` import.
Head over to the geobase documentation to learn on how to
use: https://geospatial.navibyte.dev/v1/geobase/

The most noticeable change will be to change usages of `Position` to
`Geographic`.

### 3. Name Changes

Some properties and class names have changed. Replace the old with the new
names.

| Old Name                    | New Name                          |
|-----------------------------|-----------------------------------|
| MapCompass.rotationDuration | MapCompass.nativeRotationDuration |

### 4. Changed return types and removed methods

With the ongoing effort towards a complete interop implementation, more methods
are now called synchronously.

- `MapController.toScreenLocation()`
- `MapController.toLngLat()`
- `MapController.toScreenLocations()`
- `MapController.toLngLats()`
- `MapController.getMetersPerPixelAtLatitude()`
- `MapController.getVisibleRegion()`
- `MapController.queryLayers()`

Previously added synchronous overloads are no longer required and therefore
removed.

- `MapController.toScreenLocationSync()`
- `MapController.toLngLatSync()`
- `MapController.toScreenLocationsSync()`
- `MapController.toLngLatsSync()`
- `MapController.getMetersPerPixelAtLatitudeSync()`
- `MapController.getVisibleRegionSync()`