xcodegen generate
carthage update --platform iOS --no-use-binaries --configuration Debug
bundle install
bundle exec pod install
