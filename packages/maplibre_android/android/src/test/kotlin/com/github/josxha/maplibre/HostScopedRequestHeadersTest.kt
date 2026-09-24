package com.github.josxha.maplibre

import okhttp3.Request
import kotlin.test.AfterTest
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertNull
import kotlin.test.assertSame

internal class HostScopedRequestHeadersTest {
    @AfterTest
    fun clearHeaders() {
        HostScopedRequestHeaders.clear("maps.example.com")
    }

    @Test
    fun `applies headers only to the exact host`() {
        HostScopedRequestHeaders.replace(
            "maps.example.com",
            mapOf("X-Firebase-AppCheck" to "token"),
        )

        val matching = request("https://maps.example.com/style.json")
        val subdomain = request("https://cdn.maps.example.com/tile.pbf")
        val unrelated = request("https://example.com/tile.pbf")

        assertEquals(
            "token",
            applyHostScopedRequestHeaders(matching).header("X-Firebase-AppCheck"),
        )
        assertSame(subdomain, applyHostScopedRequestHeaders(subdomain))
        assertSame(unrelated, applyHostScopedRequestHeaders(unrelated))
    }

    @Test
    fun `replaces all headers for one host`() {
        HostScopedRequestHeaders.replace(
            "maps.example.com",
            mapOf("Authorization" to "old", "X-Old" to "remove"),
        )
        HostScopedRequestHeaders.replace(
            "maps.example.com",
            mapOf("Authorization" to "new"),
        )

        val request =
            applyHostScopedRequestHeaders(
                request("https://maps.example.com/tile.pbf"),
            )

        assertEquals("new", request.header("Authorization"))
        assertNull(request.header("X-Old"))
    }

    @Test
    fun `removes configured headers when the host changes`() {
        HostScopedRequestHeaders.replace(
            "maps.example.com",
            mapOf("X-Firebase-AppCheck" to "token"),
        )
        val redirected =
            request("https://example.com/tile.pbf")
                .newBuilder()
                .header("X-Firebase-AppCheck", "token")
                .build()

        assertNull(
            applyHostScopedRequestHeaders(redirected).header("X-Firebase-AppCheck"),
        )
    }

    @Test
    fun `keeps configured headers when the host stays the same`() {
        HostScopedRequestHeaders.replace(
            "maps.example.com",
            mapOf("X-Firebase-AppCheck" to "token"),
        )
        val redirected =
            request("https://maps.example.com/other.pbf")
                .newBuilder()
                .header("X-Firebase-AppCheck", "token")
                .build()

        assertEquals(
            "token",
            applyHostScopedRequestHeaders(redirected).header("X-Firebase-AppCheck"),
        )
    }

    @Test
    fun `clear stops injecting headers`() {
        HostScopedRequestHeaders.replace(
            "maps.example.com",
            mapOf("Authorization" to "token"),
        )
        HostScopedRequestHeaders.clear("MAPS.EXAMPLE.COM")
        val request = request("https://maps.example.com/tile.pbf")

        assertSame(request, applyHostScopedRequestHeaders(request))
    }

    private fun request(url: String) = Request.Builder().url(url).build()
}
