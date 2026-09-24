/// Mutable request headers keyed by normalized, exact request host.
abstract final class HostScopedRequestHeaders {
  static final _headersByHost = <String, Map<String, String>>{};

  /// Replaces all headers for [host].
  static void replace(String host, Map<String, String> headers) {
    if (headers.isEmpty) {
      _headersByHost.remove(host);
    } else {
      _headersByHost[host] = Map.unmodifiable(headers);
    }
  }

  /// Clears all headers for [host].
  static void clear(String host) {
    _headersByHost.remove(host);
  }

  /// Returns the headers configured for the exact host in [url].
  static Map<String, String>? forUrl(String url) {
    final host = Uri.tryParse(url)?.host.toLowerCase();
    if (host == null || host.isEmpty) return null;
    return _headersByHost[host];
  }
}
