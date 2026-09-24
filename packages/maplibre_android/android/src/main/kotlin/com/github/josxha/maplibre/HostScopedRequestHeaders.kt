package com.github.josxha.maplibre

import okhttp3.Dispatcher
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.Response
import org.maplibre.android.module.http.HttpRequestUtil
import java.util.concurrent.atomic.AtomicBoolean

internal fun applyHostScopedRequestHeaders(request: Request): Request {
    val headers =
        HostScopedRequestHeaders.headersForHost(request.url.host) ?: return request
    return request
        .newBuilder()
        .apply {
            headers.forEach { (name, value) -> header(name, value) }
        }.build()
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
            .addInterceptor(HostScopedRequestHeadersInterceptor)
            .build()
    HttpRequestUtil.setOkHttpClient(client)
}

private val requestHeadersInterceptorInstalled = AtomicBoolean()
