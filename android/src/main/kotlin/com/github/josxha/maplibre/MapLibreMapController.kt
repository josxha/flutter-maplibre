package com.github.josxha.maplibre

import LngLat
import MapLibrePigeon
import ScreenLocation
import android.content.Context
import android.graphics.PointF
import android.view.View
import android.widget.FrameLayout
import androidx.lifecycle.DefaultLifecycleObserver
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView
import org.maplibre.android.MapLibre
import org.maplibre.android.camera.CameraUpdateFactory
import org.maplibre.android.geometry.LatLng
import org.maplibre.android.maps.MapLibreMap
import org.maplibre.android.maps.MapLibreMapOptions
import org.maplibre.android.maps.MapView
import org.maplibre.android.maps.OnMapReadyCallback
import org.maplibre.android.maps.Style


class MapLibreMapController(
    private val viewId: Int,
    private val context: Context,
    private val options: MapLibreMapOptions,
    private val styleStringInitial: String,
    private val lifecycleProvider: LifecycleProvider,
    private val binaryMessenger: BinaryMessenger
) : PlatformView, DefaultLifecycleObserver, OnMapReadyCallback, MapLibrePigeon {
    private val mapViewContainer = FrameLayout(context)
    private lateinit var mapLibreMap: MapLibreMap
    private var mapView: MapView
    private var style: Style? = null

    init {
        MapLibre.getInstance(context) // needs to be called before MapView gets created
        mapView = MapView(context, options)
        lifecycleProvider.getLifecycle()?.addObserver(this)
        mapView.getMapAsync(this)
        mapViewContainer.addView(mapView)
    }

    override fun getView(): View {
        return mapViewContainer;
    }

    override fun onMapReady(mapLibreMap: MapLibreMap) {
        this.mapLibreMap = mapLibreMap
        MapLibrePigeon.setUp(binaryMessenger, this, viewId.toString())

        val style = Style.Builder().fromUri(styleStringInitial)
        mapLibreMap.setStyle(style) { loadedStyle ->
            this.style = loadedStyle
        }
    }

    override fun dispose() {
    }

    override fun jumpTo(
        center: LngLat,
        zoom: Double?,
        bearing: Double?,
        pitch: Double?,
        callback: (Result<Unit>) -> Unit
    ) {
        val latLng = LatLng(center.lat, center.lng);
        val cameraUpdate = CameraUpdateFactory.newLatLngZoom(latLng, zoom ?: 0.0)
        mapLibreMap.moveCamera(cameraUpdate)
    }

    override fun flyTo(
        center: LngLat,
        zoom: Double?,
        bearing: Double?,
        pitch: Double?,
        callback: (Result<Unit>) -> Unit
    ) {
        val latLng = LatLng(center.lat, center.lng);
        val cameraUpdate = CameraUpdateFactory.newLatLngZoom(latLng, zoom ?: 0.0)
        mapLibreMap.animateCamera(cameraUpdate)
    }

    override fun toScreenLocation(
        lng: Double,
        lat: Double,
        callback: (Result<ScreenLocation>) -> Unit
    ) {
        val location = mapLibreMap.projection.toScreenLocation(LatLng(lat, lng));
        callback(Result.success(ScreenLocation(location.x.toDouble(), location.y.toDouble())))
    }

    override fun toLngLat(x: Double, y: Double, callback: (Result<LngLat>) -> Unit) {
        val latLng = mapLibreMap.projection.fromScreenLocation(PointF(x.toFloat(), y.toFloat()));
        callback(Result.success(LngLat(latLng.longitude, latLng.latitude)))
    }
}