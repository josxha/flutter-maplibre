package com.github.josxha.maplibre

import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleOwner
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** MaplibrePlugin */
class MapLibrePlugin : FlutterPlugin, ActivityAware {

    private var lifecycle: Lifecycle? = null

    private lateinit var flutterAssets: FlutterPlugin.FlutterAssets

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        flutterAssets = binding.flutterAssets
        binding
            .platformViewRegistry
            .registerViewFactory(
                "maplibre",
                MapLibreMapFactory(
                    object : LifecycleProvider {
                        override fun getLifecycle(): Lifecycle? = lifecycle
                    }
                )
            )
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        lifecycle = FlutterLifecycleAdapter.getActivityLifecycle(binding)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {

    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        lifecycle = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }
}

/**
 * Provides a static method for extracting lifecycle objects from Flutter plugin bindings.
 */
object FlutterLifecycleAdapter {
    /**
     * Returns the lifecycle object for the activity a plugin is bound to.
     *
     * Returns null if the Flutter engine version does not include the lifecycle extraction code.
     * (this probably means the Flutter engine version is too old).
     */
    fun getActivityLifecycle(activityPluginBinding: ActivityPluginBinding): Lifecycle? {
        val activity = activityPluginBinding.activity
        return if (activity is LifecycleOwner) {
            activity.lifecycle
        } else {
            null
        }
    }
}
