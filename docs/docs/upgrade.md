---
sidebar_position: 100
title: 'Upgrade from 0.0.x'
---

# Upgrade from version 0.0.x

Version `0.1.0` introduced some breaking changes. This site will guide you
through all of them.

## General Information on Breaking Changes

We are using
the [pub.dev version convention](https://dart.dev/tools/pub/versioning) for the
package.

While the package is prior its `1.0.0` release, the following rules apply:

- Every minor `0.x.0` release can introduce breaking changes.
- Every increase of the patch value `0.0.x` adds new features and functionality.
- Every increase of 0.0.1+x indicates changes that don't affect the public API
  like bug fixes.

By setting `^0.1.0` in your pubspec.yaml file pub will automatically resolve a
compatible package version but won't use the next breaking release `0.2.0`.

Read [Semantic versions](https://dart.dev/tools/pub/versioning#semantic-versions)
for more information.

## Step-by-Step guide

### 1. Compatible Flutter Version

Version `0.1.0` increased the minimum allowed version of Flutter
to [3.24](https://medium.com/flutter/whats-new-in-flutter-3-24-6c040f87d1e4).

Run `flutter upgrade` to upgrade Flutter.

### 2. Name Changes

Some properties and class names have changed. Replace the old with the new
names.

| Old Name               | New Name                   |
|------------------------|----------------------------|
| controller.jumpTo()    | controller.moveCamera()    |
| controller.flyTo()     | controller.animateCamera() |
| MapOptions(controls: ) | MapOptions(webControls: )  |
| MapControl()           | WebMapControl()            |
| ScaleControl()         | WebScaleControl()          |
| LogoControl()          | WebLogoControl()           |
| GeolocateControl()     | WebGeolocateControl()      |
| FullscreenControl()    | WebFullscreenControl()     |
| NavigationControl()    | WebNavigationControl()     |
| mapCamera.tilt         | mapCamera.pitch            |

### 3. Use the event system

Callbacks have been replaced by Events that get emitted by the Map.
Check out the [Map Events](./events) documentation to see how you can use them.

| Old Callback Name | New Event Class        |
|-------------------|------------------------|
| onClick           | MapEventClick          |
| onDoubleClick     | MapEventDoubleClick    |
| onSecondaryClick  | MapEventSecondaryClick |
| onLongClick       | MapEventLongClick      |