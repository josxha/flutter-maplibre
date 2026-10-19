package org.maplibre.nativeffi.internal.rustlsplatformverifier

/**
 * Stands in for the BuildConfig that the verifier's own Gradle module
 * generates. CertificateVerifier.kt is vendored from maplibre-native-ffi; see
 * `android/licenses/rustls-platform-verifier`.
 */
internal object BuildConfig {
    const val TEST = false
}
