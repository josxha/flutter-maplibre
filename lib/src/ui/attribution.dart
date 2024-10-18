import 'package:flutter/material.dart';
import 'package:maplibre/maplibre.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:url_launcher/url_launcher.dart';

/// Display a zoom-in and zoom-out button to the [MapLibreMap] by using it in
/// [MapLibreMap.children].
class Attribution extends StatefulWidget {
  /// Display a zoom-in and zoom-out button to the [MapLibreMap] by using it in
  /// [MapLibreMap.children].
  const Attribution({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    this.showMapLibre = true,
    this.keepExpanded = false,
  });

  /// The padding.
  final EdgeInsets padding;

  /// Shows that you are using MapLibre.
  ///
  /// Defaults to true.
  final bool showMapLibre;

  /// Keeps the attribution expanded when the MapCamera changes.
  ///
  /// Defaults to false.
  final bool keepExpanded;

  @override
  State<Attribution> createState() => _AttributionState();
}

class _AttributionState extends State<Attribution> {
  bool _expanded = true;
  MapCamera? _initMapCamera;

  @override
  Widget build(BuildContext context) {
    final controller = MapController.maybeOf(context);
    if (controller == null) return const SizedBox.shrink();
    final camera = MapCamera.of(context);

    _initMapCamera ??= camera;
    if (_initMapCamera != camera && _expanded) {
      _initMapCamera = null;
      _expanded = false;
    }

    return Container(
      alignment: Alignment.bottomRight,
      padding: widget.padding,
      child: PointerInterceptor(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_expanded) ...[
                  const SizedBox(width: 8),
                  if (widget.showMapLibre) ...[
                    InkWell(
                      child: const Text(
                        'MapLibre |',
                        style: TextStyle(fontSize: 12),
                      ),
                      onTap: () =>
                          launchUrl(Uri.parse('https://maplibre.org/')),
                    ),
                    const SizedBox(width: 8),
                  ],
                ],
                IconButton(
                  onPressed: () => setState(() {
                    _initMapCamera = null;
                    _expanded = !_expanded;
                  }),
                  icon: const Icon(Icons.info, size: 18),
                  padding: const EdgeInsets.all(4),
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
