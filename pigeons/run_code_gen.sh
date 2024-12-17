#!/usr/bin/env bash

packages=$(flutter pub global list)
if echo "$packages" | grep -q "pigeon"; then
  echo "pigeon installed"
else
  flutter pub global activate pigeon # only once
fi

dart run pigeon --input pigeons/pigeon.dart
dart format .
cp ios/Classes/Pigeon.g.swift macos/Classes/Pigeon.g.swift
