#!/bin/bash
# Builds and runs gl_texture_test.cc, which checks the zero-copy path of the
# Linux plugin without Flutter: a GDK OpenGL context of a real GTK window, the
# plugin's Vulkan device on the OpenGL device, exported Vulkan images that
# OpenGL imports, and the present copy that Flutter samples.
#
# Needs a display (or xvfb-run), libgtk-3-dev, libepoxy-dev, a Vulkan driver,
# and Flutter's Linux engine headers, which `flutter precache --linux` puts in
# the Flutter SDK. On a machine without a GPU, Mesa's lavapipe and llvmpipe
# share memory with each other:
#
#   LIBGL_ALWAYS_SOFTWARE=1 VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/lvp_icd.json \
#     packages/maplibre_native/linux/test/run_gl_texture_test.sh
#
# Vulkan headers come from VULKAN_INCLUDE, else from the system.
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
package="$here/../.."
flutter_root="${FLUTTER_ROOT:-$(dirname "$(dirname "$(readlink -f "$(command -v flutter)")")")}"
engine="$flutter_root/bin/cache/artifacts/engine/linux-x64"
out="$(mktemp -d)"
trap 'rm -rf "$out"' EXIT
${CXX:-g++} -std=c++17 -O1 -g -Wall -Werror -DFLUTTER_LINUX_COMPILATION \
  -I"$engine" -I"$package/linux" -I"$package/desktop" \
  -I"$package/desktop/include" ${VULKAN_INCLUDE:+-I"$VULKAN_INCLUDE"} \
  $(pkg-config --cflags gtk+-3.0 epoxy) \
  "$here/gl_texture_test.cc" "$package/linux/gl_texture.cc" \
  "$package/desktop/vulkan_device.cpp" \
  $(pkg-config --libs gtk+-3.0 epoxy) -ldl -o "$out/gl_texture_test"
"$out/gl_texture_test"
