/// Only on web, where frames are read from maplibre-gl-js's canvas.
void Function() startFramePixels() => throw UnsupportedError('web only');

/// Only on web, where frames are read from maplibre-gl-js's canvas.
List<List<int>> takeFramePixels() => throw UnsupportedError('web only');
