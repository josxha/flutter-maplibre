package org.maplibre.maplibre_native

import io.flutter.embedding.engine.plugins.FlutterPlugin

/**
 * Android side of maplibre_native.
 *
 * Dart calls [MaplibreNativeApi] through jnigen bindings. Each engine's
 * plugin only hands it the engine's id, context and texture registry.
 */
class MaplibreNativePlugin : FlutterPlugin {
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        MaplibreNativeApi.attach(binding.engineId, binding.applicationContext, binding.textureRegistry)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        MaplibreNativeApi.detach(binding.engineId)
    }
}

/**
 * The id that Dart reads as `PlatformDispatcher.instance.engineId`. The
 * binding has no other accessor for it than the deprecated engine.
 */
@Suppress("DEPRECATION")
private val FlutterPlugin.FlutterPluginBinding.engineId: Long
    get() = flutterEngine.engineId
