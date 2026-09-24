plugins {
    id("com.android.library")
}

group = "com.github.josxha.maplibre"
version = "1.0-SNAPSHOT"

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

apply(plugin = "com.android.library")

android {
    // Keeping the classes from being removed by proguard.
    defaultConfig {
        consumerProguardFiles("consumer-rules.pro")
    }
    buildTypes {
        release {
            isMinifyEnabled = false
        }
    }

    namespace = "com.github.josxha.maplibre"

    compileSdk = 35

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
        getByName("test").java.srcDirs("src/test/kotlin")
    }

    defaultConfig {
        minSdk = 21
    }

    testOptions {
        unitTests.all { it.useJUnitPlatform() }
    }

    dependencies {
        api("org.maplibre.gl:android-sdk-opengl:13.5.+")
        implementation("com.squareup.okhttp3:okhttp:4.12.0")
        testImplementation("org.junit.jupiter:junit-jupiter:5.12.2")
        testImplementation("org.jetbrains.kotlin:kotlin-test")
        testImplementation("org.mockito:mockito-core:5.21.+")
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}
