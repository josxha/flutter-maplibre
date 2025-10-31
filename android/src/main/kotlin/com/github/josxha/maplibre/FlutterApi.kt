package com.github.josxha.maplibre

import io.flutter.plugin.platform.PlatformView

interface FlutterApi {
    fun createPlatformView(viewId: Int): PlatformView
}
