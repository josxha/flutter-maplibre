package com.github.josxha.maplibre

import org.maplibre.android.maps.MapLibreMap

class MapLibreMapRegistry {
    companion object {
        private val registry = HashMap<Int, MapLibreMap>()

        fun get(viewId: Int): MapLibreMap? = registry[viewId]

        fun add(viewId: Int, map: MapLibreMap) {
            registry[viewId] = map
        }
    }
}