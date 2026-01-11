import 'package:maplibre_ios/maplibre_ffi.g.dart';

export 'layers/background_style_layer.dart';

/// An interface representing a style layer for the iOS platform.
abstract class StyleLayerIos<FfiLayer extends MLNStyleLayer> {
  /// Construct an [StyleLayerIos] from a ObjC layer.
  StyleLayerIos.fromNativeLayer(this.ffiLayer);

  /// The ObjC layer instance.
  final FfiLayer ffiLayer;
}
