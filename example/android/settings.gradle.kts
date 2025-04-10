pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        maven("https://plugins.gradle.org/m2/")
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.6.+" apply false
    // Use a Kotlin version that is compatible with MapLibre
    id("org.jetbrains.kotlin.android") version "2.1.+" apply false
    id("org.jlleitschuh.gradle.ktlint") version "12.2.+" apply false
}

include(":app")
// JNIGEN include(":MapLibreAndroid")
