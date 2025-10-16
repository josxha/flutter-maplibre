package com.github.josxha.maplibre

// if imports can't resolve: https://stackoverflow.com/a/65903576/9439899

import CameraChangeReason
import LngLat
import MapCamera
import MapLibreFlutterApi
import MapOptions
import Offset
import android.content.Context
import android.graphics.BitmapFactory
import android.util.Log
import android.view.View
import android.widget.FrameLayout
import androidx.lifecycle.DefaultLifecycleObserver
import io.flutter.embedding.engine.plugins.FlutterPlugin
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
import java.io.IOException
import java.net.URL

class MapLibreMapController(
    private val viewId: Int,
    private val context: Context,
    private val lifecycleProvider: LifecycleProvider,
    binaryMessenger: BinaryMessenger,
    private val flutterAssets: FlutterPlugin.FlutterAssets,
) : PlatformView,
    DefaultLifecycleObserver,
    OnMapReadyCallback {
    private val mapViewContainer = FrameLayout(context)
    private lateinit var mapLibreMap: MapLibreMap
    private lateinit var mapView: MapView
    private val flutterApi: MapLibreFlutterApi
    private lateinit var mapOptions: MapOptions
    private var style: Style? = null
    private val density = getDensityMultiplier()

    init {
        val channelSuffix = viewId.toString()
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
                    .attributionEnabled(false)
                    .logoEnabled(false)
                    // TODO: textureMode comes at a significant performance penalty, https://maplibre.org/maplibre-native/android/api/-map-libre%20-native%20-android/org.maplibre.android.maps/-map-libre-map-options/texture-mode.html
                    .textureMode(mapOptions.androidTextureMode)
                    .foregroundLoadColor(mapOptions.androidForegroundLoadColor.toInt())
                    .translucentTextureSurface(mapOptions.androidTranslucentTextureSurface)
                    .compassEnabled(false)
                    .minZoomPreference(mapOptions.minZoom)
                    .maxZoomPreference(mapOptions.maxZoom)
                    .minPitchPreference(mapOptions.minPitch)
                    .maxPitchPreference(mapOptions.maxPitch)
                    .rotateGesturesEnabled(mapOptions.gestures.rotate)
                    .zoomGesturesEnabled(mapOptions.gestures.zoom)
                    .doubleTapGesturesEnabled(mapOptions.gestures.zoom)
                    .scrollGesturesEnabled(mapOptions.gestures.zoom)
                    .quickZoomGesturesEnabled(mapOptions.gestures.zoom)
                    .tiltGesturesEnabled(mapOptions.gestures.tilt)
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
            val projection = mapLibreMap.projection
            val screenLocation = projection.toScreenLocation(latLng)
            flutterApi.onClick(
                LngLat(latLng.longitude, latLng.latitude),
                Offset(
                    (screenLocation.x / density).toDouble(),
                    (screenLocation.y / density).toDouble(),
                ),
            ) { }
            true
        }
        this.mapLibreMap.addOnMapLongClickListener { latLng ->
            val projection = mapLibreMap.projection
            val screenLocation = projection.toScreenLocation(latLng)
            flutterApi.onLongClick(
                LngLat(latLng.longitude, latLng.latitude),
                Offset(
                    (screenLocation.x / density).toDouble(),
                    (screenLocation.y / density).toDouble(),
                ),
            ) { }
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

        val style = getStyle(mapOptions.style)
        try {
            mapLibreMap.setStyle(style) { loadedStyle ->
                this.style = loadedStyle
                flutterApi.onStyleLoaded { }
            }
        } catch (e: Exception) {
            Log.e("MapLibreMapController", "setStyle - error: ${e.message}")
        }
        flutterApi.onMapReady { }
    }

    override fun dispose() {
        // free any resources
    }

    private fun getStyle(styleString: String): Style.Builder? {
        val style = styleString.trim()

        // Check if style is null or empty.
        if (style.isEmpty()) {
            Log.e("MapLibreMapController", "getStyle - string empty or null")
            return null
        }

        // Returns the Style based on its type.
        return when {
            // JSON style objects
            style.startsWith("{") ->
                Style.Builder().fromJson(style)

            // Absolute file paths
            style.startsWith("/") ->
                Style.Builder().fromUri("file://$style")

            // Asset files (non-URL, non-Mapbox)
            !style.startsWith("http://") &&
                !style.startsWith("https://") &&
                !style.startsWith("mapbox://") ->
                Style.Builder().fromUri("asset://" + flutterAssets.getAssetFilePathByName(style))

            // Remote URIs (HTTP/HTTPS/Mapbox)
            else -> Style.Builder().fromUri(style)
        }
    }

    private fun getDensityMultiplier(): Float {
        val metrics = context.resources.displayMetrics
        return metrics.density
    }
}
