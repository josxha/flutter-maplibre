package com.github.josxha.maplibre

import CameraChangeReason
import LngLat
import LngLatBounds
import MapCamera
import MapLibreFlutterApi
import MapLibreHostApi
import MapOptions
import Offset
import Padding
import RasterDemEncoding
import TileScheme
import android.content.Context
import android.graphics.BitmapFactory
import android.graphics.PointF
import android.view.View
import android.widget.FrameLayout
import androidx.lifecycle.DefaultLifecycleObserver
import com.google.gson.Gson
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView
import org.maplibre.android.MapLibre
import org.maplibre.android.camera.CameraPosition
import org.maplibre.android.camera.CameraUpdateFactory
import org.maplibre.android.geometry.LatLng
import org.maplibre.android.geometry.LatLngBounds
import org.maplibre.android.geometry.LatLngQuad
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
import org.maplibre.android.style.layers.LineLayer
import org.maplibre.android.style.layers.PaintPropertyValue
import org.maplibre.android.style.layers.PropertyValue
import org.maplibre.android.style.layers.RasterLayer
import org.maplibre.android.style.layers.SymbolLayer
import org.maplibre.android.style.sources.GeoJsonOptions
import org.maplibre.android.style.sources.GeoJsonSource
import org.maplibre.android.style.sources.ImageSource
import org.maplibre.android.style.sources.RasterDemSource
import org.maplibre.android.style.sources.RasterSource
import org.maplibre.android.style.sources.TileSet
import org.maplibre.android.style.sources.VectorSource
import java.io.IOException
import java.net.URI
import java.net.URL
import kotlin.coroutines.cancellation.CancellationException

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
        if (mapOptions.listensOnClick) {
            this.mapLibreMap.addOnMapClickListener { latLng ->
                flutterApi.onClick(LngLat(latLng.longitude, latLng.latitude)) { }
                true
            }
        }
        if (mapOptions.listensOnLongClick) {
            this.mapLibreMap.addOnMapLongClickListener { latLng ->
                flutterApi.onLongClick(LngLat(latLng.longitude, latLng.latitude)) { }
                true
            }
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

    private fun parseProperties(entries: Map<String, Any>): Array<PropertyValue<*>> =
        entries
            .map { entry ->
                // println("${entry.key}; ${entry.value::class.java.typeName}; ${entry.value}")
                when (entry.value) {
                    is ArrayList<*> -> {
                        val value = entry.value as ArrayList<*>
                        val json = gson.toJsonTree(value)
                        val expression = Expression.Converter.convert(json)
                        PaintPropertyValue(entry.key, expression)
                    }

                    else -> PaintPropertyValue(entry.key, entry.value)
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
        layer.setProperties(*parseProperties(paint), *parseProperties(layout))
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
        layer.setProperties(*parseProperties(paint), *parseProperties(layout))
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
        layer.setProperties(*parseProperties(paint), *parseProperties(layout))
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
        layer.setProperties(*parseProperties(paint), *parseProperties(layout))
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
        layer.setProperties(*parseProperties(paint), *parseProperties(layout))
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
        layer.setProperties(*parseProperties(paint), *parseProperties(layout))
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
        layer.setProperties(*parseProperties(paint), *parseProperties(layout))
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
        layer.setProperties(*parseProperties(paint), *parseProperties(layout))
        if (belowLayerId == null) {
            mapLibreMap.style?.addLayer(layer)
        } else {
            mapLibreMap.style?.addLayerBelow(layer, belowLayerId)
        }
        callback(Result.success(Unit))
    }

    override fun removeLayer(
        id: String,
        callback: (Result<Unit>) -> Unit,
    ) {
        mapLibreMap.style?.removeLayer(id)
        callback(Result.success(Unit))
    }

    override fun removeSource(
        id: String,
        callback: (Result<Unit>) -> Unit,
    ) {
        mapLibreMap.style?.removeSource(id)
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

    override fun removeImage(
        id: String,
        callback: (Result<Unit>) -> Unit,
    ) {
        mapLibreMap.style?.removeImage(id)
        callback(Result.success(Unit))
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
        val lngLatBounds =
            LngLatBounds(
                bounds.longitudeWest,
                bounds.longitudeEast,
                bounds.latitudeSouth,
                bounds.latitudeNorth,
            )
        callback(Result.success(lngLatBounds))
    }

    override fun addGeoJsonSource(
        id: String,
        data: String,
        callback: (Result<Unit>) -> Unit,
    ) {
        val options = GeoJsonOptions()
        val source =
            if (data.first() == '{') {
                GeoJsonSource(id, data, options)
            } else {
                GeoJsonSource(id, URI(data), options)
            }
        mapLibreMap.style?.addSource(source)
        callback(Result.success(Unit))
    }

    override fun updateGeoJsonSource(
        id: String,
        data: String,
        callback: (Result<Unit>) -> Unit,
    ) {
        val source = mapLibreMap.style?.getSourceAs<GeoJsonSource>(id)
        if (source == null) {
            callback(Result.failure(Exception("LAYER_NOT_FOUND")))
            return
        }
        source.setGeoJson(data)
        callback(Result.success(Unit))
    }

    override fun addImageSource(
        id: String,
        url: String,
        coordinates: List<LngLat>,
        callback: (Result<Unit>) -> Unit,
    ) {
        val quad =
            LatLngQuad(
                LatLng(coordinates[0].lat, coordinates[0].lng),
                LatLng(coordinates[0].lat, coordinates[0].lng),
                LatLng(coordinates[0].lat, coordinates[0].lng),
                LatLng(coordinates[0].lat, coordinates[0].lng),
            )
        val source = ImageSource(id, quad, URI(url))
        mapLibreMap.style?.addSource(source)
        callback(Result.success(Unit))
    }

    override fun addRasterSource(
        id: String,
        url: String?,
        tiles: List<String>?,
        bounds: List<Double>,
        minZoom: Double,
        maxZoom: Double,
        tileSize: Long,
        scheme: TileScheme,
        attribution: String?,
        volatile: Boolean,
        callback: (Result<Unit>) -> Unit,
    ) {
        val source =
            if (url == null) {
                // TODO improve this
                val tileSet = TileSet("{}", tiles!!.first())
                tileSet.maxZoom = maxZoom.toFloat()
                tileSet.minZoom = minZoom.toFloat()
                RasterSource(id, tileSet, tileSize.toInt())
            } else {
                RasterSource(id, url, tileSize.toInt())
            }
        source.isVolatile = volatile
        // TODO apply other properties
        mapLibreMap.style?.addSource(source)
        callback(Result.success(Unit))
    }

    override fun addRasterDemSource(
        id: String,
        url: String?,
        tiles: List<String>?,
        bounds: List<Double>,
        minZoom: Double,
        maxZoom: Double,
        tileSize: Long,
        attribution: String?,
        encoding: RasterDemEncoding,
        volatile: Boolean,
        redFactor: Double,
        blueFactor: Double,
        greenFactor: Double,
        baseShift: Double,
        callback: (Result<Unit>) -> Unit,
    ) {
        val source = RasterDemSource(id, url, tileSize.toInt())
        source.isVolatile = volatile
        // TODO apply other properties
        mapLibreMap.style?.addSource(source)
        callback(Result.success(Unit))
    }

    override fun addVectorSource(
        id: String,
        url: String?,
        tiles: List<String>?,
        bounds: List<Double>,
        scheme: TileScheme,
        minZoom: Double,
        maxZoom: Double,
        attribution: String?,
        volatile: Boolean,
        sourceLayer: String?,
        callback: (Result<Unit>) -> Unit,
    ) {
        val source = VectorSource(id, url)
        source.isVolatile = volatile
        // TODO apply other properties
        mapLibreMap.style?.addSource(source)
        callback(Result.success(Unit))
    }

    override fun getMetersPerPixelAtLatitude(latitude: Double): Double = mapLibreMap.projection.getMetersPerPixelAtLatitude(latitude)

    override fun updateOptions(
        options: MapOptions,
        callback: (Result<Unit>) -> Unit,
    ) {
        if (mapOptions.minZoom != options.minZoom) {
            mapLibreMap.setMinZoomPreference(options.minZoom)
        }
        if (mapOptions.maxZoom != options.maxZoom) {
            mapLibreMap.setMaxZoomPreference(options.maxZoom)
        }
        if (mapOptions.minPitch != options.minPitch) {
            mapLibreMap.setMinPitchPreference(options.minPitch)
        }
        if (mapOptions.maxPitch != options.maxPitch) {
            mapLibreMap.setMaxPitchPreference(options.maxPitch)
        }

        // map bounds
        val oldBounds = mapOptions.maxBounds
        val newBounds = options.maxBounds
        if (oldBounds != null && newBounds == null) {
            // remove map bounds
            mapLibreMap.setLatLngBoundsForCameraTarget(null)
        } else if (oldBounds == null && newBounds != null) {
            val bounds =
                LatLngBounds.from(
                    newBounds.latitudeNorth,
                    newBounds.longitudeEast,
                    newBounds.latitudeSouth,
                    newBounds.longitudeWest,
                )
            mapLibreMap.setLatLngBoundsForCameraTarget(bounds)
        } else if (newBounds != null &&
            // can get improved when https://github.com/flutter/flutter/issues/118087 is implemented
            (
                oldBounds?.latitudeNorth != newBounds.latitudeNorth ||
                    oldBounds.latitudeSouth != newBounds.latitudeSouth ||
                    oldBounds.longitudeEast != newBounds.longitudeEast ||
                    oldBounds.longitudeWest != newBounds.longitudeWest
            )
        ) {
            val bounds =
                LatLngBounds.from(
                    newBounds.latitudeNorth,
                    newBounds.longitudeEast,
                    newBounds.latitudeSouth,
                    newBounds.longitudeWest,
                )
            mapLibreMap.setLatLngBoundsForCameraTarget(bounds)
        }

        // gestures
        if (options.gestures.rotate != mapOptions.gestures.rotate) {
            mapLibreMap.uiSettings.isRotateGesturesEnabled = options.gestures.rotate
        }
        if (options.gestures.pan != mapOptions.gestures.pan) {
            mapLibreMap.uiSettings.isRotateGesturesEnabled = options.gestures.pan
        }
        if (options.gestures.zoom != mapOptions.gestures.zoom) {
            mapLibreMap.uiSettings.isZoomGesturesEnabled = options.gestures.zoom
            mapLibreMap.uiSettings.isDoubleTapGesturesEnabled = options.gestures.zoom
            mapLibreMap.uiSettings.isScrollGesturesEnabled = options.gestures.zoom
            mapLibreMap.uiSettings.isQuickZoomGesturesEnabled = options.gestures.zoom
        }
        if (options.gestures.tilt != mapOptions.gestures.tilt) {
            mapLibreMap.uiSettings.isTiltGesturesEnabled = options.gestures.tilt
        }
    }
}
