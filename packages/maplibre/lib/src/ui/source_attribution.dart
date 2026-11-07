import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;
import 'package:maplibre/maplibre.dart';
import 'package:maplibre/src/ui/map_button.dart';
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

  /// Keeps the attribution expanded when the CameraPosition changes.
  ///
  /// Defaults to false.
  final bool keepExpanded;

  @override
  State<SourceAttribution> createState() => _SourceAttributionState();
}

class _SourceAttributionState extends State<SourceAttribution> {
  bool _expanded = true;
  CameraPosition? _initCameraPosition;

  @override
  Widget build(BuildContext context) {
    final style = MapController.maybeOf(context)?.style;
    final camera = CameraPosition.maybeOf(context);
    if (style == null || camera == null) return const SizedBox.shrink();

    _initCameraPosition ??= camera;
    if (_expanded && !widget.keepExpanded && _initCameraPosition != camera) {
      _initCameraPosition = null;
      _expanded = false;
    }

    final size = MediaQuery.sizeOf(context);

    final attributions = [
      if (widget.showMapLibre)
        '<a href="https://pub.dev/packages/maplibre">MapLibre</a>',
      ...style.attributions,
    ];

    // Use a SafeArea to ensure the widget is completely visible on devices
    // with rounded edges like iOS.
    return SafeArea(
      child: Container(
        alignment: widget.alignment,
        padding: widget.padding,
        child: Container(
          decoration: BoxDecoration(
            color: MapButton.backgroundColor,
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
                child: Semantics(
                  button: true,
                  label: 'Attribution',
                  excludeSemantics: true,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => setState(() {
                        _initCameraPosition = null;
                        _expanded = !_expanded;
                      }),
                      child: const Center(
                        child: CustomPaint(
                          size: Size.square(18),
                          painter: MapButtonIconPainter(
                            MapButtonIcon.info,
                            color: MapButton.iconColor,
                          ),
                        ),
                      ),
                    ),
                  ),
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
    var textStyle = const TextStyle(fontSize: 12, color: Color(0xFF333333));
    if (_hovering) {
      textStyle = textStyle.copyWith(decoration: TextDecoration.underline);
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
    return RichText(
      text: TextSpan(style: textStyle, children: textSpans),
    );
  }
}
