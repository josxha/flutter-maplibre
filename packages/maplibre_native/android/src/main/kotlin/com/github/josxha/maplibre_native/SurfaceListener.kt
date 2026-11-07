package com.github.josxha.maplibre_native

/**
 * Receives the Surface changes of a map texture. Dart implements it through
 * jnigen, and the calls arrive on the main thread.
 */
interface SurfaceListener {
    /**
     * The Surface is available again, for example after the app returned from
     * the background, and may be a new one. Dart gives it to the session and
     * resumes rendering.
     */
    fun onSurfaceAvailable()

    /** The Surface becomes invalid, so the map stops presenting to it. */
    fun onSurfaceCleanup()
}
