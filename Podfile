use_frameworks!
platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'

# ignore all warnings from all pods
inhibit_all_warnings!

project 'ASCIIShop.xcodeproj'
target 'ASCIIShop' do
  # Core
  pod 'ObjectMapper', '~> 2.0.0'
  pod 'RxSwift', '~> 3.0.1'
  pod 'RxCocoa', '~> 3.0.1'
  pod 'RxDataSources', '~> 1.0.0'
  pod 'Action', '~> 2.0.0'
  pod 'Alamofire', '~> 4.2.0'
  pod 'R.swift', '~> 3.1.0'

  target 'ASCIIShopTests' do
  end

end
# To ensure we select swift version for all pod targets
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |configuration|
            configuration.build_settings['SWIFT_VERSION'] = "3.0"
        end
    end
end
