---
sidebar_position: 3
---

# Map Styles

Custom map styles can be used by setting the `style` parameter of the map
options like so:

```dart
Widget build() {
  return MapLibreMap(
      options: MapOptions(
        style: 'https://demotiles.maplibre.org/style.json',
      )
  );
}
```

The following formats are supported:

1. Passing the URL of the map style. This should be a custom map style served
   remotely using a URL that start with `http(s)://`.
2. Passing the style as a local file. create an JSON file in app directory (e.g.
   ApplicationDocumentsDirectory). Set the style string to the absolute path of
   this JSON file.
3. Passing the raw JSON of the map style. This is only supported on Android.

## Tile sources that require an API key

If your tile source requires an API key, it is recommended to directly append it
to the url as a query parameter.
For example:

```url
https://tiles.example.com/{z}/{x}/{y}.vector.pbf?api_key={your_key}
```

## Use existing styles

Every tile provider provides map styles that you can use. Note, that the style
needs to be compatible with the tile naming scheme. For example OpenMapTiles
styles used by MapTiler are not compatible with Protomaps tiles.

## Create a custom style

Map styles are defined in JSON. MapLibre offers a style editor
called [Maputnik](https://maplibre.org/maputnik)
that allows to customize existing styles or create a new style from scratch.
Other tile providers like MapBox have own editors you can use.

![Maputnik Editor](/img/Maputnik.jpg)