import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

/// Display a zoom-in and zoom-out button to the [MapLibreMap] by using it in
/// [MapLibreMap.children].
class ZoomButtons extends StatelessWidget {
  /// Display a zoom-in and zoom-out button to the [MapLibreMap] by using it in
  /// [MapLibreMap.children].
  const ZoomButtons({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
  });

  /// The padding.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final controller = MapController.maybeOf(context);
    if (controller == null) return const SizedBox.shrink();
    return Container(
      alignment: Alignment.bottomRight,
      padding: padding,
      child: PointerInterceptor(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            FloatingActionButton(
              onPressed: () => controller.animateCamera(
                zoom: controller.getCamera().zoom + 1,
              ),
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () => controller.animateCamera(
                zoom: controller.getCamera().zoom - 1,
              ),
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
