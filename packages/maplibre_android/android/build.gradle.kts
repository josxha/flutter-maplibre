plugins {
    id("com.android.library")
    id("org.jlleitschuh.gradle.ktlint")
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

    dependencies {
        api("org.maplibre.gl:android-sdk-opengl:13.0.2")
        testImplementation("org.jetbrains.kotlin:kotlin-test")
        testImplementation("org.mockito:mockito-core:5.21.+")
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

ktlint {
    version.set("1.7.1")
    android.set(true)
    ignoreFailures.set(false)
    reporters {
        reporter(org.jlleitschuh.gradle.ktlint.reporter.ReporterType.PLAIN)
        reporter(org.jlleitschuh.gradle.ktlint.reporter.ReporterType.CHECKSTYLE)
    }
    dependencies {
        // noinspection GradleDynamicVersion
        ktlintRuleset("io.nlopez.compose.rules:ktlint:0.5.3")
    }
    filter {
        exclude("**/*.g.kt")
    }
}
