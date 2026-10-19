`src/main/kotlin/org/maplibre/nativeffi/internal/rustlsplatformverifier/CertificateVerifier.kt`
is the patched Android certificate verifier of
[rustls-platform-verifier](https://github.com/rustls/rustls-platform-verifier)
v/0.6.2 (commit 1099f161bfc5e3ac7f90aad88b1bf788e72906cb), as
`maplibre-native-ffi` prepares it in `build/dependencies` with the patches in
its `patches/rustls-platform-verifier`. The MapLibre Native C library calls it
over JNI to verify TLS certificates. See NOTICE for the changes and the
licenses beside it.
