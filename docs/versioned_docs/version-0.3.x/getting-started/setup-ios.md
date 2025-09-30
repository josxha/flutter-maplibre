---
sidebar_position: 30
---

# Setup iOS

## Activate the Swift Package Manager

The Swift Package Manager is available in the `stable` channel since
Flutter 3.24 but needs to be enabled by running the following command:

```bash
flutter config --enable-swift-package-manager
```

You can also add it just for this project by adding the following line to the 
pubspec.yaml file of your app:

```yaml title="pubspec.yaml"
flutter:
  config:
    enable-swift-package-manager: true
```