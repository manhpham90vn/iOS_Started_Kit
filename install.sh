killall Xcode
rm -rf R.generated.swift
xcodegen generate
bundle exec pod install
xed .
