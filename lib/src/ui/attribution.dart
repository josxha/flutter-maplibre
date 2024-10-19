import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;
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
    final camera = MapCamera.maybeOf(context);
    if (controller == null || camera == null) return const SizedBox.shrink();

    _initMapCamera ??= camera;
    if (_expanded && !widget.keepExpanded && _initMapCamera != camera) {
      _initMapCamera = null;
      _expanded = false;
    }

    return FutureBuilder<List<String>>(
      future: controller.getAttributions(),
      builder: (context, snapshot) {
        if (snapshot.data case final List<String> attributions) {
          final theme = Theme.of(context);
          return Container(
            alignment: Alignment.bottomRight,
            padding: widget.padding,
            child: PointerInterceptor(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_expanded) ...[
                        const SizedBox(width: 8),
                        if (widget.showMapLibre) ...[
                          InkWell(
                            child: Text(
                              'MapLibre${attributions.isEmpty ? '' : ' |'}',
                              style: theme.textTheme.bodySmall,
                            ),
                            onTap: () {
                              launchUrl(Uri.parse('https://maplibre.org/'));
                            },
                          ),
                          const SizedBox(width: 8),
                        ],
                        ...attributions.map(_HtmlWidget.new),
                      ],
                      // The SizedBox enforces the height on android (web works without it).
                      SizedBox.square(
                        dimension: 30,
                        child: IconButton(
                          onPressed: () => setState(() {
                            _initMapCamera = null;
                            _expanded = !_expanded;
                          }),
                          icon: const Icon(Icons.info, size: 18),
                          padding: const EdgeInsets.all(4),
                          constraints: const BoxConstraints(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        if (snapshot.error case final Object error) {
          debugPrint(error.toString());
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _HtmlWidget extends StatelessWidget {
  const _HtmlWidget(this.html);

  final String html;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall;
    final textSpans = <TextSpan>[];
    final document = html_parser.parse(html);
    for (final node in document.body!.nodes) {
      if (node is dom.Text) {
        // pure text
        textSpans.add(TextSpan(text: node.text));
      } else if (node is dom.Element && node.localName == 'a') {
        // link
        textSpans.add(
          TextSpan(
            text: node.text,
            style: textStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (node.attributes['href'] case final String href) {
                  launchUrl(Uri.parse(href));
                }
              },
          ),
        );
      }
    }
    return RichText(text: TextSpan(style: textStyle, children: textSpans));
  }
}
