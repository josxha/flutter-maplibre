package com.github.josxha.maplibre

import okhttp3.Dispatcher
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.Response
import org.maplibre.android.module.http.HttpRequestUtil
import java.util.concurrent.atomic.AtomicBoolean

internal fun applyHostScopedRequestHeaders(request: Request): Request {
    val headers = HostScopedRequestHeaders.headersForHost(request.url.host)
    val managedNames = HostScopedRequestHeaders.configuredHeaderNames()
    if (headers == null && managedNames.none { request.header(it) != null }) {
        return request
    }
    val builder = request.newBuilder()
    for (name in managedNames) {
        if (headers == null || !headers.containsKey(name)) {
            builder.removeHeader(name)
        }
    }
    headers?.forEach { (name, value) -> builder.header(name, value) }
    return builder.build()
}

internal object HostScopedRequestHeadersInterceptor : Interceptor {
    override fun intercept(chain: Interceptor.Chain): Response = chain.proceed(applyHostScopedRequestHeaders(chain.request()))
}

internal fun installHostScopedRequestHeadersInterceptor() {
    if (!requestHeadersInterceptorInstalled.compareAndSet(false, true)) return
    val dispatcher = Dispatcher().apply { maxRequestsPerHost = 20 }
    val client =
        OkHttpClient
            .Builder()
            .dispatcher(dispatcher)
            // Network interceptors run on each redirect hop, so a header for one
            // host is removed when OkHttp follows a redirect to another host.
            .addNetworkInterceptor(HostScopedRequestHeadersInterceptor)
            .build()
    HttpRequestUtil.setOkHttpClient(client)
}

private val requestHeadersInterceptorInstalled = AtomicBoolean()
