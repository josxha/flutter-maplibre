import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' hide Image;
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

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

  /// Looks up the line layer [id] of the style. Its getters read the layer's
  /// properties and its setters update them.
  ///
  /// Returns null when the style has no line layer with that id.
  Future<LineStyleLayerController?> getLineLayer(String id);

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
  ///
  /// [pixelRatio] is the number of image pixels per logical pixel. An image
  /// that is N pixels wide shows N / [pixelRatio] logical pixels wide at an
  /// icon size of 1, on every platform and screen. Pass 2 for an image made
  /// for screens with a device pixel ratio of 2.
  Future<void> addImage(String id, Uint8List bytes, {double pixelRatio = 1});

  /// Add multiple images to the map where the key is the image ID and the
  /// value is the image bytes. See [addImage] for [pixelRatio].
  Future<void> addImages(
    Map<String, Uint8List> images, {
    double pixelRatio = 1,
  }) => Future.wait(
    images.entries.map((e) => addImage(e.key, e.value, pixelRatio: pixelRatio)),
  );

  /// Add a [dart:ui Image](Image) to the map. See [addImage] for
  /// [pixelRatio].
  ///
  /// The pixels of [image] go to the map as they are, without an encoding to
  /// PNG. The caller keeps [image] and disposes it.
  Future<void> addImageFromUiImage({
    required String id,
    required Image image,
    double pixelRatio = 1,
  });

  /// Load an image from the Flutter assets to the map by its [asset] path.
  /// See [addImage] for [pixelRatio].
  Future<void> addImageFromAssets({
    required String id,
    required String asset,
    double pixelRatio = 1,
  }) async {
    final byteData = await rootBundle.load(asset);
    final bytes = byteData.buffer.asUint8List();
    await addImage(id, bytes, pixelRatio: pixelRatio);
  }

  /// Create an image from a [Canvas] and add it to the map with the given [id].
  ///
  /// The [painter] function receives a [Canvas] to draw on, in logical
  /// pixels.
  ///
  /// The [width] and [height] define the size of the image in logical
  /// pixels, which it has on the map at an icon size of 1. The image is
  /// rendered at the device pixel ratio, so that it stays sharp.
  Future<void> addImageFromCanvas({
    required String id,
    required void Function(Canvas canvas) painter,
    required double width,
    required double height,
  }) async {
    final pixelRatio = PlatformDispatcher.instance.views.first.devicePixelRatio;
    final pictureRecorder = PictureRecorder();
    final canvas = Canvas(pictureRecorder)..scale(pixelRatio);
    painter(canvas);
    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(
      (width * pixelRatio).ceil(),
      (height * pixelRatio).ceil(),
    );
    picture.dispose();
    try {
      await addImageFromUiImage(id: id, image: image, pixelRatio: pixelRatio);
    } finally {
      image.dispose();
    }
  }

  /// Create an image from [IconData] and add it to the map with the given [id].
  ///
  /// The [size] parameter defines the width and height of the image in
  /// logical pixels, which it has on the map at an icon size of 1.
  ///
  /// The [color] parameter defines the color of the icon. By default, it is
  /// black.
  Future<void> addImageFromIconData({
    required String id,
    required IconData iconData,
    double size = 48,
    Color color = const Color(0xFF000000),
  }) async {
    await addImageFromCanvas(
      id: id,
      width: size,
      height: size,
      painter: (canvas) {
        TextPainter(textDirection: TextDirection.ltr)
          ..text = TextSpan(
            text: String.fromCharCode(iconData.codePoint),
            style: TextStyle(
              letterSpacing: 0,
              fontSize: size,
              fontFamily: iconData.fontFamily,
              package: iconData.fontPackage,
              color: color,
            ),
          )
          ..layout()
          ..paint(canvas, Offset.zero);
      },
    );
  }

  /// Create an image from a [Widget] and add it to the map with the given [id].
  ///
  /// The image has the logical size of the [widget], which it has on the map
  /// at an icon size of 1. It is rendered at [imageSize] / [logicalSize],
  /// the device pixel ratio by default, so that it stays sharp.
  ///
  /// This method is inspired by the
  /// [widget_to_marker](https://pub.dev/packages/widget_to_marker) package.
  Future<void> addImageFromWidget({
    required String id,
    required Widget widget,
    Size? logicalSize,
    Size? imageSize,
    TextDirection textDirection = TextDirection.ltr,
  }) async {
    final rb = RepaintBoundary(
      child: MediaQuery(
        data: const MediaQueryData(),
        child: Directionality(textDirection: textDirection, child: widget),
      ),
    );

    final view = PlatformDispatcher.instance.views.first;

    final repaintBoundary = RenderRepaintBoundary();
    logicalSize ??= view.physicalSize / view.devicePixelRatio;
    imageSize ??= view.physicalSize;

    final renderView = RenderView(
      view: view,
      child: RenderPositionedBox(child: repaintBoundary),
      configuration: ViewConfiguration(
        physicalConstraints:
            BoxConstraints.tight(logicalSize) * view.devicePixelRatio,
        logicalConstraints: BoxConstraints.tight(logicalSize),
        devicePixelRatio: view.devicePixelRatio,
      ),
    );

    final pipelineOwner = PipelineOwner();
    final buildOwner = BuildOwner(focusManager: FocusManager());

    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();

    final rootElement = RenderObjectToWidgetAdapter<RenderBox>(
      container: repaintBoundary,
      child: rb,
    ).attachToRenderTree(buildOwner);

    buildOwner.buildScope(rootElement);
    buildOwner.finalizeTree();

    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();

    final pixelRatio = imageSize.width / logicalSize.width;
    final image = await repaintBoundary.toImage(pixelRatio: pixelRatio);
    buildOwner.finalizeTree();
    try {
      await addImageFromUiImage(id: id, image: image, pixelRatio: pixelRatio);
    } finally {
      image.dispose();
    }
  }

  /// Removes an image from the map
  Future<void> removeImage(String id);

  /// Set the map projection.
  ///
  /// [MapProjection.globe] is only supported on web. MapLibre Native has no
  /// globe projection, so native maps ignore it and stay on Mercator.
  void setProjection(MapProjection projection);

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
