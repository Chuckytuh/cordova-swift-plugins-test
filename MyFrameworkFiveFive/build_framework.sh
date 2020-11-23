#!/bin/bash
set -e
SWIFT_VERSION=5.5

mkdir -p build/devices
mkdir -p build/simulator
mkdir -p build/universal

xcodebuild clean build \
  -project MyFrameworkFiveFive.xcodeproj \
  -scheme MyFrameworkFiveFive \
  -configuration Release \
  -sdk iphoneos \
  -derivedDataPath derived_data \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  SWIFT_VERSION=${SWIFT_VERSION}

cp -r derived_data/Build/Products/Release-iphoneos/MyFrameworkFiveFive.framework build/devices

xcodebuild clean build \
  -project MyFrameworkFiveFive.xcodeproj \
  -scheme MyFrameworkFiveFive \
  -configuration Release \
  -sdk iphonesimulator \
  -derivedDataPath derived_data \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  SWIFT_VERSION=${SWIFT_VERSION}

cp -r derived_data/Build/Products/Release-iphonesimulator/MyFrameworkFiveFive.framework build/simulator

cp -r build/simulator/MyFrameworkFiveFive.framework build/universal

lipo -remove arm64 build/simulator/MyFrameworkFiveFive.framework/MyFrameworkFiveFive -output build/simulator/MyFrameworkFiveFive.framework/MyFrameworkFiveFive

lipo -create build/simulator/MyFrameworkFiveFive.framework/MyFrameworkFiveFive build/devices/MyFrameworkFiveFive.framework/MyFrameworkFiveFive -output build/universal/MyFrameworkFiveFive.framework/MyFrameworkFiveFive

cp -r build/devices/MyFrameworkFiveFive.framework/Modules/MyFrameworkFiveFive.swiftmodule/* build/universal/MyFrameworkFiveFive.framework/Modules/MyFrameworkFiveFive.swiftmodule/

