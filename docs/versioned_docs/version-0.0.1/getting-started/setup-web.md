---
sidebar_position: 4
---

# Setup Web

Include the following JavaScript and CSS files in the `<head>` tag of
your `web/index.html` file:

```html title="web/index.html"
<!DOCTYPE html>
<html>
<head>
    <!-- other html -->

    <!-- MapLibre -->
    <script src='https://unpkg.com/maplibre-gl@^4.3/dist/maplibre-gl.js'></script>
    <link href='https://unpkg.com/maplibre-gl@^4.3/dist/maplibre-gl.css'
          rel='stylesheet'/>
</head>
</html>
```

`^4.3` ensures that your app will always use the latest version of
[maplibre-gl-js](https://github.com/maplibre/maplibre-gl-js) version 4 but not
suddenly
use an incompatible version.

If you want to always use the latest version use `latest` or use the full
version number like `4.3.0` if you want to use a specific version.

You can read about changes in maplibre-gl-js in
the [changelog file](https://github.com/maplibre/maplibre-gl-js/blob/main/CHANGELOG.md).