#!/usr/bin/env bash

echo "▶ Building website"
pip install zensical
zensical build --clean

echo "▶ Fetching Flutter SDK (stable)"
git clone -b stable --depth 1 https://github.com/flutter/flutter.git

echo "▶ Building Flutter web"
cd examples
../flutter/bin/flutter build web --wasm \
  --base-href /demo/ \
  -o ../site/demo
cd ..

echo "▶ Copy header configuration"
echo "/*
        Cross-Origin-Embedder-Policy: credentialless
        Cross-Origin-Opener-Policy: same-origin" > website/build/_headers

echo "✅ Cloudflare Pages build finished successfully"
