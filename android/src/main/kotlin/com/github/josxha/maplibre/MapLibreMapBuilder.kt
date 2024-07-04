package com.github.josxha.maplibre

import android.content.Context
import android.view.Gravity
import org.maplibre.android.camera.CameraPosition
import org.maplibre.android.geometry.LatLngBounds
import org.maplibre.android.maps.MapLibreMapOptions
import io.flutter.plugin.common.BinaryMessenger
import com.github.josxha.maplibre.MapLibreMapController

class MapLibreMapBuilder : MapLibreMapOptionsSink {
    private val options: MapLibreMapOptions =
        MapLibreMapOptions().attributionEnabled(true).logoEnabled(false)
            .textureMode(true)
    private var trackCameraPosition = false
    private var myLocationEnabled = false
    private var dragEnabled = true
    private var myLocationTrackingMode = 0
    private var myLocationRenderMode = 0
    private var styleString = ""
    private var bounds: LatLngBounds? = null

    fun build(
        id: Int,
        context: Context?,
        messenger: BinaryMessenger?,
        lifecycleProvider: LifecycleProvider?
    ): MapLibreMapController {
        val controller: MapLibreMapController =
            MapLibreMapController(
                id,
                context,
                messenger,
                lifecycleProvider,
                options,
                styleString,
                dragEnabled
            )
        controller.init()
        controller.setMyLocationEnabled(myLocationEnabled)
        controller.setMyLocationTrackingMode(myLocationTrackingMode)
        controller.setMyLocationRenderMode(myLocationRenderMode)
        controller.setTrackCameraPosition(trackCameraPosition)

        if (null != bounds) {
            controller.setCameraTargetBounds(bounds)
        }

        return controller
    }

    fun setInitialCameraPosition(position: CameraPosition?) {
        options.camera(position)
    }

    @Override
    fun setCompassEnabled(compassEnabled: Boolean) {
        options.compassEnabled(compassEnabled)
    }

    @Override
    fun setCameraTargetBounds(bounds: LatLngBounds) {
        this.bounds = bounds
    }

    @Override
    fun setStyleString(styleString: String) {
        this.styleString = styleString
    }

    @Override
    fun setMinMaxZoomPreference(min: Double?, max: Double?) {
        if (min != null) {
            options.minZoomPreference(min)
        }
        if (max != null) {
            options.maxZoomPreference(max)
        }
    }

    @Override
    fun setTrackCameraPosition(trackCameraPosition: Boolean) {
        this.trackCameraPosition = trackCameraPosition
    }

    @Override
    fun setRotateGesturesEnabled(rotateGesturesEnabled: Boolean) {
        options.rotateGesturesEnabled(rotateGesturesEnabled)
    }

    @Override
    fun setScrollGesturesEnabled(scrollGesturesEnabled: Boolean) {
        options.scrollGesturesEnabled(scrollGesturesEnabled)
    }

    @Override
    fun setTiltGesturesEnabled(tiltGesturesEnabled: Boolean) {
        options.tiltGesturesEnabled(tiltGesturesEnabled)
    }

    @Override
    fun setZoomGesturesEnabled(zoomGesturesEnabled: Boolean) {
        options.zoomGesturesEnabled(zoomGesturesEnabled)
    }

    @Override
    fun setMyLocationEnabled(myLocationEnabled: Boolean) {
        this.myLocationEnabled = myLocationEnabled
    }

    @Override
    fun setMyLocationTrackingMode(myLocationTrackingMode: Int) {
        this.myLocationTrackingMode = myLocationTrackingMode
    }

    @Override
    fun setMyLocationRenderMode(myLocationRenderMode: Int) {
        this.myLocationRenderMode = myLocationRenderMode
    }

    fun setLogoViewMargins(x: Int, y: Int) {
        options.logoMargins(
            intArrayOf(
                x,  // left
                0,  // top
                0,  // right
                y,  // bottom
            )
        )
    }

    @Override
    fun setCompassGravity(gravity: Int) {
        when (gravity) {
            0 -> options.compassGravity(Gravity.TOP or Gravity.START)
            1 -> options.compassGravity(Gravity.TOP or Gravity.END)
            2 -> options.compassGravity(Gravity.BOTTOM or Gravity.START)
            3 -> options.compassGravity(Gravity.BOTTOM or Gravity.END)
        }
    }

    @Override
    fun setCompassViewMargins(x: Int, y: Int) {
        when (options.getCompassGravity()) {
            Gravity.TOP or Gravity.START -> options.compassMargins(
                intArrayOf(
                    x, y, 0, 0
                )
            )

            Gravity.TOP or Gravity.END -> options.compassMargins(
                intArrayOf(
                    0,
                    y, x, 0
                )
            )

            Gravity.BOTTOM or Gravity.START -> options.compassMargins(
                intArrayOf(
                    x, 0, 0, y
                )
            )

            Gravity.BOTTOM or Gravity.END -> options.compassMargins(
                intArrayOf(
                    0, 0,
                    x,
                    y
                )
            )

            else -> options.compassMargins(intArrayOf(0, y, x, 0))
        }
    }

    @Override
    fun setAttributionButtonGravity(gravity: Int) {
        when (gravity) {
            0 -> options.attributionGravity(Gravity.TOP or Gravity.START)
            1 -> options.attributionGravity(Gravity.TOP or Gravity.END)
            2 -> options.attributionGravity(Gravity.BOTTOM or Gravity.START)
            3 -> options.attributionGravity(Gravity.BOTTOM or Gravity.END)
        }
    }

    @Override
    fun setAttributionButtonMargins(x: Int, y: Int) {
        when (options.getAttributionGravity()) {
            Gravity.TOP or Gravity.START -> options.attributionMargins(
                intArrayOf(
                    x, y, 0, 0
                )
            )

            Gravity.TOP or Gravity.END -> options.attributionMargins(
                intArrayOf(
                    0,
                    y, x, 0
                )
            )

            Gravity.BOTTOM or Gravity.START -> options.attributionMargins(
                intArrayOf(
                    x, 0, 0, y
                )
            )

            Gravity.BOTTOM or Gravity.END -> options.attributionMargins(
                intArrayOf(
                    0, 0,
                    x,
                    y
                )
            )

            else -> options.attributionMargins(intArrayOf(x, 0, 0, y))
        }
    }

    fun setDragEnabled(enabled: Boolean) {
        this.dragEnabled = enabled
    }
}