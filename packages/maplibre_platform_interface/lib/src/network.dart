import 'package:flutter/foundation.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart';

/// The kind of resource that a map requests.
///
/// {@category Network}
enum MapResourceKind {
  /// A resource of no other kind.
  unknown,

  /// A style JSON.
  style,

  /// The TileJSON of a source.
  source,

  /// A tile.
  tile,

  /// A glyph range of a font.
  glyphs,

  /// The image of a sprite.
  spriteImage,

  /// The JSON index of a sprite.
  spriteJson,

  /// An image, such as the one of an image source.
  image,
}

/// Rewrites the URL of a request before a map sends it.
///
/// Return [url] to keep it. Runs for every request of every map, so return
/// quickly.
///
/// {@category Network}
typedef UrlTransform = String Function(String url, MapResourceKind kind);

/// HTTP headers to send with the requests whose URL matches [url].
///
/// {@category Network}
@immutable
class RequestHeaders {
  /// Sends [headers] with the requests whose URL matches the glob [url], of
  /// the [kinds] given or of every kind.
  const RequestHeaders(this.headers, {this.url = '**', this.kinds});

  /// The headers to send, by name.
  ///
  /// Header names ignore letter case. Headers that the platform manages, such
  /// as `Host`, `User-Agent` or `Range`, can't be set. On web, the browser
  /// asks the server for permission (a CORS preflight) before a cross-origin
  /// request with custom headers.
  final Map<String, String> headers;

  /// The glob pattern that the whole request URL, query included, must match.
  ///
  /// `*` matches any characters except `/`, `**` any characters, and `?` one
  /// character except `/`. `\` makes the next character match only itself.
  /// For example, `https://*.example.com/tiles/**` matches every URL under
  /// `/tiles/` on each subdomain of `example.com`. Defaults to `**`, every
  /// URL.
  final String url;

  /// The kinds of resource to send the headers with, or null for every kind.
  /// An empty set matches no request.
  final Set<MapResourceKind>? kinds;

  /// The patterns of the [url]s, as regular expressions.
  static final _patterns = <String, RegExp>{};

  /// Whether a request for [requestUrl] of [kind] gets these headers.
  bool matches(String requestUrl, MapResourceKind kind) =>
      (kinds?.contains(kind) ?? true) &&
      _patterns.putIfAbsent(url, () => _globToRegExp(url)).hasMatch(requestUrl);

  static RegExp _globToRegExp(String glob) {
    final pattern = StringBuffer('^');
    for (var i = 0; i < glob.length; i++) {
      final char = glob[i];
      switch (char) {
        case r'\' when i + 1 < glob.length:
          pattern.write(RegExp.escape(glob[++i]));
        case '*' when i + 1 < glob.length && glob[i + 1] == '*':
          pattern.write('.*');
          i++;
        case '*':
          pattern.write('[^/]*');
        case '?':
          pattern.write('[^/]');
        default:
          pattern.write(RegExp.escape(char));
      }
    }
    pattern.write(r'$');
    return RegExp(pattern.toString(), dotAll: true);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestHeaders &&
          url == other.url &&
          setEquals(kinds, other.kinds) &&
          mapEquals(headers, other.headers);

  @override
  int get hashCode => Object.hash(
    url,
    kinds == null ? null : Object.hashAllUnordered(kinds!),
    Object.hashAllUnordered(
      headers.entries.map((e) => Object.hash(e.key, e.value)),
    ),
  );

  @override
  String toString() =>
      'RequestHeaders($headers, url: $url, kinds: ${kinds?.toList()})';
}

/// How every map and the [OfflineManager] request their resources.
///
/// The settings apply to every map, the ones that exist and the ones created
/// later, and to the downloads of the [OfflineManager]:
///
/// ```dart
/// MapLibreNetwork.requestHeaders = [
///   RequestHeaders(
///     {'Authorization': 'Bearer $token'},
///     url: 'https://tiles.example.com/**',
///   ),
/// ];
/// MapLibreNetwork.urlTransform = (url, kind) =>
///     url.replaceFirst('http://', 'https://');
/// ```
///
/// {@category Network}
abstract final class MapLibreNetwork {
  static List<RequestHeaders> _requestHeaders = const [];
  static UrlTransform? _urlTransform;
  static final _changes = _Changes();

  /// The headers to send with requests. The first entry whose
  /// [RequestHeaders.matches] the request adds its headers, and no other.
  /// Requests that no entry matches get no extra headers.
  ///
  /// Headers match the URL after [urlTransform]. Defaults to none.
  static List<RequestHeaders> get requestHeaders => _requestHeaders;

  static set requestHeaders(List<RequestHeaders> value) {
    if (listEquals(value, _requestHeaders)) return;
    _requestHeaders = List.unmodifiable(value);
    _changes.notify();
  }

  /// Rewrites the URL of every request, or null to keep the URLs. Defaults
  /// to null.
  ///
  /// An error that it throws is reported to [FlutterError.onError], and the
  /// request keeps its URL.
  static UrlTransform? get urlTransform => _urlTransform;

  static set urlTransform(UrlTransform? value) {
    if (value == _urlTransform) return;
    _urlTransform = value;
    _changes.notify();
  }

  /// Notifies the platform implementations when a setting changes.
  static Listenable get changes => _changes;

  /// The headers for a request for [url] of [kind], from the first entry of
  /// [requestHeaders] that matches it, or null if none does.
  static Map<String, String>? headersFor(String url, MapResourceKind kind) {
    for (final entry in _requestHeaders) {
      if (entry.matches(url, kind)) return entry.headers;
    }
    return null;
  }

  /// The URL that [urlTransform] gives for a request for [url] of [kind], or
  /// [url] if it is null or throws.
  static String transformUrl(String url, MapResourceKind kind) {
    final transform = _urlTransform;
    if (transform == null) return url;
    try {
      return transform(url, kind);
    } on Object catch (error, stack) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stack,
          library: 'maplibre',
          context: ErrorDescription('while transforming the URL $url'),
        ),
      );
      return url;
    }
  }

  /// Restores the defaults: no headers and no URL transform.
  static void reset() {
    requestHeaders = const [];
    urlTransform = null;
  }
}

class _Changes extends ChangeNotifier {
  void notify() => notifyListeners();
}
