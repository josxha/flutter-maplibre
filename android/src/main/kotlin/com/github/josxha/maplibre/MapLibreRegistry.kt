package com.github.josxha.maplibre

import android.annotation.SuppressLint
import androidx.annotation.Keep
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
}
