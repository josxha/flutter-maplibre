# The MapLibre Native C library calls the TLS certificate verifier over JNI.
-keep, includedescriptorclasses class org.maplibre.nativeffi.internal.rustlsplatformverifier.** { *; }
# The JNI shim binds these native methods by name.
-keep class com.github.josxha.maplibre_native.NativeBridge { *; }
