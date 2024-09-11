package com.github.josxha.maplibre

import LngLat
import MapLibreFlutterApi
import MapLibreHostApi
import MapOptions
import ScreenLocation
import android.content.Context
import android.graphics.PointF
import android.view.View
import android.widget.FrameLayout
import androidx.lifecycle.DefaultLifecycleObserver
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView
import org.maplibre.android.MapLibre
import org.maplibre.android.camera.CameraPosition
import org.maplibre.android.camera.CameraUpdateFactory
import org.maplibre.android.geometry.LatLng
import org.maplibre.android.maps.MapLibreMap
import org.maplibre.android.maps.MapLibreMapOptions
import org.maplibre.android.maps.MapView
import org.maplibre.android.maps.OnMapReadyCallback
import org.maplibre.android.maps.Style
import org.maplibre.android.style.layers.CircleLayer
import org.maplibre.android.style.layers.FillLayer
import org.maplibre.android.style.sources.GeoJsonSource

class MapLibreMapController(
    viewId: Int,
    private val context: Context,
    private val lifecycleProvider: LifecycleProvider,
    binaryMessenger: BinaryMessenger
) : PlatformView, DefaultLifecycleObserver, OnMapReadyCallback, MapLibreHostApi,
    MapLibreMap.OnMapClickListener, MapLibreMap.OnMapLongClickListener {
    private val mapViewContainer = FrameLayout(context)
    private lateinit var mapLibreMap: MapLibreMap
    private lateinit var mapView: MapView
    private val flutterApi: MapLibreFlutterApi
    private lateinit var initialOptions: MapOptions
    private var style: Style? = null

    init {
        val channelSuffix = viewId.toString();
        MapLibreHostApi.setUp(binaryMessenger, this, channelSuffix)
        flutterApi = MapLibreFlutterApi(binaryMessenger, channelSuffix)
        flutterApi.getOptions { result: Result<MapOptions> ->
            initialOptions = result.getOrThrow()
            val cameraBuilder = CameraPosition.Builder()
                .zoom(initialOptions.zoom)
                .bearing(initialOptions.bearing)
                .tilt(initialOptions.tilt)
            if (initialOptions.center != null)
                cameraBuilder.target(
                    LatLng(
                        initialOptions.center!!.lat,
                        initialOptions.center!!.lng
                    )
                )

            val options = MapLibreMapOptions.createFromAttributes(context)
                .attributionEnabled(true)
                .logoEnabled(true)
                .textureMode(true)
                .compassEnabled(true)
                .camera(cameraBuilder.build())

            MapLibre.getInstance(context) // needs to be called before MapView gets created
            mapView = MapView(context, options)
            lifecycleProvider.getLifecycle()?.addObserver(this)
            mapView.getMapAsync(this)
            mapViewContainer.addView(mapView)
        }
    }

    override fun getView(): View {
        return mapViewContainer;
    }

    override fun onMapReady(mapLibreMap: MapLibreMap) {
        this.mapLibreMap = mapLibreMap
        this.mapLibreMap.addOnMapClickListener(this)
        this.mapLibreMap.addOnMapLongClickListener(this)
        val style = Style.Builder().fromUri(initialOptions.style)
        mapLibreMap.setStyle(style) { loadedStyle ->
            this.style = loadedStyle
            flutterApi.onStyleLoaded { }
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
        callback(Result.success(Unit));
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
        val latLng = mapLibreMap.projection.fromScreenLocation(PointF(x.toFloat(), y.toFloat()))
        callback(Result.success(LngLat(latLng.longitude, latLng.latitude)))
    }

    override fun addFillLayer(id: String, sourceId: String, callback: (Result<Unit>) -> Unit) {
        mapLibreMap.style?.addLayer(FillLayer(id, sourceId))
        callback(Result.success(Unit))
    }

    override fun addCircleLayer(
        id: String,
        sourceId: String,
        callback: (Result<Unit>) -> Unit
    ) {
        mapLibreMap.style?.addLayer(CircleLayer(id, sourceId))
        callback(Result.success(Unit))
    }

    override fun addGeoJsonSource(
        id: String,
        data: String,
        callback: (Result<Unit>) -> Unit
    ) {
        mapLibreMap.style?.addSource(GeoJsonSource(id, data))
        callback(Result.success(Unit))
    }

    override fun onMapClick(point: LatLng): Boolean {
        flutterApi.onClick(LngLat(point.longitude, point.latitude)) { }
        return true
    }

    override fun onMapLongClick(point: LatLng): Boolean {
        flutterApi.onLongClick(LngLat(point.longitude, point.latitude)) { }
        return true
    }
}