platform :ios, '10.0'

target 'ViaPlay-TechTest' do
  
  use_frameworks!
  pod 'Alamofire', '~> 4.4'
  pod 'ModelMapper'

  target 'ViaPlay-TechTestTests' do
    inherit! :search_paths
  end

  target 'ViaPlay-TechTestUITests' do
    inherit! :search_paths
  end

    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
    end
end
