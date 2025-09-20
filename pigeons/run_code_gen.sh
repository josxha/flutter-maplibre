#!/usr/bin/env bash

if [ ! -f ./pigeons/pigeon.dart ]; then
    echo "Run this script from the root of the project"
    exit 1
fi

packages=$(flutter pub global list)
if echo "$packages" | grep -q "pigeon"; then
    echo "pigeon installed"
else
  flutter pub global activate pigeon # only once
fi

dart run pigeon --input pigeons/pigeon.dart
dart format .
#cp maplibre_ios/ios/maplibre_ios/Sources/maplibre_ios/Pigeon.g.swift macos/Classes/Pigeon.g.swift
