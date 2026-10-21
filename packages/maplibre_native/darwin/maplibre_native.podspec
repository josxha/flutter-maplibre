Pod::Spec.new do |s|
  s.name             = 'maplibre_native'
  s.version          = '0.4.0'
  s.summary          = 'MapLibre Native implementation of the Flutter MapLibre plugin.'
  s.description      = <<-DESC
Shows MapLibre Native maps, rendered through Metal, as Flutter textures on iOS
and macOS.
                       DESC
  s.homepage         = 'https://github.com/josxha/flutter-maplibre'
  s.license          = { :type => 'BSD', :file => '../LICENSE' }
  s.author           = { 'josxha' => 'https://github.com/josxha' }
  s.source           = { :path => '.' }
  s.source_files     = 'maplibre_native/Sources/maplibre_native/**/*.{h,m}'
  s.public_header_files = 'maplibre_native/Sources/maplibre_native/include/**/*.h'
  s.ios.dependency 'Flutter'
  s.osx.dependency 'FlutterMacOS'
  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'
  s.frameworks       = 'CoreVideo', 'Metal'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
end
