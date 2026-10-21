package com.github.josxha.maplibre

import android.content.Context
import io.flutter.plugin.platform.PlatformView
import org.mockito.Mockito.mock
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertSame

internal class MapLibrePluginTest {
    @Test
    fun create_initializesMapLibreBeforeInstallingRequestInterceptor() {
        val calls = mutableListOf<String>()
        val platformView = mock(PlatformView::class.java)
        val factory =
            MapLibreMapFactory(
                createPlatformView = {
                    calls += "initialize_maplibre"
                    platformView
                },
                installRequestHeadersInterceptor = {
                    calls += "install_request_interceptor"
                },
            )

        val result = factory.create(mock(Context::class.java), 7, null)

        assertSame(platformView, result)
        assertEquals(
            listOf("initialize_maplibre", "install_request_interceptor"),
            calls,
        )
    }
}
