dart run jnigen --config jnigen.yaml

# https://github.com/dart-lang/native/issues/2493
$content = Get-Content -Path "lib/src/platform/android/jni/org/maplibre/android/camera/CameraUpdateFactory.dart"
$content = $content -replace "(?ms)^abstract base mixin class \`$CameraUpdateFactory\`$ZoomUpdate\`$Type \{.*?\}$\r?\n",""
$content = $content -replace "(?ms)^final class _\`$CameraUpdateFactory\`$ZoomUpdate\`$Type.*?\}$\r?\n",""
Set-Content -Path "lib/src/platform/android/jni/org/maplibre/android/camera/CameraUpdateFactory.dart" -Value $content