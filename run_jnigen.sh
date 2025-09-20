#!/usr/bin/env bash

dart run jnigen --config jnigen.yaml

# https://github.com/dart-lang/native/issues/2493
sed -i '
/^abstract base mixin class \$CameraUpdateFactory\$ZoomUpdate\$Type {/,/^}$/d
/^final class _\$CameraUpdateFactory\$ZoomUpdate\$Type/,/^}$/d
' lib/src/platform/android/jni/org/maplibre/android/camera/CameraUpdateFactory.dart
