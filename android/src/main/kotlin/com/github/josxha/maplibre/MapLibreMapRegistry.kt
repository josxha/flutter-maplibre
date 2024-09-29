package com.github.josxha.maplibre

import org.maplibre.android.maps.MapLibreMap

class MapLibreMapRegistry {
    companion object {
        public val registry = HashMap<Int, MapLibreMap>()

        public fun get(viewId: Int): MapLibreMap? = registry[viewId]

        public fun add(viewId: Int, map: MapLibreMap) {
            println("$viewId $map")
            registry[viewId] = map
        }
    }
}