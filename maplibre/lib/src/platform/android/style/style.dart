import 'package:maplibre/src/platform/android/jni.g.dart' as jni;

export 'layers/background_style_layer.dart';

/// An interface representing a style layer for the Android platform.
abstract class StyleLayerAndroid<JLayer extends jni.Layer> {
  /// Construct an [StyleLayerAndroid] from a JNI layer.
  StyleLayerAndroid.fromNativeLayer(this.jLayer) {
    final finalizer = Finalizer<jni.Layer>((j) => j.release());
    finalizer.attach(this, jLayer, detach: this);
  }

  /// The JNI layer instance.
  final JLayer jLayer;
}
