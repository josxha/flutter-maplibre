package com.github.josxha.maplibre

// if imports can't resolve:
// - remove all .idea/ folders
// - open example/android/build.gradle.kts as project
// - sync project to download dependencies

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import org.maplibre.android.location.permissions.PermissionsManager

/** MapLibrePlugin */
class MapLibrePlugin :
    FlutterPlugin,
    ActivityAware,
    PluginRegistry.RequestPermissionsResultListener {
    private var permissionsManager: PermissionsManager? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        binding
            .platformViewRegistry
            .registerViewFactory(
                "plugins.flutter.io/maplibre",
                MapLibreMapFactory(),
            )
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        binding.addRequestPermissionsResultListener(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ): Boolean {
        permissionsManager?.onRequestPermissionsResult(
            requestCode,
            permissions,
            grantResults,
        )
        return true
    }
}

internal class MapLibreMapFactory(
    private val createPlatformView: (Int) -> PlatformView = {
        MapLibreRegistry.flutterApi!!.createPlatformView(it)
    },
    private val installRequestHeadersInterceptor: () -> Unit = {
        installHostScopedRequestHeadersInterceptor()
    },
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(
        context: Context,
        viewId: Int,
        args: Any?,
    ): PlatformView {
        // The Flutter callback initializes MapLibre; HttpRequestUtil requires
        // that initialization before accepting a custom OkHttp client.
        val platformView = createPlatformView(viewId)
        installRequestHeadersInterceptor()
        return platformView
    }
}
