#!/usr/bin/env bash
 
# Install JSON tool
echo "Install jq"
brew install jq 
 
# Install Cocoapods-keys
echo "Installing gems"
bundle install 

echo "Setting secrets"
cd $APPCENTER_SOURCE_DIRECTORY
bundle exec pod keys set "GoogleAdMobKey" "$GoogleAd" AgeInfo
bundle exec pod keys set "RapidAPIKey" "$RapidApi" AgeInfo
bundle exec pod keys set "AppCenterAnalitycs" "$AppCenter" AgeInfo

echo "Installing pods"
bundle exec pod install

echo "Printing keys:"
bundle exec pod keys

echo "Generating secrets files"
bundle exec pod keys generate AgeInfo