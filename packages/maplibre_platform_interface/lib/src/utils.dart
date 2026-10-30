import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';

/// pre compiled factor to convert a coordinate in radian to degrees.
const double degree2Radian = pi / 180;

/// A list of all color names that are listed by the World Wide Web Consortium
/// (W3C) as valid color names for HTML and CSS.
const htmlColorNames = <String, String>{
  'black': '#000000',
  'silver': '#C0C0C0',
  'gray': '#808080',
  'white': '#FFFFFF',
  'maroon': '#800000',
  'red': '#FF0000',
  'purple': '#800080',
  'fuchsia': '#FF00FF',
  'green': '#008000',
  'lime': '#00FF00',
  'olive': '#808000',
  'yellow': '#FFFF00',
  'navy': '#000080',
  'blue': '#0000FF',
  'teal': '#008080',
  'aqua': '#00FFFF',
};

/// Loads the image of [provider], resolved for the device pixel ratio of the
/// first view. The caller owns the returned image and must dispose it.
Future<ui.Image> resolveImageProvider(ImageProvider provider) {
  final view = ui.PlatformDispatcher.instance.implicitView;
  final stream = provider.resolve(
    ImageConfiguration(devicePixelRatio: view?.devicePixelRatio ?? 1),
  );
  final completer = Completer<ui.Image>();
  late final ImageStreamListener listener;
  listener = ImageStreamListener(
    (info, _) {
      stream.removeListener(listener);
      if (completer.isCompleted) {
        info.dispose();
      } else {
        completer.complete(info.image);
      }
    },
    onError: (error, stackTrace) {
      stream.removeListener(listener);
      if (!completer.isCompleted) completer.completeError(error, stackTrace);
    },
  );
  stream.addListener(listener);
  return completer.future;
}
