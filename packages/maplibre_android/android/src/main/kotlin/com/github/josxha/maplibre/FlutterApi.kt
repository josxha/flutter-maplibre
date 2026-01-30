package com.github.josxha.maplibre

import androidx.annotation.Keep
import io.flutter.plugin.platform.PlatformView

@Keep
interface FlutterApi {
    fun createPlatformView(viewId: Int): PlatformView
}
