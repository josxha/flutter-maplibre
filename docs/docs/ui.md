---
sidebar_position: 35
---

# User Interface

:::info
The features described on this site have been added in version `0.1.1`.
:::

To accomplish a unified and easy to use user interface across the differerent
platforms, the package has some flutter widgets, that are rendered above the
map. These UI elements are just like every other Flutter widgets and can be used
in the `children` List of the `MapLibreMap` widget.

```dart
@override
Widget build(BuildContext context) {
  return MapLibreMap(
    // ...
    children: <Widget>[
      MapScalebar(),
      SourceAttribution(),
      MapZoomButtons(),
      MapCompass(),
    ],
  );
}
```

See the
user [interface page in the example app](https://github.com/josxha/flutter-maplibre/blob/main/example/lib/user_interface_page.dart)
for a full implementation.

All widgets inside the `children` List are within the `MapLibreMap` context and
have access to the following helpful functions.

- `MapController.maybeOf()`
- `MapController.of()`
- `MapCamera.maybeOf()`
- `MapCamera.of()`

## Source Attribution

Many sources require proper attribution to comply with their licensing or terms
of service. Use the `SourceAttribution` widget that fetches the attached
attributions and displays them on the map.

![Attribution](/img/ui/attribution.jpg)

## Map Compass

The `MapCompass` widget helps the user orientating by indicating north and
gives the user the open to reset the map rotation with a click on the compass.

![Compass](/img/ui/compass.jpg)

## Map Scalebar

The `MapScalebar` widget shows the current scale of the map center for the
current latitude and zoom level.

![Scalebar](/img/ui/scalebar.jpg)

## Map Zoom Buttons

Zoom buttons are great for accessability reasons and great for non tech savvy
users to navigate the map. You can use the `MapZoomButtons` widget to render the
default zoom buttons on the map.

![Zoom Buttons](/img/ui/zoom-buttons.jpg)
