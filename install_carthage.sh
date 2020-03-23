xcodegen generate --spec project_carthage.yml
carthage update --platform iOS --no-use-binaries --configuration Debug --cache-builds
