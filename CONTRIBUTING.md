# Contributing

We welcome contributions to this repository. Please follow these steps if
you're interested in making contributions:

## Preceding steps

1. Ensure that
   existing [pull requests](https://github.com/josxha/flutter-maplibre/pulls)
   and [issues](https://github.com/josxha/flutter-maplibre/issues) don’t
   already cover your contribution or question.
2. If your pull request will add a major or breaking change, please open a
   [feature request](https://github.com/josxha/flutter-maplibre/issues/new/choose)
   first to start a discussion.
3. The example app under [/example](/example) is used as a reference point.
   If you have a bug and can't tell if it's related to the package, please try
   to reproduce it with the example app or create some other way to reproduce
   your issue.
4. Ensure that what you have planned is possible by verifying this functionality
   is supported
   by [maplibre-native](https://github.com/maplibre/maplibre-native)
   and [maplibre-gl-js](https://github.com/maplibre/maplibre-gl-js).

## Start contributing

1. [Fork the repository](https://github.com/josxha/flutter-maplibre/fork) and
   push your changes to a new branch to avoid conflicts in your forked
   repository.
2. Along with your contribution please also adapt the example app to showcase
   any new features or APIs you have developed. This allows quick testing and
   gives evaluating users a better idea about the functionality of the package.
3. Consider updating
   the [documentation](https://github.com/josxha/flutter-maplibre/tree/main/docs/docs)
   to explain users how to implement.
4. If there are any changes that developers should be aware of, please update
   the [CHANGELOG.md](https://github.com/josxha/flutter-maplibre/blob/main/CHANGELOG.md)
   file together with your pull request.
5. If you change the [./pigeons/pigeon.dart](./pigeons/pigeon.dart) file, you'll
   have to run the [pigeon](https://pub.dev/packages/pigeon) code generation.
   You can use [./pigeons/run_code_gen.sh](./pigeons/run_code_gen.sh)
   or [./pigeons/run_code_gen.ps1](./pigeons/run_code_gen.ps1).
6. If you have a pull request that isn't complete yet and want to get
   feedback, consider
   to [open a draft pull request](https://github.com/josxha/flutter-maplibre/pulls).
   This helps others to get
   involved into the changes more early and allows to link the pull request to
   open issues. Give a quick summary about your changes listing any related
   issues that exist. Screenshots and videos are or course welcome, too.
   Use a [conventional](https://www.conventionalcommits.org/) title if you like.
7. When your contribution is ready to review, disable the draft state of your
   pull request and update the summary by editing your initial pull request
   message. This summary will go into the commit details of the squashed commit.

Thanks for every contribution you make to the project.

# Building

## jnigen

Ensure you have JDK 17 installed and set as the system JDK version:

```bash
apt install openjdk-17-jdk-headless
sudo update-alternatives --config java
```  
or
```bash
brew install openjdk@17
echo 'export JAVA_HOME="$(/usr/libexec/java_home -v 17)"' >> ~/.zshrc
source ~/.zshrc
```  

Build the example project to fetch Gradle dependencies:

```bash
(cd example/ && flutter build apk)
```

Run jnigen:

```bash
dart run jnigen --config jnigen.yml
```

## ffigen (macOS only)

Build the example project:

```bash
(cd example/ && flutter build ios --release --no-codesign)
```

### \<optional> build MapLibre Native with debugging symbols

Clone maplibre-native as a sibling to flutter-maplibre:

```bash
cd ..
git clone https://github.com/maplibre/maplibre-native --recurse-submodules --shallow-submodules
```

Then build MapLibre (this will take a while):

```bash
cd flutter-maplibre/maplibre_ios
./build_maplibre.sh
```

This will output a copy of MapLibre.xcframework in `maplibre_ios/.build`.

Finally, modify `maplibre_ios/ios/maplibre_ios.podspec` and 
`maplibre_ios/ios/maplibre_ios/Package.swift` to use your local copy of 
MapLibre. Comment out lines marked `// FOR PREBUILT LIBRARY` and
uncomment lines marked `// FOR LOCAL LIBRARY`.

### \</optional>

Generate Obj-C headers for the library's native Swift layer:

```bash
(cd ios/maplibre_ios/Sources/maplibre_ios && ./gen_swift_headers.sh)
```

Finally, run ffigen from the maplibre_ios directory:

```bash
dart run ffigen
```

The script runs ffigen on the relevant version of MapLibre.framework in the 
Swift build cache.