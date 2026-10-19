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
}
