package com.github.josxha.maplibre

import android.app.Activity
import org.maplibre.android.maps.MapLibreMap

class MapLibreMapRegistry {
    companion object {
        public val registry = HashMap<Int, MapLibreMap>()

        public fun get(viewId: Int): MapLibreMap? = registry[viewId]

        public fun add(viewId: Int, map: MapLibreMap) {
            registry[viewId] = map
        }
    }
}