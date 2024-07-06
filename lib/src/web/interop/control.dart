part of 'interop.dart';

extension type IControl._(JSObject _) implements JSObject {}

@JS('ScaleControl')
extension type ScaleControl._(IControl _) implements IControl {
  external ScaleControl([ScaleControlOptions? options]);

  external MapOptions options;
}

@anonymous
@JS()
extension type ScaleControlOptions._(JSObject _) implements JSObject {
  external factory ScaleControlOptions({
    num? maxWidth,
    // Unit could be some day an enum, https://github.com/dart-lang/sdk/issues/49243
    String? unit,
  });
}
