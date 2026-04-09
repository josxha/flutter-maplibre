part of 'style_layer.dart';

/// Android implementation of [BackgroundStyleLayer].
class BackgroundStyleLayerAndroid extends StyleLayerAndroid<jni.BackgroundLayer>
    implements BackgroundStyleLayer {
  /// Factory for a [BackgroundStyleLayerAndroid] instance.
  factory BackgroundStyleLayerAndroid({
    required String id,
    required double minZoom,
    required double maxZoom,
    required PropertyValue<Color> color,
    required PropertyValue<String>? pattern,
    required PropertyValue<double> opacity,
    required bool visible,
  }) => using((arena) {
    return BackgroundStyleLayerAndroid.fromNativeLayer(
        jni.BackgroundLayer(id.toJString()..releasedBy(arena)),
      )
      ..minZoom = minZoom
      ..maxZoom = maxZoom
      ..color = color
      ..opacity = opacity
      ..visible = visible
      ..pattern = pattern;
  });

  /// Construct an [BackgroundStyleLayerAndroid] from a JNI..
  BackgroundStyleLayerAndroid.fromNativeLayer(super.jLayer)
    : super.fromNativeLayer();

  @override
  PropertyValue<double> get opacity =>
      jLayer.backgroundOpacity.toDart(releaseOriginal: true) ??
      BackgroundStyleLayer.defaultOpacity;

  @override
  set opacity(PropertyValue<double> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.backgroundOpacity$1,
      onValue: (value) => jni.PropertyFactory.backgroundOpacity(
        property.value.toJFloat()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<String>? get pattern =>
      jLayer.backgroundPattern.toDart(releaseOriginal: true);

  @override
  set pattern(PropertyValue<String>? property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.backgroundPattern$1,
      onValue: (value) => jni.PropertyFactory.backgroundPattern(
        value.toJString()..releasedBy(arena),
      ),
      onNull: () => jni.PropertyFactory.backgroundPattern(null),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });

  @override
  PropertyValue<Color> get color =>
      jLayer.backgroundColor.toDartColor() ??
      BackgroundStyleLayer.defaultColor;

  @override
  set color(PropertyValue<Color> property) => using((arena) {
    final jProperty = property.apply(
      arena: arena,
      onExpression: jni.PropertyFactory.backgroundColor$2,
      onValue: (value) => jni.PropertyFactory.backgroundColor$1(
        value.toHexString().toJString()..releasedBy(arena),
      ),
    );
    jProperty?.releasedBy(arena);
    jLayer.setProperty(jProperty);
  });
}
