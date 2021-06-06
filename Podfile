# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'Inklukva' do
  # Comment the next line if you don't want to use dynamic frameworks
  pod 'Firebase/Analytics', :modular_headers => true

  # Pods for Inklukva

  target 'InklukvaTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Firebase/Analytics', :modular_headers => true
  end

  post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = "NO"
      end
  end

end
