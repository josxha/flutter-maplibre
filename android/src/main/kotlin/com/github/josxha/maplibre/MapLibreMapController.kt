package com.github.josxha.maplibre

import android.content.Context
import android.view.View
import android.widget.FrameLayout
import androidx.lifecycle.DefaultLifecycleObserver
import io.flutter.plugin.platform.PlatformView
import org.maplibre.android.MapLibre
import org.maplibre.android.maps.MapLibreMap
import org.maplibre.android.maps.MapLibreMapOptions
import org.maplibre.android.maps.MapView
import org.maplibre.android.maps.OnMapReadyCallback
import org.maplibre.android.maps.Style


class MapLibreMapController(
    private val viewId: Int,
    private val context: Context,
    private val dragEnabled: Boolean,
    private val options: MapLibreMapOptions,
    private val styleStringInitial: String,
    private val lifecycleProvider: LifecycleProvider
) : PlatformView, DefaultLifecycleObserver, OnMapReadyCallback {
    private var mapViewContainer = FrameLayout(context)
    private lateinit var mapLibreMap: MapLibreMap
    private var mapView: MapView
    private var style: Style? = null

    init {
        // MapLibre.getInstance needs to be called before MapView gets created
        MapLibre.getInstance(context)
        mapView = MapView(context, options)
        lifecycleProvider.getLifecycle()?.addObserver(this)
        mapView.getMapAsync(this)
        mapViewContainer.addView(mapView)
    }

    override fun getView(): View? {
        return mapViewContainer;
    }

    override fun onMapReady(mapLibreMap: MapLibreMap) {
        this.mapLibreMap = mapLibreMap

        mapLibreMap.setStyle(Style.Builder().fromUri(styleStringInitial)) { style ->
            this.style = style
        }
    }

    override fun dispose() {
    }
}