package com.github.josxha.maplibre

import PermissionManagerHostApi
import android.content.Context
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleOwner
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import org.maplibre.android.location.permissions.PermissionsListener
import org.maplibre.android.location.permissions.PermissionsManager

/** MapLibrePlugin */
class MapLibrePlugin :
    FlutterPlugin,
    ActivityAware,
    PluginRegistry.RequestPermissionsResultListener,
    PermissionManagerHostApi {
    private var lifecycle: Lifecycle? = null
    private lateinit var permissionManagerApi: PermissionManagerHostApi

    private lateinit var flutterAssets: FlutterPlugin.FlutterAssets

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        MapLibreRegistry.context = binding.applicationContext
        PermissionManagerHostApi.setUp(binding.binaryMessenger, this)
        flutterAssets = binding.flutterAssets
        binding
            .platformViewRegistry
            .registerViewFactory(
                "plugins.flutter.io/maplibre",
                MapLibreMapFactory(
                    object : LifecycleProvider {
                        override fun getLifecycle(): Lifecycle? = lifecycle
                    },
                    binaryMessenger = binding.binaryMessenger,
                ),
            )
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        MapLibreRegistry.activity = binding.activity
        binding.addRequestPermissionsResultListener(this)
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

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ): Boolean {
        permissionsManager?.onRequestPermissionsResult(requestCode, permissions, grantResults)
        return true
    }

    private var permissionsManager: PermissionsManager? = null

    override fun requestLocationPermissions(
        explanation: String,
        callback: (Result<Boolean>) -> Unit,
    ) {
        permissionsManager =
            PermissionsManager(
                object : PermissionsListener {
                    override fun onExplanationNeeded(permissionsToExplain: MutableList<String>?) {
                        // This method fires when the user gets prompted to accept the permissions.
                        // No not handle the return here, onPermissionResult will still be called.
                    }

                    override fun onPermissionResult(granted: Boolean) {
                        callback(Result.success(granted))
                    }
                },
            )
        permissionsManager?.requestLocationPermissions(MapLibreRegistry.activity)
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

class MapLibreMapFactory(
    private val lifecycleProvider: LifecycleProvider,
    private val binaryMessenger: BinaryMessenger,
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(
        context: Context,
        viewId: Int,
        args: Any?,
    ): PlatformView =
        MapLibreMapController(
            viewId,
            context,
            lifecycleProvider,
            binaryMessenger,
        )
}

interface LifecycleProvider {
    fun getLifecycle(): Lifecycle?
}
