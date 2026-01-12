import 'package:maplibre/maplibre.dart';
import 'package:maplibre_ios/maplibre_ffi.g.dart';

export 'background_style_layer.dart';

/// An interface representing a style layer for the iOS platform.
abstract class StyleLayerIos<FfiLayer extends MLNStyleLayer>
    implements StyleLayer {
  /// Construct an [StyleLayerIos] from a ObjC layer.
  StyleLayerIos.fromNativeLayer(this.ffiLayer);

  /// The ObjC layer instance.
  final FfiLayer ffiLayer;

  @override
  String get id => ffiLayer.identifier.toString();

  @override
  double get maxZoom => ffiLayer.maximumZoomLevel;

  @override
  set maxZoom(double value) => ffiLayer.maximumZoomLevel = value;

  @override
  double get minZoom => ffiLayer.minimumZoomLevel;

  @override
  set minZoom(double value) => ffiLayer.minimumZoomLevel = value;

  @override
  bool get visible => ffiLayer.isVisible;

  @override
  set visible(bool value) => ffiLayer.isVisible = value;
}
