---
sidebar_position: 90
---

# Architecture

This page gives a small introduction in the architecture that is used
for `maplibre`.

## Abstraction Layers

```mermaid
flowchart TD
    MapLibreMap -->|uses| MapLibreMapState
    MapLibreMapState -->|extends| MapLibreMapStateNative
    MapLibreMapStateNative -->|extends| MapLibreMapStateAndroid
    MapLibreMapStateNative -->|extends| MapLibreMapStateIos
    MapLibreMapState --->|extends| MapLibreMapStateWeb
    MapController -->|implements| MapLibreMapState
    MapLibreMapStateAndroid -->|method channel, jni| Kotlin([Kotlin])
    MapLibreMapStateIos -->|method channel, ffi| Swift([Swift])
    MapLibreMapStateWeb -->|interop| TypeScript([TypeScript])
```

### 1. Public API

`MapLibreMap` and `MapController` is part of the public API. That part of the
package that users are in contact with.

### 2. MapLibreMapState

`MapLibreMapState` is an abstract base class for the `State<MapLibreMap`> and
contains implementations that are completely platform invariant.

### 3. MapLibreMapStateNative

This class is a unified parent class for all non-web platforms that use the
Pigeon method channel. Because pigoen dart code is the same on all non-web
platforms, all those implementations are located in `MapLibreMapStateNative`.

### 4. MapLibreMapStateAndroid, -Ios, -Web

This is the last Flutter/Dart layer. These classes contain missing
implementations that haven't previously been implemented on an higher level.

This layer has the connection with the Native Code Layer using

- Method Channels with the Pigeon code generator
- JNI using JNIGEN to interop with Kotlin on Android
- FFI using FFIGEN to interop with Swift on iOS
- The WASM compatible interop with JavaScript using js_interop and package:web
  on Web.

### 5. Native Layer

The last and most low level layer that package uses. This layer handles Platform
View registration and the native implementation of Pigeon.
