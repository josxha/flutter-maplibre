# This is the rules file which prevents `proguard` from aggressively
# removing the classes which appear to be unused, in release mode.
#
# Since JNI is based on runtime lookup for classes, proguard will not have
# a way to know maplibre classes are actually used. Therefore
# we have to explicitly list them in this file to prevent the application from
# crashing with ClassNotFoundException.
#
# This doesn't apply to builtin classes, eg: those in `android.` namespace Since
# they are already present on the device.
# For the Java code which is written by yourself, you can add
# `androidx.annotation.Keep` instead. (As done in `MapLibreMapRegistry.kt`).
#
# For more details, see
# http://developer.android.com/guide/developing/tools/proguard.html


# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task
-dontwarn javax.lang.model.element.Modifier


-keep class com.github.josxha.maplibre.** { *; }

-keep class org.maplibre.android.attribution.** { public *; }
-keep class org.maplibre.android.camera.** { public *; }
-keep class org.maplibre.android.constants.** { public *; }
-keep class org.maplibre.android.exceptions.** { public *; }
-keep class org.maplibre.android.geometry.** { public *; }
-keep class org.maplibre.android.http.** { public *; }
-keep class org.maplibre.android.location.** { public *; }
-keep class org.maplibre.android.log.** { public *; }
-keep class org.maplibre.android.maps.** { public *; }
-keep class org.maplibre.android.offline.** { public *; }
-keep class org.maplibre.android.storage.** { public *; }
-keep class org.maplibre.android.style.layers.** { public *; }
-keep class org.maplibre.android.style.light.** { public *; }
-keep class org.maplibre.android.style.sources.** { public *; }
-keep class org.maplibre.android.style.types.** { public *; }
-keep class org.maplibre.android.text.** { public *; }
-keep class org.maplibre.android.util.** { public *; }
-keep class org.maplibre.android.utils.** { public *; }

-dontshrink
-dontoptimize