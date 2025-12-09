#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint maplibre_ios.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'maplibre_ios'
  s.version          = '0.0.1'
  s.summary          = 'Helper package for maplibre that provides iOS FFI bindings'
  s.description      = <<-DESC
Helper package for maplibre that provides iOS FFI bindings
                       DESC
  s.homepage         = 'https://github.com/josxha/flutter-maplibre'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Joscha Eckert' => 'info@joscha-eckert.de' }
  s.source           = { :path => '.' }
  s.source_files = 'maplibre_ios/Sources/maplibre_ios/**/*'
  s.dependency 'Flutter'

  # Needs to be the same version as in maplibre_ios/Package.swift
  # FOR PREBUILT LIBRARY
  s.dependency 'MapLibre', '~> 6.21'

  # FOR LOCAL LIBRARY
  # s.vendored_frameworks = '.build/MapLibre.xcframework'

  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'maplibre_ios_privacy' => ['maplibre_ios/Sources/maplibre_ios/PrivacyInfo.xcprivacy']}
end
