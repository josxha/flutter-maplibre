import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';
import 'package:maplibre_platform_interface/src/style/layers/style_layer.dart'
    show setStyleLayersOwner;
import 'package:maplibre_platform_interface/src/style/sources/source.dart'
    show setStyleSourcesOwner;

/// A part of the map other than the app that owns some layers and sources of
/// a style, such as the annotation layers of [MapLibreMap.layers].
///
/// [StyleLayers] and [StyleSources] keep the app from changing what the
/// owner owns: removing or moving such a layer fails, and other changes warn
/// in debug builds, because the owner would undo them. Changes that the
/// owner makes itself, while [isWriting], pass.
///
/// Not part of the public API.
abstract interface class StyleOwner {
  /// Where the app changes what the owner owns, such as `MapLibreMap.layers`,
  /// for the messages of the collections.
  String get name;

  /// Whether the owner is changing the style.
  bool get isWriting;

  /// Whether the owner owns the style layer [id].
  bool ownsLayer(String id);

  /// Whether the owner owns the source [id].
  bool ownsSource(String id);

  /// Called after the app, not the owner, added, moved or removed a layer
  /// of the style.
  void layoutChanged();
}

/// Makes [owner] the owner of its layers and sources of [style], or makes
/// [style] forget its owner if [owner] is null.
void setStyleOwner(StyleController style, StyleOwner? owner) {
  setStyleLayersOwner(style.layers, owner);
  setStyleSourcesOwner(style.sources, owner);
}
