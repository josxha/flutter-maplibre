package org.maplibre.maplibregl

import android.content.Context
import android.view.View
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import org.maplibre.android.camera.CameraPosition

import com.github.josxha.maplibre.LifecycleProvider

class MapLibreMapFactory(
    private val messenger: BinaryMessenger,
    private val lifecycleProvider: LifecycleProvider
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context?, id: Int, args: Any?): PlatformView {
        val params = args as? Map<String, Any>
            ?: throw IllegalArgumentException("Args must be a Map")
        val builder = MapLibreMapBuilder()

        Convert.interpretMapLibreMapOptions(
            params["options"] as? Map<String, Any>,
            builder,
            context
        )
        if (params.containsKey("initialCameraPosition")) {
            val position =
                Convert.toCameraPosition(params["initialCameraPosition"] as Map<String, Any>)
            builder.setInitialCameraPosition(position)
        }
        if (params.containsKey("dragEnabled")) {
            val dragEnabled = Convert.toBoolean(params["dragEnabled"])
            builder.setDragEnabled(dragEnabled)
        }
        if (params.containsKey("styleString")) {
            val styleString = Convert.toString(params["styleString"])
            builder.setStyleString(styleString)
        }

        return builder.build(id, context, messenger, lifecycleProvider)
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

class MapLibreMapBuilder {
    fun setInitialCameraPosition(position: CameraPosition) {
        // Set initial camera position
    }

    fun setDragEnabled(enabled: Boolean) {
        // Set drag enabled
    }

    fun setStyleString(style: String) {
        // Set style string
    }

    fun build(
        id: Int,
        context: Context?,
        messenger: BinaryMessenger,
        lifecycleProvider: LifecycleProvider
    ): PlatformView {
        // Build and return the PlatformView
        return object : PlatformView {
            override fun getView(): View {
                // Replace with actual view creation logic
                return View(context)
            }

            override fun dispose() {}
        }
    }
}
