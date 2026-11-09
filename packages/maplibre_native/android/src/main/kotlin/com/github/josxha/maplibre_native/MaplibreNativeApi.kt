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
 *
 * Every Flutter engine of the process attaches its own texture registry, for
 * example a second engine of a background service. Dart passes the id of its
 * engine, `PlatformDispatcher.instance.engineId`, so each map's texture lives
 * in the registry of the engine that shows it, and an engine that goes away
 * releases only its own textures.
 */
object MaplibreNativeApi {
    /** The texture registry of an engine, and the textures created there. */
    private class Engine(
        val textures: TextureRegistry,
    ) {
        val producers = mutableMapOf<Long, TextureRegistry.SurfaceProducer>()
    }

    private var context: Context? = null
    private val engines = mutableMapOf<Long, Engine>()

    internal fun attach(
        engineId: Long,
        context: Context,
        textures: TextureRegistry,
    ) {
        this.context = context
        engines[engineId] = Engine(textures)
    }

    internal fun detach(engineId: Long) {
        val engine = engines.remove(engineId) ?: return
        for (producer in engine.producers.values) producer.release()
        engine.producers.clear()
    }

    private fun engine(engineId: Long): Engine = checkNotNull(engines[engineId]) { "maplibre_native is not attached to engine $engineId." }

    private fun producer(
        engineId: Long,
        textureId: Long,
    ): TextureRegistry.SurfaceProducer = checkNotNull(engine(engineId).producers[textureId]) { "No texture $textureId." }

    /** The application context, which the C library needs on Android. */
    @JvmStatic
    fun applicationContext(): Context = checkNotNull(context) { "maplibre_native is not attached to an engine." }

    /**
     * Creates a SurfaceProducer texture of [width] x [height] pixels in the
     * registry of the engine [engineId] and returns its texture id.
     * [listener] hears when its Surface goes and comes back.
     */
    @JvmStatic
    fun createSurfaceTexture(
        engineId: Long,
        width: Int,
        height: Int,
        listener: SurfaceListener,
    ): Long {
        val engine = engine(engineId)
        val producer = engine.textures.createSurfaceProducer()
        producer.setSize(width, height)
        val id = producer.id()
        engine.producers[id] = producer
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
    fun surface(
        engineId: Long,
        textureId: Long,
    ): Surface = producer(engineId, textureId).surface

    /**
     * Sizes a texture's buffers. Returns whether Flutter handed out a new
     * Surface for them.
     */
    @JvmStatic
    fun resizeSurfaceTexture(
        engineId: Long,
        textureId: Long,
        width: Int,
        height: Int,
    ): Boolean {
        val producer = producer(engineId, textureId)
        val surface = producer.surface
        producer.setSize(width, height)
        return producer.surface !== surface
    }

    /** Releases a texture that no session presents to anymore. */
    @JvmStatic
    fun disposeTexture(
        engineId: Long,
        textureId: Long,
    ) {
        engines[engineId]?.producers?.remove(textureId)?.release()
    }
}
