part of 'interop.dart';

@JS()
extension type MapMouseEvent._(JSObject _) implements JSObject {
  external MapMouseEvent();

  external Map target;
  external LngLat lngLat;
  external JSObject originalEvent;
}
