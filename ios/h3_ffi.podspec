#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
require 'yaml'
pubspec = YAML.load_file(File.join('..', 'pubspec.yaml'))
libraryVersion = pubspec['version'].gsub('+', '-')

Pod::Spec.new do |s|
  s.name             = 'h3_ffi'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter project.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }

  s.source           = { :path => '.' }
  s.source_files = 'h3lib/**/*'
  s.public_header_files = 'h3lib/**/*.h'
  s.prepare_command = <<-CMD
      ln -s ../cpp/h3/src/h3lib/ . || echo "file exists"
    CMD

  s.dependency 'Flutter'
  s.dependency 'Firebase'
  s.static_framework = true
  s.ios.deployment_target = '8.0'
end



