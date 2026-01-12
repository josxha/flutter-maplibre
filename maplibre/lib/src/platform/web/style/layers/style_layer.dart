import 'package:maplibre/src/platform/web/interop/interop.dart' as js;

export 'background_style_layer.dart';

/// An interface representing a style layer for the web platform.
abstract class StyleLayerWeb<JSLayer extends js.LayerSpecification> {
  /// Construct an [StyleLayerWeb] from a JNI layer.
  StyleLayerWeb.fromNativeLayer(this.jsLayer);

  /// The JavaScript layer instance.
  final JSLayer jsLayer;
}
