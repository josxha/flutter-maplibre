package com.github.josxha.maplibre_native

import android.content.Context
import android.view.Surface
import io.flutter.view.TextureRegistry

/**
 * What Dart calls on Android, through the jnigen bindings in
 * `lib/src/android/bindings.g.dart`. Regenerate them with
 * `dart run jnigen --config packages/maplibre_native/jnigen.yaml` from the
 * repository root after changing this API.
 *
 * MapLibre renders through Vulkan into the Surface of a Flutter
 * [TextureRegistry.SurfaceProducer], so the map is a Flutter texture that
 * composes like any other widget. Dart calls these on its UI thread, which is
 * the main thread.
 */
object MaplibreNativeApi {
    private var context: Context? = null
    private var textures: TextureRegistry? = null
    private val surfaceTextures = mutableMapOf<Long, SurfaceTexture>()
    private var initialized = false

    /** A Flutter texture and the Vulkan surface of its current Surface. */
    private class SurfaceTexture(
        val producer: TextureRegistry.SurfaceProducer,
    ) {
        var surface: Surface? = null
        var vkSurface: Long = 0

        /**
         * Wraps the producer's current Surface. Returns the old Vulkan surface
         * when the Surface changed, which the caller releases once the session
         * moved to the new one.
         */
        fun refresh(): Long? {
            val current = producer.surface
            if (current === surface && vkSurface != 0L) return null
            val old = vkSurface.takeIf { it != 0L }
            surface = current
            vkSurface = NativeBridge.nativeCreateSurface(current)
            return old
        }
    }

    internal fun attach(
        context: Context,
        textures: TextureRegistry,
    ) {
        this.context = context
        this.textures = textures
    }

    internal fun detach(textures: TextureRegistry) {
        if (this.textures !== textures) return
        for (texture in surfaceTextures.values) {
            NativeBridge.nativeDestroySurface(texture.vkSurface)
            texture.producer.release()
        }
        surfaceTextures.clear()
        this.textures = null
    }

    /**
     * Initializes the C library for Android once, and returns the instance,
     * physical device, device, graphics queue, queue family index,
     * vkGetInstanceProcAddr, and vkGetDeviceProcAddr of the process-wide
     * Vulkan device.
     */
    @JvmStatic
    fun vulkanContext(): LongArray {
        if (!initialized) {
            val context = checkNotNull(context) { "maplibre_native is not attached to an engine." }
            NativeBridge.nativeInit(context)?.let {
                throw IllegalStateException("mln_android_init failed: $it")
            }
            initialized = true
        }
        return NativeBridge.nativeVulkanContext()
    }

    /**
     * Creates a SurfaceProducer texture of [width] x [height] pixels and
     * returns its texture id and the Vulkan surface of its Surface.
     */
    @JvmStatic
    fun createSurfaceTexture(
        width: Int,
        height: Int,
        listener: SurfaceListener,
    ): LongArray {
        val textures = checkNotNull(textures) { "maplibre_native is not attached to an engine." }
        val producer = textures.createSurfaceProducer()
        producer.setSize(width, height)
        val texture = SurfaceTexture(producer)
        texture.refresh()
        val id = producer.id()
        surfaceTextures[id] = texture
        producer.setCallback(
            object : TextureRegistry.SurfaceProducer.Callback {
                override fun onSurfaceAvailable() {
                    // Reported even when the Surface stayed the same (old is
                    // then 0), because Dart paused rendering on cleanup.
                    val old = texture.refresh() ?: 0L
                    listener.onSurfaceChanged(texture.vkSurface, old)
                }

                override fun onSurfaceCleanup() {
                    listener.onSurfaceCleanup()
                }
            },
        )
        return longArrayOf(id, texture.vkSurface)
    }

    /**
     * Sizes a texture's buffers and returns its Vulkan surface and, when
     * Flutter handed out a new Surface, the old one, else 0.
     */
    @JvmStatic
    fun resizeSurfaceTexture(
        textureId: Long,
        width: Int,
        height: Int,
    ): LongArray {
        val texture = checkNotNull(surfaceTextures[textureId]) { "No texture $textureId." }
        texture.producer.setSize(width, height)
        val old = texture.refresh() ?: 0L
        return longArrayOf(texture.vkSurface, old)
    }

    /** Destroys a Vulkan surface that no session presents to anymore. */
    @JvmStatic
    fun releaseSurface(surface: Long) {
        NativeBridge.nativeDestroySurface(surface)
    }

    /**
     * Releases a texture. [keepSurface] keeps its Vulkan surface, which a
     * swapchain that abandon quarantined still needs.
     */
    @JvmStatic
    fun disposeTexture(
        textureId: Long,
        keepSurface: Boolean,
    ) {
        val texture = surfaceTextures.remove(textureId) ?: return
        if (!keepSurface) NativeBridge.nativeDestroySurface(texture.vkSurface)
        texture.producer.release()
    }
}
