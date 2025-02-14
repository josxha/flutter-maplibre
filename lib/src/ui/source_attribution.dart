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
    final size = MediaQuery.sizeOf(context);

    final attributions = [
      if (widget.showMapLibre) '<a href="https://maplibre.org/">MapLibre</a>',
      ...style.getAttributionsSync(),
    ];
    return Container(
      alignment: widget.alignment,
      padding: widget.padding,
      child: PointerInterceptor(
        child: Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_expanded)
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 5, left: 10),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: size.width / 2),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 2,
                      runSpacing: 2,
                      children: attributions
                          .map(_HtmlWidget.new)
                          .toList(growable: false),
                    ),
                  ),
                ),
              SizedBox.square(
                dimension: 30,
                child: IconButton(
                  onPressed:
                      () => setState(() {
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
    );
  }
}

class _HtmlWidget extends StatefulWidget {
  const _HtmlWidget(this.html);

  final String html;

  @override
  State<StatefulWidget> createState() => _HtmlWidgetState();
}

class _HtmlWidgetState extends State<_HtmlWidget> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.bodySmall;
    if (_hovering) {
      textStyle = textStyle?.copyWith(decoration: TextDecoration.underline);
    }
    final textSpans = <TextSpan>[];
    final document = html_parser.parse(widget.html);

    for (final node in document.body!.nodes) {
      if (node is dom.Text) {
        // pure text
        textSpans.add(TextSpan(text: node.text));
      } else if (node is dom.Element && node.localName == 'a') {
        // link
        textSpans.add(
          TextSpan(
            onEnter: (event) => setState(() => _hovering = true),
            onExit: (event) => setState(() => _hovering = false),
            text: node.text,
            style: textStyle,
            recognizer:
                TapGestureRecognizer()
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
