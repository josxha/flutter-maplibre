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

  /// Switch label placement transitions on or off.
  ///
  /// On, a symbol fades in or out as its collisions with other symbols
  /// change: over the style's transition duration on native, 300 ms unless
  /// the style sets one, and over 300 ms on web. Off, a symbol shows or hides
  /// at once: one added over others displaces them on the frame it first
  /// appears, and they return on the frame it is gone. They are on by
  /// default, and on again in every newly loaded style.
  ///
  /// On web, off also ends the crossfade of `*-pattern` and `line-dasharray`
  /// values between zoom levels, which maplibre-gl-js times with the same
  /// fade duration.
  Future<void> setPlacementTransitions({required bool enabled});

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
  ///
  /// [options] make it an SDF image or one that fits the text of a symbol.
  Future<void> addImage(
    String id,
    Uint8List bytes, {
    double pixelRatio = 1,
    StyleImageOptions options = const StyleImageOptions(),
  });

  /// Add multiple images to the map where the key is the image ID and the
  /// value is the image bytes. See [addImage] for [pixelRatio] and
  /// [options].
  Future<void> addImages(
    Map<String, Uint8List> images, {
    double pixelRatio = 1,
    StyleImageOptions options = const StyleImageOptions(),
  }) => Future.wait(
    images.entries.map(
      (e) => addImage(e.key, e.value, pixelRatio: pixelRatio, options: options),
    ),
  );

  /// Add a [dart:ui Image](Image) to the map. See [addImage] for
  /// [pixelRatio] and [options].
  ///
  /// The pixels of [image] go to the map as they are, without an encoding to
  /// PNG. The caller keeps [image] and disposes it.
  Future<void> addImageFromUiImage({
    required String id,
    required Image image,
    double pixelRatio = 1,
    StyleImageOptions options = const StyleImageOptions(),
  });

  /// Load an image from the Flutter assets to the map by its [asset] path.
  /// See [addImage] for [pixelRatio] and [options].
  Future<void> addImageFromAssets({
    required String id,
    required String asset,
    double pixelRatio = 1,
    StyleImageOptions options = const StyleImageOptions(),
  }) async {
    final byteData = await rootBundle.load(asset);
    final bytes = byteData.buffer.asUint8List();
    await addImage(id, bytes, pixelRatio: pixelRatio, options: options);
  }

  /// Create an image from a [Canvas] and add it to the map with the given [id].
  ///
  /// The [painter] function receives a [Canvas] to draw on, in logical
  /// pixels.
  ///
  /// The [width] and [height] define the size of the image in logical
  /// pixels, which it has on the map at an icon size of 1. The image is
  /// rendered at the device pixel ratio, so that it stays sharp.
  ///
  /// The positions of [options] are logical pixels too.
  Future<void> addImageFromCanvas({
    required String id,
    required void Function(Canvas canvas) painter,
    required double width,
    required double height,
    StyleImageOptions options = const StyleImageOptions(),
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
      await addImageFromUiImage(
        id: id,
        image: image,
        pixelRatio: pixelRatio,
        options: options.scaled(pixelRatio),
      );
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
  /// black. Draw an icon in one color and pass `StyleImageOptions(sdf: true)`
  /// as [options] to color it with `icon-color` instead.
  ///
  /// The positions of [options] are logical pixels.
  Future<void> addImageFromIconData({
    required String id,
    required IconData iconData,
    double size = 48,
    Color color = const Color(0xFF000000),
    StyleImageOptions options = const StyleImageOptions(),
  }) async {
    await addImageFromCanvas(
      id: id,
      width: size,
      height: size,
      options: options,
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
  /// The positions of [options] are logical pixels.
  ///
  /// This method is inspired by the
  /// [widget_to_marker](https://pub.dev/packages/widget_to_marker) package.
  Future<void> addImageFromWidget({
    required String id,
    required Widget widget,
    Size? logicalSize,
    Size? imageSize,
    TextDirection textDirection = TextDirection.ltr,
    StyleImageOptions options = const StyleImageOptions(),
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
      await addImageFromUiImage(
        id: id,
        image: image,
        pixelRatio: pixelRatio,
        options: options.scaled(pixelRatio),
      );
    } finally {
      image.dispose();
    }
  }

  /// Removes an image from the map
  Future<void> removeImage(String id);

  /// Sets the projection of the map, a [MapProjection] or an expression that
  /// changes it with the zoom level.
  ///
  /// ```dart
  /// style.setProjection(const .literal(.globe));
  /// // Vertical perspective when zoomed out, Mercator from zoom level 12.
  /// style.setProjection(.interpolate(.linear(), .zoom(), {
  ///   10: const .literal(.verticalPerspective),
  ///   12: const .literal(.mercator),
  /// }));
  /// ```
  ///
  /// Projections other than [MapProjection.mercator] are only supported on
  /// web. On every other platform, the map stays on Mercator.
  ///
  /// https://maplibre.org/maplibre-style-spec/projection/
  void setProjection(Expression<MapProjection> projection);

  /// Clean up resources.
  void dispose();
}

/// The map projections of the style spec.
///
/// https://maplibre.org/maplibre-style-spec/types/#projectiondefinition
///
/// {@category Basic}
enum MapProjection implements StyleEnum {
  /// The Web Mercator projection.
  mercator('mercator'),

  /// The world as seen from a point in space above the center of the map.
  /// Only supported on web.
  verticalPerspective('vertical-perspective'),

  /// The globe, which is [verticalPerspective] at low zoom levels and
  /// [mercator] from zoom level 12. Only supported on web.
  globe('globe');

  const MapProjection(this.value);

  @override
  final String value;
}

/// How an image that [StyleImageOptions.textFitWidth] or
/// [StyleImageOptions.textFitHeight] stretches fits the text of a symbol.
///
/// {@category Basic}
enum ImageTextFit {
  /// Stretches or shrinks the image to the text.
  stretchOrShrink,

  /// Only stretches the image to the text, never shrinks it.
  stretchOnly,

  /// Stretches the image to the text and the other side by as much, keeping
  /// its aspect ratio.
  proportional,
}

/// How the map draws an image of the style, for `icon-text-fit` and SDF
/// icons. Positions are in pixels of the image, except for the images that
/// [StyleController.addImageFromCanvas], [StyleController.addImageFromIconData]
/// and [StyleController.addImageFromWidget] draw, where they are logical
/// pixels like their size.
///
/// https://maplibre.org/maplibre-gl-js/docs/API/type-aliases/StyleImageMetadata/
///
/// {@category Basic}
@immutable
final class StyleImageOptions {
  /// Creates the options of an image.
  const StyleImageOptions({
    this.sdf = false,
    this.stretchX = const [],
    this.stretchY = const [],
    this.content,
    this.textFitWidth,
    this.textFitHeight,
  });

  /// Whether the image is a signed distance field, whose color
  /// `icon-color` and `icon-halo-color` set.
  final bool sdf;

  /// The ranges of x positions, from left to right, that stretch when the
  /// icon fits the text of a symbol.
  final List<(double, double)> stretchX;

  /// The ranges of y positions, from top to bottom, that stretch when the
  /// icon fits the text of a symbol.
  final List<(double, double)> stretchY;

  /// The part of the image that the text of a symbol fits into.
  final Rect? content;

  /// How the image fits the width of the text.
  final ImageTextFit? textFitWidth;

  /// How the image fits the height of the text.
  final ImageTextFit? textFitHeight;

  /// These options with every position multiplied by [factor].
  StyleImageOptions scaled(double factor) => factor == 1
      ? this
      : StyleImageOptions(
          sdf: sdf,
          stretchX: [for (final (a, b) in stretchX) (a * factor, b * factor)],
          stretchY: [for (final (a, b) in stretchY) (a * factor, b * factor)],
          content: content == null
              ? null
              : Rect.fromLTRB(
                  content!.left * factor,
                  content!.top * factor,
                  content!.right * factor,
                  content!.bottom * factor,
                ),
          textFitWidth: textFitWidth,
          textFitHeight: textFitHeight,
        );

  @override
  bool operator ==(Object other) =>
      other is StyleImageOptions &&
      sdf == other.sdf &&
      listEquals(stretchX, other.stretchX) &&
      listEquals(stretchY, other.stretchY) &&
      content == other.content &&
      textFitWidth == other.textFitWidth &&
      textFitHeight == other.textFitHeight;

  @override
  int get hashCode => Object.hash(
    sdf,
    Object.hashAll(stretchX),
    Object.hashAll(stretchY),
    content,
    textFitWidth,
    textFitHeight,
  );
}
