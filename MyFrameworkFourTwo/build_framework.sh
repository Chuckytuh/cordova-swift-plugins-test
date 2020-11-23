#!/bin/bash
set -e
SWIFT_VERSION=4.2

mkdir -p build/devices
mkdir -p build/simulator
mkdir -p build/universal

xcodebuild clean build \
  -project MyFrameworkFourTwo.xcodeproj \
  -scheme MyFrameworkFourTwo \
  -configuration Release \
  -sdk iphoneos \
  -derivedDataPath derived_data \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  SWIFT_VERSION=${SWIFT_VERSION}

cp -r derived_data/Build/Products/Release-iphoneos/MyFrameworkFourTwo.framework build/devices

xcodebuild clean build \
  -project MyFrameworkFourTwo.xcodeproj \
  -scheme MyFrameworkFourTwo \
  -configuration Release \
  -sdk iphonesimulator \
  -derivedDataPath derived_data \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  SWIFT_VERSION=${SWIFT_VERSION}

cp -r derived_data/Build/Products/Release-iphonesimulator/MyFrameworkFourTwo.framework build/simulator

cp -r build/simulator/MyFrameworkFourTwo.framework build/universal

lipo -remove arm64 build/simulator/MyFrameworkFourTwo.framework/MyFrameworkFourTwo -output build/simulator/MyFrameworkFourTwo.framework/MyFrameworkFourTwo

lipo -create build/simulator/MyFrameworkFourTwo.framework/MyFrameworkFourTwo build/devices/MyFrameworkFourTwo.framework/MyFrameworkFourTwo -output build/universal/MyFrameworkFourTwo.framework/MyFrameworkFourTwo

cp -r build/devices/MyFrameworkFourTwo.framework/Modules/MyFrameworkFourTwo.swiftmodule/* build/universal/MyFrameworkFourTwo.framework/Modules/MyFrameworkFourTwo.swiftmodule/

