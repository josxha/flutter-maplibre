# maplibre_geolocator

Shows the positions of [geolocator](https://pub.dev/packages/geolocator) with
the `UserLocationLayer` of [maplibre](https://pub.dev/packages/maplibre).

```dart
MapLibreMap(
  options: MapOptions(initStyle: '...'),
  children: [
    UserLocationLayer(locations: geolocatorUserLocations()),
  ],
)
```

`geolocator` asks for the location permission itself; set up each platform
as its documentation describes. See the
[User Location chapter](https://flutter-maplibre.pages.dev/docs/user-location)
for more.
