package com.github.josxha.maplibre_native

import android.content.Context
import android.view.Surface

/** The JNI shim in `src/main/cpp`. */
internal object NativeBridge {
    init {
        System.loadLibrary("maplibre_native_jni")
    }

    /**
     * Initializes the MapLibre Native C library for Android: JNI access, APK
     * assets, and TLS verification. Returns null on success, or the reason it
     * failed.
     */
    @JvmStatic
    external fun nativeInit(context: Context): String?

    /**
     * Returns the instance, physical device, device, graphics queue, queue
     * family index, vkGetInstanceProcAddr, and vkGetDeviceProcAddr of the
     * process-wide Vulkan device, creating it on first use.
     */
    @JvmStatic
    external fun nativeVulkanContext(): LongArray

    /** Wraps [surface] in a VkSurfaceKHR and returns its handle. */
    @JvmStatic
    external fun nativeCreateSurface(surface: Surface): Long

    /** Destroys a VkSurfaceKHR from [nativeCreateSurface]. */
    @JvmStatic
    external fun nativeDestroySurface(surface: Long)

    /**
     * Returns the EGLDisplay and EGLConfig that OpenGL ES sessions use,
     * initializing EGL on first use.
     */
    @JvmStatic
    external fun nativeEglContext(): LongArray

    /** Wraps [surface] in an EGLSurface and returns its handle. */
    @JvmStatic
    external fun nativeCreateEglSurface(surface: Surface): Long

    /** Destroys an EGLSurface from [nativeCreateEglSurface]. */
    @JvmStatic
    external fun nativeDestroyEglSurface(surface: Long)

    /** Registers a client of the render thread, which starts on first use. */
    @JvmStatic
    external fun nativeAddRenderClient(): Long

    /** The wake and release callbacks of a render client's wake. */
    @JvmStatic
    external fun nativeRenderClientWake(): LongArray

    /** Hands a render client the session that it services. */
    @JvmStatic
    external fun nativeSetRenderClientSession(
        client: Long,
        session: Long,
    )

    /** Stops servicing a render client once its work in flight is done. */
    @JvmStatic
    external fun nativeRemoveRenderClient(client: Long)
}
