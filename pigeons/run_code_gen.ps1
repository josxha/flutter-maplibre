# Get the list of globally installed Flutter packages
$packages = flutter pub global list

# Check if "pigeon" is installed
if ($packages -match "pigeon") {
    Write-Host "pigeon installed"
} else {
    flutter pub global activate pigeon
}

# Run pigeon and format Dart files
dart run pigeon --input pigeons/pigeon.dart
dart format .

# Copy file from ios to macos directory
#Copy-Item ios/Classes/Pigeon.g.swift -Destination macos/Classes/Pigeon.g.swift
