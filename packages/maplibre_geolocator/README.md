# maplibre_geolocator

Shows the positions of [geolocator](https://pub.dev/packages/geolocator) with
the `UserLocationLayer` of [maplibre](https://pub.dev/packages/maplibre).

```dart
MapLibreMap(
  options: MapOptions(style: MapStyle.url('...')),
  children: [
    UserLocationLayer(locations: geolocatorUserLocations()),
  ],
)
```

Ask for the location permission before the layer listens, for example with
`Geolocator.requestPermission()`, and set up each platform as the
`geolocator` documentation describes. On Windows, positions arrive only
after the app asked, and `permission_handler` does not ask there. See the
[User Location chapter](https://flutter-maplibre.pages.dev/docs/user-location)
for more.
