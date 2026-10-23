plugins {
    id("com.android.library")
}

group = "com.github.josxha.maplibre_native"
version = "1.0-SNAPSHOT"

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

android {
    namespace = "com.github.josxha.maplibre_native"

    compileSdk = 36

    defaultConfig {
        minSdk = 24
        // Keeps the classes that native code reaches through JNI.
        consumerProguardFiles("consumer-rules.pro")
        externalNativeBuild {
            cmake {
                arguments += "-DANDROID_STL=c++_static"
            }
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
    }

    // The JNI shim that creates the Vulkan device and the surfaces MapLibre
    // renders into. The MapLibre Native C library itself reaches the app as a
    // Dart code asset.
    externalNativeBuild {
        cmake {
            path = file("src/main/cpp/CMakeLists.txt")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}
