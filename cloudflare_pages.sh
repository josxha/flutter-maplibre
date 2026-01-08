#!/usr/bin/env bash
set -euo pipefail

echo "▶ Enabling Corepack & Yarn"
corepack enable
corepack prepare yarn@3.6.3 --activate

echo "▶ Building website (Yarn)"
cd website
yarn install --immutable
yarn build
cd ..

echo "▶ Fetching Flutter SDK (stable)"
git clone -b stable --depth 1 https://github.com/flutter/flutter.git

echo "▶ Building Flutter web (WASM)"
cd example
../flutter/bin/flutter build web \
  --wasm \
  --base-href /demo/ \
  -o ../website/build/demo

echo "✅ Cloudflare Pages build finished successfully"
