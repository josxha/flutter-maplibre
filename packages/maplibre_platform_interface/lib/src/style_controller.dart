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

  /// The layers of the style, from bottom to top. Get, add, move and remove
  /// them here, and change their properties on the [StyleLayer] objects.
  StyleLayers get layers;

  /// The sources of the style. Get, add, update and remove them here.
  StyleSources get sources;

  /// Runs [updates], whose changes to the style show in one frame on native
  /// maps. On web they run as they are, as gl-js only renders in between
  /// tasks anyway.
  ///
  /// [updates] must be synchronous: changes made after an `await` in it are
  /// not part of the batch.
  void batch(void Function() updates);

  /// The attributions of the sources in the map style.
  ///
  /// The list follows the sources of the style. A source that loads its
  /// attribution from a TileJSON adds it once the TileJSON has loaded.
  List<String> get attributions;

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
