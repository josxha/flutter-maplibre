package com.github.josxha.maplibre

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import androidx.annotation.Keep
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import org.maplibre.android.maps.MapLibreMap

@Keep
@SuppressLint("StaticFieldLeak")
object MapLibreRegistry {
    private val mapRegistry = HashMap<Int, MapLibreMap>()

    @Suppress("RedundantVisibilityModifier")
    @Keep
    public fun getMap(viewId: Int): MapLibreMap? = mapRegistry[viewId]

    fun addMap(
        viewId: Int,
        map: MapLibreMap,
    ) {
        mapRegistry[viewId] = map
    }

    // TODO: Storing the ActivityPluginBinding in a static field is a potential memory leak.
    public var activityPluginBinding: ActivityPluginBinding? = null

    // TODO: Storing the Activity in a static field is a potential memory leak.
    public var activity: Activity? = null

    // TODO: Storing the Context in a static field is a potential memory leak.
    public var context: Context? = null
}
