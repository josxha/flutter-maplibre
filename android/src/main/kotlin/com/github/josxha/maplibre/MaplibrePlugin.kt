package com.github.josxha.maplibre

import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleOwner
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.github.josxha.maplibre.MapLibreMapFactory
import com.github.josxha.maplibre.LifecycleProvider

/** MaplibrePlugin */
class MaplibrePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    /// The MethodChannel that will handle the communication between Flutter and native Android
    private lateinit var channel: MethodChannel

    private var lifecycle: Lifecycle? = null

    private lateinit var flutterAssets: FlutterPlugin.FlutterAssets

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "maplibre")
        channel.setMethodCallHandler(this)
        flutterAssets = binding.flutterAssets
        binding
            .platformViewRegistry
            .registerViewFactory(
                "maplibre",
                MapLibreMapFactory(
                    binding.binaryMessenger,
                    object : LifecycleProvider {
                        override fun getLifecycle(): Lifecycle? = lifecycle
                    }
                )
            )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        lifecycle = FlutterLifecycleAdapter.getActivityLifecycle(binding)
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

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else {
            result.notImplemented()
        }
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
