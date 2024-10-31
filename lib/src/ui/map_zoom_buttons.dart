import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

/// Display a zoom-in and zoom-out button to the [MapLibreMap] by using it in
/// [MapLibreMap.children].
///
/// This widget is purposefully kept simple. If you need to change the design
/// or behavior of the zoom buttons a lot, prefer to copy this class into your
/// app and adjust it according to your needs.
@immutable
class MapZoomButtons extends StatelessWidget {
  /// Display a zoom-in and zoom-out button to the [MapLibreMap] by using it in
  /// [MapLibreMap.children].
  const MapZoomButtons({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 50, horizontal: 12),
    this.alignment = Alignment.bottomRight,
  });

  /// The padding.
  final EdgeInsets padding;

  /// The alignment of the buttons.
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final controller = MapController.maybeOf(context);
    if (controller == null) return const SizedBox.shrink();

    return Container(
      alignment: alignment,
      padding: padding,
      child: PointerInterceptor(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: 'MapLibreZoomInButton',
              onPressed: () => controller.animateCamera(
                zoom: controller.getCamera().zoom + 1,
                nativeDuration: const Duration(milliseconds: 200),
              ),
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 8),
            FloatingActionButton(
              heroTag: 'MapLibreZoomOutButton',
              onPressed: () => controller.animateCamera(
                zoom: controller.getCamera().zoom - 1,
                nativeDuration: const Duration(milliseconds: 200),
              ),
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
