package com.github.josxha.maplibre

import androidx.annotation.Keep
import org.maplibre.android.maps.MapLibreMap

object MapLibreMapRegistry {
    private val registry = HashMap<Int, MapLibreMap>()

    @Suppress("RedundantVisibilityModifier")
    @Keep
    public fun get(viewId: Int): MapLibreMap? = registry[viewId]

    fun add(viewId: Int, map: MapLibreMap) {
        registry[viewId] = map
    }
}