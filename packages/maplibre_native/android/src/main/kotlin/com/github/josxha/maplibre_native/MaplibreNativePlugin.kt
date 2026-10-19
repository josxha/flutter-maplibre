package com.github.josxha.maplibre_native

import io.flutter.embedding.engine.plugins.FlutterPlugin

/**
 * Android side of maplibre_native.
 *
 * Dart calls [MaplibreNativeApi] through jnigen bindings. The plugin only
 * hands it the engine's context and texture registry.
 */
class MaplibreNativePlugin : FlutterPlugin {
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        MaplibreNativeApi.attach(binding.applicationContext, binding.textureRegistry)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        MaplibreNativeApi.detach(binding.textureRegistry)
    }
}
