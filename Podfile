source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'

target 'MyApp' do
  
  use_frameworks!
  inhibit_all_warnings!
  
  # Networking
  pod 'Moya/RxSwift' # https://github.com/Moya/Moya

  # Rx Extensions
  pod 'NSObject+Rx', '~> 5.0' # https://github.com/RxSwiftCommunity/NSObject-Rx
  pod 'RxDataSources', '~> 4.0' # https://github.com/RxSwiftCommunity/RxDataSources

  # Tools
  pod 'Reusable' # https://github.com/AliSoftware/Reusable
  pod 'Validator' # https://github.com/adamwaite/Validator
  pod 'MPDebug', :configurations => ['Debug'] # https://github.com/manhpham90vn/MPDebug

  # Logging
  pod 'XCGLogger', '~> 7.0.1' # https://github.com/DaveWoodCom/XCGLogger

  # UI
  pod 'Toast-Swift', '~> 5.0'  # https://github.com/scalessec/Toast-Swift
  pod 'SwiftLint' # https://github.com/realm/SwiftLint
  pod 'SVProgressHUD', :git => 'https://github.com/SVProgressHUD/SVProgressHUD.git' # https://github.com/SVProgressHUD/SVProgressHUD
  pod 'MJRefresh' # https://github.com/CoderMJLee/MJRefresh

  # Firebase
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
      if target.name == 'RxSwift'
        target.build_configurations.each do |config|
          if config.name == 'Debug'
            config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
          end
        end
      end
    end
end
