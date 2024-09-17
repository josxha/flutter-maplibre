package com.github.josxha.maplibre

import LngLat
import LngLatBounds
import MapCamera
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
import org.maplibre.android.style.layers.BackgroundLayer
import org.maplibre.android.style.layers.CircleLayer
import org.maplibre.android.style.layers.FillExtrusionLayer
import org.maplibre.android.style.layers.FillLayer
import org.maplibre.android.style.layers.HeatmapLayer
import org.maplibre.android.style.layers.HillshadeLayer
import org.maplibre.android.style.layers.LineLayer
import org.maplibre.android.style.layers.PropertyValue
import org.maplibre.android.style.sources.GeoJsonSource
import kotlin.coroutines.cancellation.CancellationException

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

    override fun getView(): View = mapViewContainer

    override fun onMapReady(mapLibreMap: MapLibreMap) {
        this.mapLibreMap = mapLibreMap
        if (initialOptions.listensOnClick) {
            this.mapLibreMap.addOnMapClickListener(this)
        }
        if (initialOptions.listensOnLongClick) {
            this.mapLibreMap.addOnMapLongClickListener(this)
        }
        val style = Style.Builder().fromUri(initialOptions.style)
        mapLibreMap.setStyle(style) { loadedStyle ->
            this.style = loadedStyle
            flutterApi.onStyleLoaded { }
        }
    }

    override fun dispose() {
        // free any resources
    }

    override fun jumpTo(
        center: LngLat?,
        zoom: Double?,
        bearing: Double?,
        pitch: Double?,
        callback: (Result<Unit>) -> Unit
    ) {
        val camera = CameraPosition.Builder()
        if (center != null) camera.target(LatLng(center.lat, center.lng))
        if (zoom != null) camera.zoom(zoom)
        if (pitch != null) camera.tilt(pitch)
        if (bearing != null) camera.bearing(bearing)
        val cameraUpdate = CameraUpdateFactory.newCameraPosition(camera.build())
        mapLibreMap.moveCamera(cameraUpdate)
        callback(Result.success(Unit));
    }

    override fun flyTo(
        center: LngLat?,
        zoom: Double?,
        bearing: Double?,
        pitch: Double?,
        durationMs: Long,
        callback: (Result<Unit>) -> Unit
    ) {
        val camera = CameraPosition.Builder()
        if (center != null) camera.target(LatLng(center.lat, center.lng))
        if (zoom != null) camera.zoom(zoom)
        if (pitch != null) camera.tilt(pitch)
        if (bearing != null) camera.bearing(bearing)
        val cameraUpdate = CameraUpdateFactory.newCameraPosition(camera.build())
        mapLibreMap.animateCamera(
            cameraUpdate,
            durationMs.toInt(),
            object : MapLibreMap.CancelableCallback {
                override fun onCancel() =
                    callback(Result.failure(CancellationException("Animation cancelled.")))

                override fun onFinish() = callback(Result.success(Unit))
            })
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

    override fun addFillLayer(
        id: String,
        sourceId: String,
        layout: Map<String, Any>,
        paint: Map<String, Any>,
        belowLayerId: String?,
        callback: (Result<Unit>) -> Unit
    ) {
        val layer = FillLayer(id, sourceId)
        var properties = paint.map { entry -> PropertyValue(entry.key, entry.value) }
        layer.setProperties(*properties.toTypedArray())
        properties = layout.map { entry -> PropertyValue(entry.key, entry.value) }
        layer.setProperties(*properties.toTypedArray())
        if (belowLayerId == null) {
            mapLibreMap.style?.addLayer(layer)
        } else {
            mapLibreMap.style?.addLayerBelow(layer, belowLayerId)
        }
        callback(Result.success(Unit))
    }

    override fun addCircleLayer(
        id: String,
        sourceId: String,
        layout: Map<String, Any>,
        paint: Map<String, Any>,
        belowLayerId: String?,
        callback: (Result<Unit>) -> Unit
    ) {
        val layer = CircleLayer(id, sourceId)
        var properties = paint.map { entry -> PropertyValue(entry.key, entry.value) }
        layer.setProperties(*properties.toTypedArray())
        properties = layout.map { entry -> PropertyValue(entry.key, entry.value) }
        layer.setProperties(*properties.toTypedArray())
        if (belowLayerId == null) {
            mapLibreMap.style?.addLayer(layer)
        } else {
            mapLibreMap.style?.addLayerBelow(layer, belowLayerId)
        }
        callback(Result.success(Unit))
    }

    override fun addBackgroundLayer(
        id: String,
        layout: Map<String, Any>,
        paint: Map<String, Any>,
        belowLayerId: String?,
        callback: (Result<Unit>) -> Unit
    ) {
        val layer = BackgroundLayer(id)
        var properties = paint.map { entry -> PropertyValue(entry.key, entry.value) }
        layer.setProperties(*properties.toTypedArray())
        properties = layout.map { entry -> PropertyValue(entry.key, entry.value) }
        layer.setProperties(*properties.toTypedArray())
        if (belowLayerId == null) {
            mapLibreMap.style?.addLayer(layer)
        } else {
            mapLibreMap.style?.addLayerBelow(layer, belowLayerId)
        }
        callback(Result.success(Unit))
    }

    override fun addFillExtrusionLayer(
        id: String,
        sourceId: String,
        layout: Map<String, Any>,
        paint: Map<String, Any>,
        belowLayerId: String?,
        callback: (Result<Unit>) -> Unit
    ) {
        val layer = FillExtrusionLayer(id, sourceId)
        var properties = paint.map { entry -> PropertyValue(entry.key, entry.value) }
        layer.setProperties(*properties.toTypedArray())
        properties = layout.map { entry -> PropertyValue(entry.key, entry.value) }
        layer.setProperties(*properties.toTypedArray())
        if (belowLayerId == null) {
            mapLibreMap.style?.addLayer(layer)
        } else {
            mapLibreMap.style?.addLayerBelow(layer, belowLayerId)
        }
        callback(Result.success(Unit))
    }

    override fun addHeatmapLayer(
        id: String,
        sourceId: String,
        layout: Map<String, Any>,
        paint: Map<String, Any>,
        belowLayerId: String?,
        callback: (Result<Unit>) -> Unit
    ) {
        val layer = HeatmapLayer(id, sourceId)
        var properties = paint.map { entry -> PropertyValue(entry.key, entry.value) }
        layer.setProperties(*properties.toTypedArray())
        properties = layout.map { entry -> PropertyValue(entry.key, entry.value) }
        layer.setProperties(*properties.toTypedArray())
        if (belowLayerId == null) {
            mapLibreMap.style?.addLayer(layer)
        } else {
            mapLibreMap.style?.addLayerBelow(layer, belowLayerId)
        }
        callback(Result.success(Unit))
    }

    override fun addHillshadeLayer(
        id: String,
        sourceId: String,
        layout: Map<String, Any>,
        paint: Map<String, Any>,
        belowLayerId: String?,
        callback: (Result<Unit>) -> Unit
    ) {
        val layer = HillshadeLayer(id, sourceId)
        var properties = paint.map { entry -> PropertyValue(entry.key, entry.value) }
        layer.setProperties(*properties.toTypedArray())
        properties = layout.map { entry -> PropertyValue(entry.key, entry.value) }
        layer.setProperties(*properties.toTypedArray())
        if (belowLayerId == null) {
            mapLibreMap.style?.addLayer(layer)
        } else {
            mapLibreMap.style?.addLayerBelow(layer, belowLayerId)
        }
        callback(Result.success(Unit))
    }

    override fun addLineLayer(
        id: String,
        sourceId: String,
        layout: Map<String, Any>,
        paint: Map<String, Any>,
        belowLayerId: String?,
        callback: (Result<Unit>) -> Unit
    ) {
        val layer = LineLayer(id, sourceId)
        var properties = paint.map { entry -> PropertyValue(entry.key, entry.value) }
        layer.setProperties(*properties.toTypedArray())
        properties = layout.map { entry -> PropertyValue(entry.key, entry.value) }
        layer.setProperties(*properties.toTypedArray())
        if (belowLayerId == null) {
            mapLibreMap.style?.addLayer(layer)
        } else {
            mapLibreMap.style?.addLayerBelow(layer, belowLayerId)
        }
        callback(Result.success(Unit))
    }

    override fun addRasterLayer(
        id: String,
        sourceId: String,
        layout: Map<String, Any>,
        paint: Map<String, Any>,
        belowLayerId: String?,
        callback: (Result<Unit>) -> Unit
    ) {
        TODO("Not yet implemented")
    }

    override fun addSymbolLayer(
        id: String,
        sourceId: String,
        layout: Map<String, Any>,
        paint: Map<String, Any>,
        belowLayerId: String?,
        callback: (Result<Unit>) -> Unit
    ) {
        TODO("Not yet implemented")
    }

    override fun getCamera(callback: (Result<MapCamera>) -> Unit) {
        val position = mapLibreMap.cameraPosition
        val target = mapLibreMap.cameraPosition.target!!
        val center = LngLat(target.longitude, target.latitude)
        val camera = MapCamera(center, position.zoom, position.tilt, position.bearing)
        callback(Result.success(camera))
    }

    override fun getVisibleRegion(callback: (Result<LngLatBounds>) -> Unit) {
        val bounds = mapLibreMap.projection.visibleRegion.latLngBounds
        val lngLatBounds = LngLatBounds(
            bounds.longitudeWest,
            bounds.longitudeEast,
            bounds.latitudeSouth,
            bounds.latitudeNorth
        )
        callback(Result.success(lngLatBounds))
    }

    override fun addGeoJsonSource(
        id: String,
        data: String,
        callback: (Result<Unit>) -> Unit
    ) {
        mapLibreMap.style?.addSource(GeoJsonSource(id, data))
        callback(Result.success(Unit))
    }

    override fun getMetersPerPixelAtLatitude(latitude: Double): Double =
        mapLibreMap.projection.getMetersPerPixelAtLatitude(latitude)

    override fun onMapClick(point: LatLng): Boolean {
        flutterApi.onClick(LngLat(point.longitude, point.latitude)) { }
        return true
    }

    override fun onMapLongClick(point: LatLng): Boolean {
        flutterApi.onLongClick(LngLat(point.longitude, point.latitude)) { }
        return true
    }
}