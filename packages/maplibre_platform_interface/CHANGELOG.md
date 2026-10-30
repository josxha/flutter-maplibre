## unreleased

### Breaking Changes

- Removed the `MapOptions` properties `androidMode`, `androidTextureMode`,
  `androidTranslucentTextureSurface`, `androidForegroundLoadColor` and
  `webviewDebugMode`, and the `AndroidPlatformViewMode` enum, whose
  implementations were removed.
- `OfflineManager.downloadRegion` takes an `OfflineRegionDefinition`, and
  `OfflineRegion`, `DownloadProgress` and `OfflineDownloadException` changed;
  `OfflineManager.getRegionStatus` is new. See the maplibre changelog.
- The image methods of `StyleController` take sizes in logical pixels and a
  `pixelRatio`; see the maplibre changelog.
- `MapOptions.style` (a `MapStyle`) replaces `initStyle` and
  `MapController.setStyle`, `MapOptions.initCamera` (an `InitialCamera`)
  replaces `initCenter`, `initZoom`, `initBearing` and `initPitch`, and
  geobase's `GeoBox` replaces `LngLatBounds`. Only the geobase types of the
  API are exported. See the maplibre changelog.
- `StyleController.getAttributions()` and `getAttributionsSync()` are
  replaced by the synchronous getter `StyleController.attributions`.
- `ImageSource` is sealed, with `ImageSource.url`, `ImageSource.bytes` and
  `ImageSource.provider`. See the maplibre changelog.

## 0.3.7+1

[Check the maplibre changelog](https://pub.dev/packages/maplibre/changelog#0371)

## 0.3.7

[Check the maplibre changelog](https://pub.dev/packages/maplibre/changelog#037)

## 0.3.6

[Check the maplibre changelog](https://pub.dev/packages/maplibre/changelog#036)

## 0.3.5

[Check the maplibre changelog](https://pub.dev/packages/maplibre/changelog#035)

## 0.3.4+1

[Check the maplibre changelog](https://pub.dev/packages/maplibre/changelog#0341)

## 0.3.4

[Check the maplibre changelog](https://pub.dev/packages/maplibre/changelog#034)
