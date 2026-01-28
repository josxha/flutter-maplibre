---
sidebar_position: 35
---

# User Interface

To accomplish a unified and easy to use user interface across the different
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
      MapControlButtons(),
      MapCompass(),
    ],
  );
}
```

See the
user [interface page in the example app](https://github.com/josxha/flutter-maplibre/blob/v0.3.3/example/lib/styled_map_page.dart)
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

## Map Control Buttons

Zoom buttons are great for accessibility reasons and great for non-tech-savvy
users to navigate the map. You can use the `MapControlButtons` widget to render
the default zoom buttons on the map.

You are able to toggle an optional `showTrackLocation` flag to display an
additional button to let the user display and track its own position.
The `showTrackLocation` flag will be ignored on web as web has currently not the
same location functionality as other platforms provide.

![Zoom Control Buttons](/img/ui/zoom-buttons.jpg)
