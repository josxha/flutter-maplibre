import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:maplibre/maplibre.dart';

/// The [WidgetToPng] widget
class WidgetToPng extends StatefulWidget {
  /// Create a new [WidgetToPng] widget.
  const WidgetToPng(this.layer, this.controller, this.imageId, {super.key});

  /// The marker layer.
  final MarkerAnnotationLayer<Widget> layer;

  /// The map controller.
  final MapController controller;

  /// the image id.
  final String imageId;

  @override
  State<WidgetToPng> createState() => _WidgetToPngState();
}

class _WidgetToPngState extends State<WidgetToPng> {
  final _key = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final boundary =
          _key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final image = await boundary.toImage();
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();
      await widget.controller.addImage(widget.imageId, pngBytes);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -1000000000,
      child: RepaintBoundary(
        key: _key,
        child: widget.layer.iconImage,
      ),
    );
  }
}
