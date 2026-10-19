package com.github.josxha.maplibre_native

import android.content.Context
import android.os.Handler
import android.os.Looper
import android.view.Surface
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.TextureRegistry

/**
 * Android side of maplibre_native.
 *
 * MapLibre renders through Vulkan into the Surface of a Flutter
 * [TextureRegistry.SurfaceProducer], so the map is a Flutter texture that
 * composes like any other widget.
 */
class MaplibreNativePlugin :
    FlutterPlugin,
    MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var textures: TextureRegistry
    private val mainHandler = Handler(Looper.getMainLooper())
    private val surfaceTextures = mutableMapOf<Long, SurfaceTexture>()
    private var initialized = false

    /** A Flutter texture and the Vulkan surface of its current Surface. */
    private inner class SurfaceTexture(
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

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        textures = binding.textureRegistry
        channel = MethodChannel(binding.binaryMessenger, "maplibre_native")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        for (texture in surfaceTextures.values) {
            NativeBridge.nativeDestroySurface(texture.vkSurface)
            texture.producer.release()
        }
        surfaceTextures.clear()
    }

    override fun onMethodCall(
        call: MethodCall,
        result: MethodChannel.Result,
    ) {
        try {
            when (call.method) {
                "vulkanContext" -> {
                    if (!initialized) {
                        NativeBridge.nativeInit(context)?.let {
                            throw IllegalStateException("mln_android_init failed: $it")
                        }
                        initialized = true
                    }
                    val values = NativeBridge.nativeVulkanContext()
                    result.success(
                        mapOf(
                            "instance" to values[0],
                            "physicalDevice" to values[1],
                            "device" to values[2],
                            "queue" to values[3],
                            "queueFamilyIndex" to values[4],
                            "getInstanceProcAddr" to values[5],
                            "getDeviceProcAddr" to values[6],
                        ),
                    )
                }

                "createSurfaceTexture" -> {
                    val producer = textures.createSurfaceProducer()
                    producer.setSize(call.argument<Int>("width")!!, call.argument<Int>("height")!!)
                    val texture = SurfaceTexture(producer)
                    texture.refresh()
                    val id = producer.id()
                    surfaceTextures[id] = texture
                    producer.setCallback(
                        object : TextureRegistry.SurfaceProducer.Callback {
                            override fun onSurfaceAvailable() {
                                // Flutter recreated the Surface, for example after
                                // the app returned from the background.
                                val old = texture.refresh() ?: return
                                mainHandler.post {
                                    channel.invokeMethod(
                                        "surfaceChanged",
                                        mapOf("textureId" to id, "surface" to texture.vkSurface, "oldSurface" to old),
                                    )
                                }
                            }

                            override fun onSurfaceCleanup() {
                                // The Surface becomes invalid, so the map stops
                                // demanding frames until onSurfaceAvailable.
                                mainHandler.post {
                                    channel.invokeMethod("surfaceCleanup", mapOf("textureId" to id))
                                }
                            }
                        },
                    )
                    result.success(mapOf("textureId" to id, "surface" to texture.vkSurface))
                }

                "resizeSurfaceTexture" -> {
                    val texture = surfaceTextures[call.argument<Number>("textureId")!!.toLong()]!!
                    texture.producer.setSize(call.argument<Int>("width")!!, call.argument<Int>("height")!!)
                    val old = texture.refresh()
                    result.success(mapOf("surface" to texture.vkSurface, "oldSurface" to old))
                }

                "releaseSurface" -> {
                    NativeBridge.nativeDestroySurface(call.argument<Number>("surface")!!.toLong())
                    result.success(null)
                }

                "disposeTexture" -> {
                    val texture = surfaceTextures.remove(call.argument<Number>("textureId")!!.toLong())
                    if (texture != null) {
                        // A quarantined swapchain outlives the session, and
                        // its VkSurfaceKHR has to as well.
                        if (call.argument<Boolean>("keepSurface") != true) {
                            NativeBridge.nativeDestroySurface(texture.vkSurface)
                        }
                        texture.producer.release()
                    }
                    result.success(null)
                }

                else -> result.notImplemented()
            }
        } catch (error: Exception) {
            result.error("maplibre_native", error.message, null)
        }
    }
}
