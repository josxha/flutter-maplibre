---
title: 'Images & Video'
description: 'Place an image or a video on the map.'
icon: lucide/image
---

# Image and Video Sources

Image and video sources place one image or video at four coordinates on the
map. Show them with a [`RasterStyleLayer`](../style-layers/index.md#raster).

## Image

Use
the [ImageSource](https://pub.dev/documentation/maplibre/latest/maplibre/ImageSource-class.html)
if you want to render an image on the map. `ImageSource.url` loads the image
from a URL, `ImageSource.bytes` takes an encoded image such as a PNG, and
`ImageSource.provider` takes any Flutter `ImageProvider`, for example an
`AssetImage` or a `FileImage`.

```dart
await style.sources.add(
  const ImageSource.provider(
    id: 'radar',
    image: AssetImage('assets/radar.png'),
    coordinates: LngLatQuad(
      topLeft: Geographic(lon: -80.425, lat: 46.437),
      topRight: Geographic(lon: -71.516, lat: 46.437),
      bottomRight: Geographic(lon: -71.516, lat: 37.936),
      bottomLeft: Geographic(lon: -80.425, lat: 37.936),
    ),
  ),
);
```

An example use case is to position a weather radar image on the map. Move the
image with `style.sources.updateImageCoordinates('radar', coordinates)`.

## Video

Likewise,
the [VideoSource](https://pub.dev/documentation/maplibre/latest/maplibre/VideoSource-class.html)
can be used to render a video on the map, from URLs with `VideoSource.urls`,
encoded video bytes with `VideoSource.bytes` or a Flutter asset with
`VideoSource.asset`.

The video source is only supported on web.
