platform :ios, '10.0'

target 'MyApp' do
  
  use_frameworks!
  inhibit_all_warnings!
  
  # Networking
  pod 'Moya/RxSwift' # https://github.com/Moya/Moya
  
  # Rx Extensions
  pod 'RxSwift', '~> 5' # https://github.com/ReactiveX/RxSwift
  pod 'RxCocoa', '~> 5'
  pod 'NSObject+Rx', '~> 5.0' # https://github.com/RxSwiftCommunity/NSObject-Rx
  
  # Tools
  pod 'Reusable' # https://github.com/AliSoftware/Reusable
  pod 'Then' # https://github.com/devxoul/Then
  pod 'Validator' # https://github.com/adamwaite/Validator
  
  # Logging
  pod 'XCGLogger', '~> 7.0.1' # https://github.com/DaveWoodCom/XCGLogger
  
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
