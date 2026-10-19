package com.github.josxha.maplibre_native

/**
 * Receives the Surface changes of a map texture. Dart implements it through
 * jnigen, and the calls arrive on the main thread.
 */
interface SurfaceListener {
    /**
     * Flutter recreated the Surface, for example after the app returned from
     * the background. Dart moves the session to [surface] and then releases
     * [oldSurface] through [MaplibreNativeApi.releaseSurface].
     */
    fun onSurfaceChanged(
        surface: Long,
        oldSurface: Long,
    )

    /** The Surface becomes invalid, so the map stops demanding frames. */
    fun onSurfaceCleanup()
}
