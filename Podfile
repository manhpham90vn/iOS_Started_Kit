source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
inhibit_all_warnings!

target 'MyApp' do
  
  use_frameworks!
  
  # Networking
  pod 'Moya/RxSwift' # https://github.com/Moya/Moya

  # Rx Extensions
  pod 'NSObject+Rx', '~> 5.0' # https://github.com/RxSwiftCommunity/NSObject-Rx
  pod 'RxDataSources', '~> 4.0' # https://github.com/RxSwiftCommunity/RxDataSources

  # Tools
  pod 'Reusable' # https://github.com/AliSoftware/Reusable
  pod 'Then'
  pod 'MPDebug', :configurations => ['Debug'] # https://github.com/manhpham90vn/MPDebug
  pod 'Validator' # https://github.com/adamwaite/Validator
  pod 'R.swift'
  
  # Logging
  pod 'XCGLogger', '~> 7.0.1' # https://github.com/DaveWoodCom/XCGLogger

  # UI
  pod 'SVProgressHUD', :git => 'https://github.com/SVProgressHUD/SVProgressHUD.git' # https://github.com/SVProgressHUD/SVProgressHUD
  pod 'MJRefresh' # https://github.com/CoderMJLee/MJRefresh
  pod 'Toast-Swift', '~> 5.0'  # https://github.com/scalessec/Toast-Swift
  
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
