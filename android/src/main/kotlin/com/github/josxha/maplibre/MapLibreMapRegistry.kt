package com.github.josxha.maplibre

import android.app.Activity
import org.maplibre.android.maps.MapLibreMap

class MapLibreMapRegistry {
    companion object {
        public var activity: Activity? = null

        public val registry = HashMap<Int, MapLibreMap>()

        public fun get(viewId: Int): MapLibreMap? = registry[viewId]

        public fun add(viewId: Int, map: MapLibreMap) {
            registry[viewId] = map
        }

        public fun getActivity(): Activity? = activity
    }
}