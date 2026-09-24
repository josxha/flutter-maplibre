package com.github.josxha.maplibre;

import androidx.annotation.Keep;
import java.util.Collections;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Host-scoped request headers read by the MapLibre OkHttp interceptor.
 *
 * <p>Static methods are the jnigen entry points used to replace or clear headers for one exact
 * host.
 */
@Keep
public final class HostScopedRequestHeaders {
    private static final ConcurrentHashMap<String, Map<String, String>> headersByHost =
            new ConcurrentHashMap<>();

    private HostScopedRequestHeaders() {}

    public static void replace(String host, Map<String, String> headers) {
        final String normalizedHost = host.toLowerCase(Locale.ROOT);
        if (headers.isEmpty()) {
            headersByHost.remove(normalizedHost);
            return;
        }
        headersByHost.put(
                normalizedHost, Collections.unmodifiableMap(new HashMap<>(headers)));
    }

    public static void clear(String host) {
        headersByHost.remove(host.toLowerCase(Locale.ROOT));
    }

    public static Map<String, String> headersForHost(String host) {
        return headersByHost.get(host.toLowerCase(Locale.ROOT));
    }
}
