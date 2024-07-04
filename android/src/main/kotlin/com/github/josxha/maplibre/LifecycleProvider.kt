package com.github.josxha.maplibre

import androidx.lifecycle.Lifecycle

interface LifecycleProvider {
    fun getLifecycle(): Lifecycle?
}
