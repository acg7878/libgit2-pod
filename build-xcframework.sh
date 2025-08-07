#!/bin/sh

set -x

cd libgit2

# Set the path to the toolchain file
TOOLCHAIN_FILE=$(pwd)/../ios.toolchain.cmake

# Download the toolchain file if it doesn't exist
if [ ! -f "$TOOLCHAIN_FILE" ]; then
    echo "Downloading toolchain file..."
    curl -L https://raw.githubusercontent.com/leetal/ios-cmake/master/ios.toolchain.cmake -o "$TOOLCHAIN_FILE"
    echo "Toolchain file downloaded."
fi

# Clean up previous builds
rm -rf ../build
rm -rf ../libgit2.xcframework

# Build for iOS (arm64)
cmake -G Xcode -B ../build/ios-arm64 \
    -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" \
    -DPLATFORM=OS64 \
    -DDEPLOYMENT_TARGET=12.0 \
    -DBUILD_SHARED_LIBS=OFF \
    -DBUILD_CLAR=OFF \
    .
cmake --build ../build/ios-arm64 --target libgit2

# Build for iOS Simulator (x86_64)
cmake -G Xcode -B ../build/ios-sim-x86_64 \
    -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" \
    -DPLATFORM=SIMULATOR64 \
    -DDEPLOYMENT_TARGET=12.0 \
    -DBUILD_SHARED_LIBS=OFF \
    -DBUILD_CLAR=OFF \
    .
cmake --build ../build/ios-sim-x86_64 --target libgit2

# Build for iOS Simulator (arm64)
cmake -G Xcode -B ../build/ios-sim-arm64 \
    -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" \
    -DPLATFORM=SIMULATORARM64 \
    -DDEPLOYMENT_TARGET=12.0 \
    -DBUILD_SHARED_LIBS=OFF \
    -DBUILD_CLAR=OFF \
    .
cmake --build ../build/ios-sim-arm64 --target libgit2

# Create universal library for iOS Simulator
lipo -create \
    ../build/ios-sim-x86_64/build/libgit2.build/Debug-iphonesimulator/liblibgit2.a \
    ../build/ios-sim-arm64/build/libgit2.build/Debug-iphonesimulator/liblibgit2.a \
    -output ../build/libgit2-ios-sim.a

# Create the XCFramework
xcodebuild -create-xcframework \
    -library ../build/ios-arm64/build/libgit2.build/Debug-iphoneos/liblibgit2.a -headers include \
    -library ../build/libgit2-ios-sim.a -headers include \
    -output ../libgit2.xcframework

echo "Successfully created libgit2.xcframework for iOS"
