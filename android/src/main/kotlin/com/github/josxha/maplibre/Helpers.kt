package com.github.josxha.maplibre

import androidx.annotation.Keep
import org.maplibre.android.geometry.LatLngBounds
import org.maplibre.android.offline.OfflineTilePyramidRegionDefinition

@Keep
object Helpers {
    /**
     * The genreation of OfflineTilePyramidRegionDefinition fails in
     * version 0.13.0 of jnigen. That's why this helper function gets used.
     */
    fun createOfflineTilePyramidRegionDefinition(
        styleURL: String?,
        bounds: LatLngBounds,
        minZoom: Double,
        maxZoom: Double,
        pixelRatio: Float,
    ): OfflineTilePyramidRegionDefinition =
        OfflineTilePyramidRegionDefinition(
            styleURL,
            bounds,
            minZoom,
            maxZoom,
            pixelRatio,
        )
}
