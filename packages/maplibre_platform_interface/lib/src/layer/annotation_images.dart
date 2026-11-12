part of 'annotation_manager.dart';

/// Where the image of a marker icon is on the current style.
enum _ImageState {
  /// The image is being added.
  loading,

  /// The style has the image.
  ready,

  /// The image could not be added, which was reported.
  failed,
}

/// The images that the icons of [MapLibreMap.layers] show, shared between
/// the layers with an equal icon and on every style that loads.
class _AnnotationImages {
  final _images = <MarkerIcon, _StyleImage>{};
  var _counter = 0;
  StyleController? _style;

  /// Whether the map adds the image of [icon] to the style, instead of
  /// [icon] naming images that the style has.
  static bool addsImage(MarkerIcon icon) =>
      icon is! MarkerIconNamed && icon is! MarkerIconExpression;

  /// The id of the image of [icon] on the style. [icon] must be [acquire]d
  /// and [addsImage].
  String idOf(MarkerIcon icon) => _images[icon]!.id;

  /// Completes with whether the image of [icon] is on the style, or is null
  /// if there is nothing to wait for: no style is loaded, the image is
  /// ready, or [icon] names images of the style.
  Future<bool>? whenAdded(MarkerIcon icon) {
    final image = _images[icon];
    if (image == null) return null;
    return switch (image.state) {
      null || _ImageState.ready => null,
      _ImageState.loading => image.adding,
      _ImageState.failed => Future.value(false),
    };
  }

  /// Adds the images to [style], which just loaded.
  void attach(StyleController style) {
    _style = style;
    for (final MapEntry(key: icon, value: image) in _images.entries) {
      _add(icon, image, style);
    }
  }

  /// Forgets the style, which is about to be replaced or gone, with the
  /// images on it.
  void detach() {
    _style = null;
    for (final image in _images.values) {
      image
        ..state = null
        ..adding = null;
    }
  }

  /// Adds a user of the image of [icon], which adds the image to the style
  /// for the first one.
  void acquire(MarkerIcon icon) {
    if (!addsImage(icon)) return;
    final image = _images.putIfAbsent(
      icon,
      () => _StyleImage('maplibre-icon-${++_counter}'),
    );
    image.users++;
    final style = _style;
    if (image.users == 1 && style != null) _add(icon, image, style);
  }

  /// Takes a user of the image of [icon] away, which removes the image from
  /// the style after the last one.
  void release(MarkerIcon icon) {
    if (!addsImage(icon)) return;
    final image = _images[icon];
    if (image == null || --image.users > 0) return;
    _images.remove(icon);
    final style = _style;
    final adding = image.adding;
    if (style == null || adding == null) return;
    image
      ..state = null
      ..adding = null;
    unawaited(
      adding
          .then((_) async {
            if (identical(_style, style)) await style.removeImage(image.id);
          })
          .catchError((Object error, StackTrace stack) {
            if (identical(_style, style)) {
              _report(
                error,
                stack,
                'while removing the image of a marker icon',
              );
            }
          }),
    );
  }

  void _add(MarkerIcon icon, _StyleImage image, StyleController style) {
    image.state = _ImageState.loading;
    final adding = image.adding = _addTo(style, icon, image.id);
    unawaited(
      adding.then((added) {
        if (!identical(image.adding, adding)) return;
        image.state = added ? _ImageState.ready : _ImageState.failed;
      }),
    );
  }

  /// Adds the image of [icon] to [style] and returns whether it worked.
  Future<bool> _addTo(StyleController style, MarkerIcon icon, String id) async {
    try {
      await _load(icon, id, style);
      return true;
    } on Object catch (error, stack) {
      // An image of a style that is gone needs no report.
      if (identical(_style, style)) {
        _report(error, stack, 'while adding the image of a marker icon');
      }
      return false;
    }
  }

  static Future<void> _load(
    MarkerIcon icon,
    String id,
    StyleController style,
  ) async {
    switch (icon) {
      case MarkerIconData(:final icon, :final color, :final size):
        await style.addImageFromIconData(
          id: id,
          iconData: icon,
          color: color,
          size: size,
        );
      case MarkerIconAsset(:final path, :final pixelRatio):
        await style.addImageFromAssets(
          id: id,
          asset: path,
          pixelRatio: pixelRatio,
        );
      case MarkerIconBytes(:final bytes, :final pixelRatio):
        await style.addImage(id, bytes, pixelRatio: pixelRatio);
      case MarkerIconProvider(:final provider):
        final info = await resolveImageInfo(provider);
        try {
          await style.addImageFromUiImage(
            id: id,
            image: info.image,
            pixelRatio: info.scale,
          );
        } finally {
          info.dispose();
        }
      case MarkerIconNamed() || MarkerIconExpression():
        break;
    }
  }
}

/// An image that the icons of layers show.
class _StyleImage {
  _StyleImage(this.id);

  /// The id of the image on the style.
  final String id;

  /// The number of layers that show it.
  int users = 0;

  /// Where the image is on the current style, null while there is none.
  _ImageState? state;

  /// Completes with whether the image was added to the current style, while
  /// [state] is not null.
  Future<bool>? adding;
}
