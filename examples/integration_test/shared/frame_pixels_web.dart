import 'dart:convert';
import 'dart:js_interop';

@JS('eval')
external JSAny? _eval(String source);

/// Records the RGBA color at the center of every frame that maplibre-gl-js
/// renders, read from its WebGL canvas right after the frame is drawn. The
/// map is not in Flutter's layer tree on web, so Flutter can't read it.
///
/// Returns the function that stops recording.
void Function() startFramePixels() {
  _eval('''
    (() => {
      globalThis.__framePixels = [];
      const proto = maplibregl.Map.prototype;
      if (proto.__framePixelsRender) return;
      const render = proto._render;
      proto.__framePixelsRender = render;
      proto._render = function (...args) {
        const result = render.apply(this, args);
        const gl = this.painter.context.gl;
        const pixel = new Uint8Array(4);
        gl.readPixels(
          gl.drawingBufferWidth >> 1, gl.drawingBufferHeight >> 1, 1, 1,
          gl.RGBA, gl.UNSIGNED_BYTE, pixel);
        globalThis.__framePixels.push(Array.from(pixel));
        return result;
      };
    })()
  ''');
  return () => _eval('''
    (() => {
      const proto = maplibregl.Map.prototype;
      if (proto.__framePixelsRender) {
        proto._render = proto.__framePixelsRender;
        delete proto.__framePixelsRender;
      }
      delete globalThis.__framePixels;
    })()
  ''');
}

/// The colors that frames showed since [startFramePixels] or the last call.
List<List<int>> takeFramePixels() {
  final json =
      (_eval('''
    (() => {
      const pixels = JSON.stringify(globalThis.__framePixels);
      globalThis.__framePixels = [];
      return pixels;
    })()
  ''')!
              as JSString)
          .toDart;
  return [
    for (final pixel in jsonDecode(json) as List)
      [for (final channel in pixel as List) channel as int],
  ];
}
