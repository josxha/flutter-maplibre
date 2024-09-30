package com.github.josxha.maplibre

import android.app.Activity

class UiThreadHelper(
    public val activity: Activity
) {
    public fun runInUiThread(activity: Activity) {
        activity.runOnUiThread {

        }
    }
}