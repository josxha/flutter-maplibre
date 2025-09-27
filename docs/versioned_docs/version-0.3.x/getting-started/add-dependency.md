---
sidebar_position: 10
---

# Add Dependency

## Use the package from pub.dev

Add `maplibre` to your project by running this command:

```bash
flutter pub add maplibre
```

Alternatively, add it directly as a dependency to your `pubspec.yaml` file and
run `flutter pub get`:

```yaml title="pubspec.yaml"
dependencies:
  # highlight-next-line
  maplibre: ^0.2.0
```

Ensure that you use the documentation of the right
version. [Click here](/docs/getting-started/add-dependency)
to get to docs of the latest released version.
You can find the latest version of the package on
[pub.dev](https://pub.dev/packages/maplibre) or here:

[![Pub Version](https://img.shields.io/pub/v/maplibre)](https://pub.dev/packages/maplibre)

## Using the development version

If you want to have access to the latest features and changes, you
can use the package directly from GitHub.

:::warning

Note, that the development version is not considered stable and shouldn't be
used in production systems.

:::

This is how you include the package directly from GitHub. Either use it in your
`dependecies:` or temporarily override it inside the `dependency_overrides:`
list.

```yaml title="pubspec.yaml"
dependencies:
  # highlight-start
  maplibre:
    git:
      url: https://github.com/josxha/flutter-maplibre
      ref: main # or a specific commit hash 
  # highlight-end
```
