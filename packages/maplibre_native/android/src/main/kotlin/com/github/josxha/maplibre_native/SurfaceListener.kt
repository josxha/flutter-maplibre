package com.github.josxha.maplibre_native

/**
 * Receives the Surface changes of a map texture. Dart implements it through
 * jnigen, and the calls arrive on the main thread.
 */
interface SurfaceListener {
    /**
     * The Surface is available again, for example after the app returned from
     * the background. When Flutter recreated it, Dart moves the session to
     * [surface] and then releases [oldSurface] through
     * [MaplibreNativeApi.releaseSurface]. Both are EGL or Vulkan surface
     * handles, as the texture was created for. [oldSurface] is 0 when the Surface
     * stayed the same.
     */
    fun onSurfaceChanged(
        surface: Long,
        oldSurface: Long,
    )

    /** The Surface becomes invalid, so the map stops demanding frames. */
    fun onSurfaceCleanup()
}
