---
sidebar_position: 10
---

# Add Dependency

## Use the package from pub.dev

=== "Run command"
    
    Add `maplibre` to your project by running this command:
    
    ```bash
    flutter pub add maplibre
    ```

=== "Edit `pubspec.yaml`"

    Alternatively, add it directly as a dependency to your `pubspec.yaml` file and
    run `flutter pub get`:
    
    ```yaml title="pubspec.yaml"
    dependencies:
      # highlight-next-line
      maplibre: ^0.3.0
    ```

<details>
<summary>Using the development version</summary>

If you want to have access to the latest features and changes, you
can use the package directly from GitHub.

!!! warning

    Note, that the development version is not considered stable and shouldn't be
    used in production systems.

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

</details>
