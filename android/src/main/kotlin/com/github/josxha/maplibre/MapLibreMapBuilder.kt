package com.github.josxha.maplibre

import android.content.Context
import org.maplibre.android.maps.MapLibreMapOptions
import io.flutter.plugin.common.BinaryMessenger

class MapLibreMapBuilder {
    private lateinit var options: MapLibreMapOptions

    fun build(
        viewId: Int,
        context: Context,
        messenger: BinaryMessenger?,
        lifecycleProvider: LifecycleProvider
    ): MapLibreMapController {
        options = MapLibreMapOptions.createFromAttributes(context)
            .attributionEnabled(true)
            .logoEnabled(false)
            .textureMode(true)
        val controller = MapLibreMapController(context, options, "")
        controller.init(lifecycleProvider)
        return controller
    }

    fun setStyleString(styleString: String) {
        TODO("Not yet implemented")
    }
}