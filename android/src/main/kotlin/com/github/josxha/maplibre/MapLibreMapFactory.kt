package com.github.josxha.maplibre

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

import org.maplibre.android.maps.MapLibreMapOptions

class MapLibreMapFactory(
    private val lifecycleProvider: LifecycleProvider,
    private val binaryMessenger: BinaryMessenger
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val params = args as Map<*, *>

        val options = MapLibreMapOptions.createFromAttributes(context)
            .attributionEnabled(true)
            .logoEnabled(true)
            .textureMode(true)
            .compassEnabled(true)
        return MapLibreMapController(
            viewId,
            context,
            options,
            "https://demotiles.maplibre.org/style.json",
            lifecycleProvider,
            binaryMessenger,
        )
    }
}