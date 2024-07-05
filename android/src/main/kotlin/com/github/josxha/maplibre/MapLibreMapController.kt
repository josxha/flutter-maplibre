package com.github.josxha.maplibre

import android.content.Context
import android.view.View
import android.widget.FrameLayout
import androidx.lifecycle.DefaultLifecycleObserver
import io.flutter.plugin.platform.PlatformView
import org.maplibre.android.maps.MapLibreMap
import org.maplibre.android.maps.MapLibreMapOptions
import org.maplibre.android.maps.MapView
import org.maplibre.android.maps.OnMapReadyCallback
import org.maplibre.android.maps.Style
import org.maplibre.android.maps.Style.OnStyleLoaded


class MapLibreMapController(
    context: Context,
    options: MapLibreMapOptions,
    private val styleStringInitial: String,
) : PlatformView, DefaultLifecycleObserver, OnMapReadyCallback {
    private lateinit var mapLibreMap: MapLibreMap
    private var mapView : MapView? = MapView(context, options)
    private var style: Style? = null
    private val mapViewContainer: FrameLayout? = null

    fun init(lifecycleProvider: LifecycleProvider) {
        lifecycleProvider.getLifecycle()?.addObserver(this)
        mapView?.getMapAsync(this)
    }

    override fun getView(): View? {
        return mapViewContainer;
    }

    override fun onMapReady(mapLibreMap: MapLibreMap) {
        this.mapLibreMap = mapLibreMap

        mapLibreMap.setStyle(Style.Builder().fromUri(styleStringInitial), onStyleLoadedCallback)
    }

    private var onStyleLoadedCallback: OnStyleLoaded = OnStyleLoaded { style ->
        this.style = style
    }

    override fun dispose() {
    }
}