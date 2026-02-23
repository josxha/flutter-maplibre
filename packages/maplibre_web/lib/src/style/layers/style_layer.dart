import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_web/src/interop/interop.dart' as js;

export 'background_style_layer.dart';

/// Web implementation of [StyleLayer].
abstract class StyleLayerWeb<JSLayer extends js.LayerSpecification>
    extends StyleLayer with LayoutPaintMixin {
  /// Construct an [StyleLayerWeb] from a JNI layer.
  StyleLayerWeb.fromNativeLayer(this.jsLayer);

  /// The JavaScript layer instance.
  final JSLayer jsLayer;

  @override
  String get id => jsLayer.id;

  @override
  double get maxZoom => jsLayer.maxzoom ?? StyleLayer.defaultMaxZoom;

  @override
  set maxZoom(double value) => jsLayer.maxzoom = value;

  @override
  double get minZoom => jsLayer.minzoom ?? StyleLayer.defaultMinZoom;

  @override
  set minZoom(double value) => jsLayer.minzoom = value;

  @override
  bool get visible => throw UnimplementedError();

  @override
  set visible(bool value) => throw UnimplementedError();
}
