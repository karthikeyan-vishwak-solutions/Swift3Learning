# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'Subclassing' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'RealmSwift'
  pod 'IQKeyboardManagerSwift'
  pod 'SVProgressHUD'
  pod 'SDWebImage', '~>3.8'
  # Pods for Subclassing

  target 'SubclassingTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SubclassingUITests' do
    inherit! :search_paths
    # Pods for testing
  end
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

end
