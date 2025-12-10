import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';

/// The [StyleController] can be used to manipulate the style of
/// a [MapLibreMap]. It can be accessed via [MapController.style].
///
/// {@category Basic}
abstract class StyleController {
  /// Abstract base constructor for implementations.
  const StyleController();

  /// Add a new source to the map.
  Future<void> addSource(Source source);

  /// Add a new layer to the map. The source must be added before adding it to
  /// the map.
  ///
  /// [belowLayerId] The ID of an existing layer to insert the new layer before,
  /// resulting in the new layer appearing visually beneath the existing layer.
  ///
  /// [aboveLayerId] The ID of an existing layer to insert the new layer after,
  /// resulting in the new layer appearing visually above the existing layer.
  /// **This parameter will be ignored on web.**
  ///
  /// [atIndex] is the position at which to insert the layer. An index of 0
  /// would send the layer to the back; an index equal to the number of
  /// objects in the layers property would bring the layer to the front.
  /// **This parameter will be ignored on web.**
  ///
  /// If more than one positioning parameter is specified, it will first try to
  /// use [belowLayerId], then [aboveLayerId] and finally [atIndex].
  /// If no positioning parameter is specified, the layer
  /// will be appended to the end of the layers array and appear visually
  /// above all other layers.
  Future<void> addLayer(
    StyleLayer layer, {
    String? belowLayerId,
    String? aboveLayerId,
    int? atIndex,
  });

  /// Update the data of a GeoJSON source.
  Future<void> updateGeoJsonSource({required String id, required String data});

  /// Removes the layer with the given [id] from the map's style.
  Future<void> removeLayer(String id);

  /// Removes the source with the given [id] from the map's style.
  Future<void> removeSource(String id);

  /// Get a list of all attributions from the map style.
  Future<List<String>> getAttributions();

  /// Get a list of all attributions from the map style.
  List<String> getAttributionsSync();

  @visibleForTesting
  /// For testing purposes only. Will be replaced with a public API.
  List<String> getLayerIds();

  /// Add an image to the map.
  Future<void> addImage(String id, Uint8List bytes);

  /// Add multiple images to the map where the key is the image ID and the
  /// value is the image bytes.
  Future<void> addImages(Map<String, Uint8List> images) =>
      Future.wait(images.entries.map((e) => addImage(e.key, e.value)));

  /// Load an image from the Flutter assets to the map by its [asset] path.
  Future<void> addImageFromAssets({
    required String id,
    required String asset,
  }) async {
    final byteData = await rootBundle.load(asset);
    final bytes = byteData.buffer.asUint8List();
    await addImage(id, bytes);
  }

  /// Create an image from [IconData] and add it to the map with the given [id].
  ///
  /// The [size] parameter defines the width and height of the resulting image
  /// in pixels.
  ///
  /// The [color] parameter defines the color of the icon. By default, it is
  /// black.
  Future<void> addImageFromIconData({
    required String id,
    required IconData iconData,
    int size = 200,
    Color color = const Color(0xFF000000),
  }) async {
    final pictureRecorder = PictureRecorder();
    final canvas = Canvas(pictureRecorder);

    TextPainter(textDirection: TextDirection.ltr)
      ..text = TextSpan(
        text: String.fromCharCode(iconData.codePoint),
        style: TextStyle(
          letterSpacing: 0,
          fontSize: size.toDouble(),
          fontFamily: iconData.fontFamily,
          package: iconData.fontPackage,
          color: color,
        ),
      )
      ..layout()
      ..paint(canvas, Offset.zero);

    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(size, size);
    final bytes = await image.toByteData(format: ImageByteFormat.png);
    if (bytes == null) return;

    await addImage(id, bytes.buffer.asUint8List());
  }

  /// Removes an image from the map
  Future<void> removeImage(String id);

  /// Set the map projection.
  ///
  /// [MapProjection.globe] is currently on supported on web.
  void setProjection(MapProjection projection);

  /// Get the map projection.
  MapProjection get projection;

  /// Clean up resources.
  void dispose();
}

/// The map projections.
///
/// https://maplibre.org/maplibre-style-spec/projection/
enum MapProjection {
  /// The default web mercator projection.
  mercator,

  /// Globe projection. Only supported on web.
  globe,
}
