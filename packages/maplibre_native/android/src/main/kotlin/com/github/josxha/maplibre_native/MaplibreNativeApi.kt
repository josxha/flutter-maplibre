package com.github.josxha.maplibre_native

import android.content.Context
import android.view.Surface
import io.flutter.view.TextureRegistry

/**
 * What Dart calls on Android, through the jnigen bindings in
 * `lib/src/android/bindings.g.dart`. Regenerate them with
 * `dart run jnigen.dart` from `tool/codegen` after changing this API.
 *
 * MapLibre renders into the Surface of a Flutter
 * [TextureRegistry.SurfaceProducer], so the map is a Flutter texture that
 * composes like any other widget. Depending on the backend the C library was
 * built with, the Surface is wrapped as an EGLSurface (OpenGL ES) or a
 * VkSurfaceKHR (Vulkan). Dart calls these on its UI thread, which is the main
 * thread.
 */
object MaplibreNativeApi {
    private var context: Context? = null
    private var textures: TextureRegistry? = null
    private val surfaceTextures = mutableMapOf<Long, SurfaceTexture>()
    private var initialized = false

    /**
     * A Flutter texture and the EGL or Vulkan surface of its current Surface.
     */
    private class SurfaceTexture(
        val producer: TextureRegistry.SurfaceProducer,
        val opengl: Boolean,
    ) {
        var surface: Surface? = null
        var handle: Long = 0

        /**
         * Wraps the producer's current Surface. Returns the old surface handle
         * when the Surface changed, which the caller releases once the session
         * moved to the new one.
         */
        fun refresh(): Long? {
            val current = producer.surface
            if (current === surface && handle != 0L) return null
            val old = handle.takeIf { it != 0L }
            surface = current
            handle =
                if (opengl) {
                    NativeBridge.nativeCreateEglSurface(current)
                } else {
                    NativeBridge.nativeCreateSurface(current)
                }
            return old
        }
    }

    private fun destroySurface(
        surface: Long,
        opengl: Boolean,
    ) {
        if (opengl) {
            NativeBridge.nativeDestroyEglSurface(surface)
        } else {
            NativeBridge.nativeDestroySurface(surface)
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
            destroySurface(texture.handle, texture.opengl)
            texture.producer.release()
        }
        surfaceTextures.clear()
        this.textures = null
    }

    /** Initializes the C library for Android once. */
    @JvmStatic
    fun initialize() {
        if (initialized) return
        val context = checkNotNull(context) { "maplibre_native is not attached to an engine." }
        NativeBridge.nativeInit(context)?.let {
            throw IllegalStateException("mln_android_init failed: $it")
        }
        initialized = true
    }

    /**
     * Initializes the C library for Android once, and returns the instance,
     * physical device, device, graphics queue, queue family index,
     * vkGetInstanceProcAddr, and vkGetDeviceProcAddr of the process-wide
     * Vulkan device.
     */
    @JvmStatic
    fun vulkanContext(): LongArray {
        initialize()
        return NativeBridge.nativeVulkanContext()
    }

    /**
     * Initializes the C library for Android once, and returns the EGLDisplay
     * and EGLConfig that OpenGL ES sessions create their contexts from.
     */
    @JvmStatic
    fun eglContext(): LongArray {
        initialize()
        return NativeBridge.nativeEglContext()
    }

    /**
     * Creates a SurfaceProducer texture of [width] x [height] pixels and
     * returns its texture id and the surface handle of its Surface: an
     * EGLSurface when [opengl] is set, else a VkSurfaceKHR.
     */
    @JvmStatic
    fun createSurfaceTexture(
        width: Int,
        height: Int,
        opengl: Boolean,
        listener: SurfaceListener,
    ): LongArray {
        val textures = checkNotNull(textures) { "maplibre_native is not attached to an engine." }
        val producer = textures.createSurfaceProducer()
        producer.setSize(width, height)
        val texture = SurfaceTexture(producer, opengl)
        texture.refresh()
        val id = producer.id()
        surfaceTextures[id] = texture
        producer.setCallback(
            object : TextureRegistry.SurfaceProducer.Callback {
                override fun onSurfaceAvailable() {
                    // Reported even when the Surface stayed the same (old is
                    // then 0), because Dart paused rendering on cleanup.
                    val old = texture.refresh() ?: 0L
                    listener.onSurfaceChanged(texture.handle, old)
                }

                override fun onSurfaceCleanup() {
                    listener.onSurfaceCleanup()
                }
            },
        )
        return longArrayOf(id, texture.handle)
    }

    /**
     * Sizes a texture's buffers and returns its surface handle and, when
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
        return longArrayOf(texture.handle, old)
    }

    /**
     * Destroys an EGL ([opengl]) or Vulkan surface that no session presents to
     * anymore.
     */
    @JvmStatic
    fun releaseSurface(
        surface: Long,
        opengl: Boolean,
    ) {
        destroySurface(surface, opengl)
    }

    /**
     * Releases a texture. [keepSurface] keeps its surface, which a Vulkan
     * swapchain that abandon quarantined still needs.
     */
    @JvmStatic
    fun disposeTexture(
        textureId: Long,
        keepSurface: Boolean,
    ) {
        val texture = surfaceTextures.remove(textureId) ?: return
        if (!keepSurface) destroySurface(texture.handle, texture.opengl)
        texture.producer.release()
    }

    /**
     * Starts the thread that services the OpenGL ES render session [session],
     * a caller-graphics-thread session, and returns its handle.
     */
    @JvmStatic
    fun startRenderThread(session: Long): Long = NativeBridge.nativeStartRenderThread(session)

    /** Makes a render thread service its session's queued driver work. */
    @JvmStatic
    fun wakeRenderThread(thread: Long) {
        NativeBridge.nativeWakeRenderThread(thread)
    }

    /**
     * Ends a render thread after its work in flight. Its session must be
     * detached or have no work left.
     */
    @JvmStatic
    fun stopRenderThread(thread: Long) {
        NativeBridge.nativeStopRenderThread(thread)
    }
}
