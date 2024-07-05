package com.github.josxha.maplibre

import android.content.Context
import android.view.View
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import org.maplibre.android.camera.CameraPosition
import com.github.josxha.maplibre.MapLibreMapBuilder

import com.github.josxha.maplibre.LifecycleProvider

class MapLibreMapFactory(
    private val messenger: BinaryMessenger,
    private val lifecycleProvider: LifecycleProvider
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val params = args as? Map<String, Any>
            ?: throw IllegalArgumentException("Args must be a Map")
        val builder = MapLibreMapBuilder()

        Convert.interpretMapLibreMapOptions(
            params["options"] as? Map<String, Any>,
            builder,
            context
        )
        if (params.containsKey("styleString")) {
            val styleString = Convert.toString(params["styleString"])
            builder.setStyleString(styleString)
        }

        return builder.build(viewId, context, messenger, lifecycleProvider)
    }
}

// Dummy implementations for Convert and MapLibreMapBuilder classes
object Convert {
    fun interpretMapLibreMapOptions(
        options: Map<String, Any>?,
        builder: MapLibreMapBuilder,
        context: Context?
    ) {
        // Interpret and set options on builder
    }

    fun toCameraPosition(position: Map<String, Any>): CameraPosition {
        // Convert to CameraPosition
        return CameraPosition.Builder()
            .build() // Example placeholder implementation
    }

    fun toBoolean(value: Any?): Boolean {
        return value as? Boolean ?: false
    }

    fun toString(value: Any?): String {
        return value as? String ?: ""
    }
}
