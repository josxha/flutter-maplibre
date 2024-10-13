package com.github.josxha.maplibre

import CameraChangeReason
import LngLat
import MapCamera
import MapLibreFlutterApi
import MapLibreHostApi
import MapOptions
import android.content.Context
import android.graphics.BitmapFactory
import android.view.View
import android.widget.FrameLayout
import androidx.lifecycle.DefaultLifecycleObserver
import com.google.gson.Gson
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView
import org.maplibre.android.MapLibre
import org.maplibre.android.camera.CameraPosition
import org.maplibre.android.geometry.LatLng
import org.maplibre.android.maps.MapLibreMap
import org.maplibre.android.maps.MapLibreMap.OnCameraMoveStartedListener.REASON_API_ANIMATION
import org.maplibre.android.maps.MapLibreMap.OnCameraMoveStartedListener.REASON_API_GESTURE
import org.maplibre.android.maps.MapLibreMap.OnCameraMoveStartedListener.REASON_DEVELOPER_ANIMATION
import org.maplibre.android.maps.MapLibreMapOptions
import org.maplibre.android.maps.MapView
import org.maplibre.android.maps.OnMapReadyCallback
import org.maplibre.android.maps.Style
import org.maplibre.android.style.expressions.Expression
import org.maplibre.android.style.layers.BackgroundLayer
import org.maplibre.android.style.layers.CircleLayer
import org.maplibre.android.style.layers.FillExtrusionLayer
import org.maplibre.android.style.layers.FillLayer
import org.maplibre.android.style.layers.HeatmapLayer
import org.maplibre.android.style.layers.HillshadeLayer
import org.maplibre.android.style.layers.LayoutPropertyValue
import org.maplibre.android.style.layers.LineLayer
import org.maplibre.android.style.layers.PaintPropertyValue
import org.maplibre.android.style.layers.PropertyValue
import org.maplibre.android.style.layers.RasterLayer
import org.maplibre.android.style.layers.SymbolLayer
import java.io.IOException
import java.net.URL

