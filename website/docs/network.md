---
icon: lucide/globe
---

# Network

`MapLibreNetwork` holds static settings for how maps request their styles,
tiles, glyphs, sprites and images. They apply to every map, the ones that
exist and the ones created later, and to the downloads of the
[`OfflineManager`](offline.md). A change reaches the requests that follow it;
resources that are already loaded or cached stay as they are.

## Request headers

`requestHeaders` sends extra HTTP headers, for example an API key for your
own tile server:

```dart
MapLibreNetwork.requestHeaders = [
  RequestHeaders(
    {'Authorization': 'Bearer $token'},
    url: 'https://tiles.example.com/**',
  ),
  RequestHeaders(
    {'X-Client': 'my-app'},
    kinds: {MapResourceKind.style},
  ),
];
```

The first entry that matches a request adds its headers, and no other. An
entry matches when the whole URL, query included, matches its glob `url` and
the request is of one of its `kinds` (every kind by default):

| Pattern | Matches                                    |
|---------|--------------------------------------------|
| `*`     | Any characters except `/`                  |
| `**`    | Any characters                             |
| `?`     | One character except `/`                   |
| `\`     | Makes the next character match only itself |

Headers that the platform manages, such as `Host`, `User-Agent` or `Range`,
can't be set. On web, a cross-origin request with custom headers needs the
server to allow them (a CORS preflight).

## URL transform

`urlTransform` rewrites the URL of each request before it is sent, for
example to add a key as a query parameter or to point a style at another
server:

```dart
MapLibreNetwork.urlTransform = (url, kind) {
  if (kind == MapResourceKind.tile && url.startsWith('https://tiles.example.com/')) {
    return '$url?key=$apiKey';
  }
  return url;
};
```

Return the URL unchanged to keep it. The transform runs for every request, so
keep it fast. If it throws, the error goes to `FlutterError.onError` and the
request keeps its URL. Request headers match the transformed URL.

`MapLibreNetwork.reset()` removes the headers and the transform.
