xcodegen generate
carthage update --platform iOS --no-use-binaries --configuration Debug --cache-builds
bundle install
bundle exec pod install
