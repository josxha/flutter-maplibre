---
sidebar_position: 30
---

# Styles

By default, the default MapLibre style gets used which shows only countries.
To change this use the style of a tile provider or create and use your own map
style.

Custom map styles can be used by setting the `style` parameter of the map
options like so:

```dart
Widget build() {
  return MapLibreMap(
      options: MapOptions(
        center: Position(9.17, 47.68),
        // highlight-next-line
        style: 'https://demotiles.maplibre.org/style.json',
      )
  );
}
```

The following formats are supported:

1. Passing the URL of the map style. This should be a custom map style served
   remotely using a URL that starts with `http(s)://`.
2. Passing the style as a local file. Create a JSON file in the app directory
   (e.g. ApplicationDocumentsDirectory). Then, set the style string to
   the absolute path of this JSON file.
3. Passing the raw JSON of the map style.

## Tile sources that require an API key

If your tile source requires an API key, it is recommended to directly append it
to the url as a query parameter.
For example:

```url
https://tiles.example.com/{z}/{x}/{y}.pbf?api_key={your_key}
```

## Use existing styles

Every tile provider provides map styles that you can use.

:::warning

Note, that the style
needs to be compatible with the tile schema used by the tile server.
For example OpenMapTiles styles used by MapTiler are not compatible with
Protomaps tiles.

:::

Have a look at
the [awesome-maplibre](https://github.com/maplibre/awesome-maplibre#maptile-providers)
list to get an overview over available tile
providers that support the MVT standard.

## Create a custom style

Map styles are defined in JSON. MapLibre offers a style editor
called [Maputnik](https://maplibre.org/maputnik)
that allows to customize existing styles or create a new style from scratch.
Other tile providers like MapBox have own editors you can use.

![Maputnik Editor](/img/maputnik.jpg)