class MapLibreMapController(
    private val viewId: Int,
    private val context: Context,
    private val lifecycleProvider: LifecycleProvider,
    binaryMessenger: BinaryMessenger,
) : PlatformView,
    DefaultLifecycleObserver,
    OnMapReadyCallback,
    MapLibreHostApi {
    private val mapViewContainer = FrameLayout(context)
    private lateinit var mapLibreMap: MapLibreMap
    private lateinit var mapView: MapView
    private val flutterApi: MapLibreFlutterApi
    private lateinit var mapOptions: MapOptions
    private var style: Style? = null

    init {
        val channelSuffix = viewId.toString()
        MapLibreHostApi.setUp(binaryMessenger, this, channelSuffix)
        flutterApi = MapLibreFlutterApi(binaryMessenger, channelSuffix)
        flutterApi.getOptions { result: Result<MapOptions> ->
            mapOptions = result.getOrThrow()
            val cameraBuilder =
                CameraPosition
                    .Builder()
                    .zoom(mapOptions.zoom)
                    .bearing(mapOptions.bearing)
                    .tilt(mapOptions.pitch)
            if (mapOptions.center != null) {
                cameraBuilder.target(
                    LatLng(
                        mapOptions.center!!.lat,
                        mapOptions.center!!.lng,
                    ),
                )
            }
            val options =
                MapLibreMapOptions
                    .createFromAttributes(context)
                    .attributionEnabled(true)
                    .logoEnabled(true)
                    .textureMode(true)
                    .compassEnabled(true)
                    .minZoomPreference(mapOptions.minZoom)
                    .maxZoomPreference(mapOptions.maxZoom)
                    .minPitchPreference(mapOptions.minPitch)
                    .maxPitchPreference(mapOptions.maxPitch)
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
        MapLibreRegistry.addMap(viewId, mapLibreMap)
        this.mapLibreMap.addOnMapClickListener { latLng ->
            flutterApi.onClick(LngLat(latLng.longitude, latLng.latitude)) { }
            true
        }
        this.mapLibreMap.addOnMapLongClickListener { latLng ->
            flutterApi.onLongClick(LngLat(latLng.longitude, latLng.latitude)) { }
            true
        }
        this.mapLibreMap.addOnCameraMoveListener {
            val position = mapLibreMap.cameraPosition
            val target = mapLibreMap.cameraPosition.target!!
            val center = LngLat(target.longitude, target.latitude)
            val camera = MapCamera(center, position.zoom, position.tilt, position.bearing)
            flutterApi.onMoveCamera(camera) {}
        }
        this.mapLibreMap.addOnCameraIdleListener { flutterApi.onCameraIdle { } }
        this.mapView.addOnDidBecomeIdleListener { flutterApi.onIdle { } }
        this.mapLibreMap.addOnCameraMoveStartedListener { reason ->
            val changeReason =
                when (reason) {
                    REASON_API_ANIMATION -> CameraChangeReason.API_ANIMATION
                    REASON_API_GESTURE -> CameraChangeReason.API_GESTURE
                    REASON_DEVELOPER_ANIMATION -> CameraChangeReason.DEVELOPER_ANIMATION
                    else -> null
                }
            if (changeReason != null) flutterApi.onStartMoveCamera(changeReason) { }
        }
        val style = Style.Builder().fromUri(mapOptions.style)
        mapLibreMap.setStyle(style) { loadedStyle ->
            this.style = loadedStyle
            flutterApi.onStyleLoaded { }
        }
    }

    override fun dispose() {
        // free any resources
    }

    private val gson = Gson()

    private fun parsePaintProperties(entries: Map<String, Any>): Array<PropertyValue<*>> =
        entries
            .map { entry ->
//                println("${entry.key}; ${entry.value::class.java.typeName}; ${entry.value}")
                when (entry.value) {
                    is ArrayList<*> -> {
                        val value = entry.value as ArrayList<*>
                        if (value.isEmpty()) {
                            PaintPropertyValue(entry.key, value)
                        }
                        when (value.first()) {
                            is String -> {
                                val json = gson.toJsonTree(value)
                                val expression = Expression.Converter.convert(json)
                                PaintPropertyValue(entry.key, expression)
                            }
                            else -> {
                                PaintPropertyValue(entry.key, value.toArray())
                            }
                        }
                    }

                    else -> PaintPropertyValue(entry.key, entry.value)
                }
            }.toTypedArray()

    private fun parseLayoutProperties(entries: Map<String, Any>): Array<PropertyValue<*>> =
        entries
            .map { entry ->
//                println("${entry.key}; ${entry.value::class.java.typeName}; ${entry.value}")
                when (entry.value) {
                    is ArrayList<*> -> {
                        val value = entry.value as ArrayList<*>
                        if (value.isEmpty()) {
                            LayoutPropertyValue(entry.key, value)
                        }
                        when (value.first()) {
                            is String -> {
                                val json = gson.toJsonTree(value)
                                val expression = Expression.Converter.convert(json)
                                LayoutPropertyValue(entry.key, expression)
                            }
                            else -> {
                                LayoutPropertyValue(entry.key, value.toArray())
                            }
                        }
                    }

                    else -> LayoutPropertyValue(entry.key, entry.value)
                }
            }.toTypedArray()

    override fun addFillLayer(
        id: String,
        sourceId: String,
        layout: Map<String, Any>,
        paint: Map<String, Any>,
        belowLayerId: String?,
        callback: (Result<Unit>) -> Unit,
    ) {
        val layer = FillLayer(id, sourceId)
        layer.setProperties(*parsePaintProperties(paint), *parseLayoutProperties(layout))
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
        callback: (Result<Unit>) -> Unit,
    ) {
        val layer = CircleLayer(id, sourceId)
        layer.setProperties(*parsePaintProperties(paint), *parseLayoutProperties(layout))
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
        callback: (Result<Unit>) -> Unit,
    ) {
        val layer = BackgroundLayer(id)
        layer.setProperties(*parsePaintProperties(paint), *parseLayoutProperties(layout))
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
        callback: (Result<Unit>) -> Unit,
    ) {
        val layer = FillExtrusionLayer(id, sourceId)
        layer.setProperties(*parsePaintProperties(paint), *parseLayoutProperties(layout))
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
        callback: (Result<Unit>) -> Unit,
    ) {
        val layer = HeatmapLayer(id, sourceId)
        layer.setProperties(*parsePaintProperties(paint), *parseLayoutProperties(layout))
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
        callback: (Result<Unit>) -> Unit,
    ) {
        val layer = HillshadeLayer(id, sourceId)
        layer.setProperties(*parsePaintProperties(paint), *parseLayoutProperties(layout))
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
        callback: (Result<Unit>) -> Unit,
    ) {
        val layer = LineLayer(id, sourceId)
        layer.setProperties(*parsePaintProperties(paint), *parseLayoutProperties(layout))
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
        callback: (Result<Unit>) -> Unit,
    ) {
        val layer = RasterLayer(id, sourceId)
//        layer.setProperties(*parseProperties(paint), *parseProperties(layout))
        if (belowLayerId == null) {
            mapLibreMap.style?.addLayer(layer)
        } else {
            mapLibreMap.style?.addLayerBelow(layer, belowLayerId)
        }
        callback(Result.success(Unit))
    }

    override fun addSymbolLayer(
        id: String,
        sourceId: String,
        layout: Map<String, Any>,
        paint: Map<String, Any>,
        belowLayerId: String?,
        callback: (Result<Unit>) -> Unit,
    ) {
        val layer = SymbolLayer(id, sourceId)
        layer.setProperties(*parsePaintProperties(paint), *parseLayoutProperties(layout))
        if (belowLayerId == null) {
            mapLibreMap.style?.addLayer(layer)
        } else {
            mapLibreMap.style?.addLayerBelow(layer, belowLayerId)
        }
        callback(Result.success(Unit))
    }

    override fun loadImage(
        url: String,
        callback: (Result<ByteArray>) -> Unit,
    ) {
        try {
            val bytes = URL(url).openConnection().getInputStream().readBytes()
            callback(Result.success(bytes))
        } catch (e: IOException) {
            println(e)
            callback(Result.failure(e))
        }
    }

    override fun addImage(
        id: String,
        bytes: ByteArray,
        callback: (Result<Unit>) -> Unit,
    ) {
        val bitmap = BitmapFactory.decodeStream(bytes.inputStream())
        mapLibreMap.style?.addImage(id, bitmap)
        callback(Result.success(Unit))
    }
}
