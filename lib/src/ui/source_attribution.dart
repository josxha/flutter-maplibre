import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;
import 'package:maplibre/maplibre.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:url_launcher/url_launcher.dart';

/// Display a zoom-in and zoom-out button to the [MapLibreMap] by using it in
/// [MapLibreMap.children].
///
/// {@category UI}
@immutable
class SourceAttribution extends StatefulWidget {
  /// Display a zoom-in and zoom-out button to the [MapLibreMap] by using it in
  /// [MapLibreMap.children].
  const SourceAttribution({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    this.alignment = Alignment.bottomRight,
    this.showMapLibre = true,
    this.keepExpanded = false,
  });

  /// The padding.
  final EdgeInsets padding;

  /// The alignment.
  final Alignment alignment;

  /// Shows that you are using MapLibre.
  ///
  /// Defaults to true.
  final bool showMapLibre;

  /// Keeps the attribution expanded when the MapCamera changes.
  ///
  /// Defaults to false.
  final bool keepExpanded;

  @override
  State<SourceAttribution> createState() => _SourceAttributionState();
}

class _SourceAttributionState extends State<SourceAttribution> {
  bool _expanded = true;
  MapCamera? _initMapCamera;

  @override
  Widget build(BuildContext context) {
    final style = MapController.maybeOf(context)?.style;
    final camera = MapCamera.maybeOf(context);
    if (style == null || camera == null) return const SizedBox.shrink();

    _initMapCamera ??= camera;
    if (_expanded && !widget.keepExpanded && _initMapCamera != camera) {
      _initMapCamera = null;
      _expanded = false;
    }

    final theme = Theme.of(context);
    return FutureBuilder<List<String>>(
      future: style.getAttributions(),
      initialData: const [],
      builder: (context, snapshot) {
        if (snapshot.error != null) {
          debugPrint('SourceAttribution error: ${snapshot.error}');
          debugPrintStack(stackTrace: snapshot.stackTrace);
        }
        final attributions = snapshot.data ?? const [];
        // Use a SafeArea to ensure the widget is completely visible on devices
        // with rounded edges like iOS.
        return SafeArea(
          child: Container(
            alignment: widget.alignment,
            padding: widget.padding,
            child: PointerInterceptor(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_expanded) ...[
                        if (widget.showMapLibre) ...[
                          Padding(
                            padding: EdgeInsets.only(
                              left: 8,
                              right: attributions.isEmpty ? 0 : 4,
                            ),
                            child: InkWell(
                              child: Text(
                                'MapLibre${attributions.isEmpty ? '' : ' |'}',
                                style: theme.textTheme.bodySmall,
                              ),
                              onTap: () =>
                                  launchUrl(Uri.parse('https://maplibre.org/')),
                            ),
                          ),
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
          ),
        );
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
