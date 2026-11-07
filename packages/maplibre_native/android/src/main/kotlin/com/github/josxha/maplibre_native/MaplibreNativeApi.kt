package com.github.josxha.maplibre_native

import android.content.Context
import android.view.Surface
import io.flutter.view.TextureRegistry

/**
 * What Dart calls on Android, through the jnigen bindings in
 * `lib/src/android/bindings.g.dart`. Regenerate them with
 * `dart run jnigen.dart` from `tool/codegen` after changing this API.
 *
 * MapLibre presents to the Surface of a Flutter
 * [TextureRegistry.SurfaceProducer], with a graphics context that the C
 * library creates, so the map is a Flutter texture that composes like any
 * other widget. Dart calls these on its UI thread, which is the main thread.
 */
object MaplibreNativeApi {
    private var context: Context? = null
    private var textures: TextureRegistry? = null
    private val producers = mutableMapOf<Long, TextureRegistry.SurfaceProducer>()

    internal fun attach(
        context: Context,
        textures: TextureRegistry,
    ) {
        this.context = context
        this.textures = textures
    }

    internal fun detach(textures: TextureRegistry) {
        if (this.textures !== textures) return
        for (producer in producers.values) producer.release()
        producers.clear()
        this.textures = null
    }

    /** The application context, which the C library needs on Android. */
    @JvmStatic
    fun applicationContext(): Context = checkNotNull(context) { "maplibre_native is not attached to an engine." }

    /**
     * Creates a SurfaceProducer texture of [width] x [height] pixels and
     * returns its texture id. [listener] hears when its Surface goes and comes
     * back.
     */
    @JvmStatic
    fun createSurfaceTexture(
        width: Int,
        height: Int,
        listener: SurfaceListener,
    ): Long {
        val textures = checkNotNull(textures) { "maplibre_native is not attached to an engine." }
        val producer = textures.createSurfaceProducer()
        producer.setSize(width, height)
        val id = producer.id()
        producers[id] = producer
        producer.setCallback(
            object : TextureRegistry.SurfaceProducer.Callback {
                override fun onSurfaceAvailable() {
                    listener.onSurfaceAvailable()
                }

                override fun onSurfaceCleanup() {
                    listener.onSurfaceCleanup()
                }
            },
        )
        return id
    }

    /** The current Surface of a texture, which Flutter may replace. */
    @JvmStatic
    fun surface(textureId: Long): Surface {
        val producer = checkNotNull(producers[textureId]) { "No texture $textureId." }
        return producer.surface
    }

    /**
     * Sizes a texture's buffers. Returns whether Flutter handed out a new
     * Surface for them.
     */
    @JvmStatic
    fun resizeSurfaceTexture(
        textureId: Long,
        width: Int,
        height: Int,
    ): Boolean {
        val producer = checkNotNull(producers[textureId]) { "No texture $textureId." }
        val surface = producer.surface
        producer.setSize(width, height)
        return producer.surface !== surface
    }

    /** Releases a texture that no session presents to anymore. */
    @JvmStatic
    fun disposeTexture(textureId: Long) {
        producers.remove(textureId)?.release()
    }
}
