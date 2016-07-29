#!/bin/bash

# Go into the Crypto++ directory
pushd `dirname $0`/cryptopp > /dev/null

MAKE="make -f GNUmakefile-cross"

# First, build ARMv7
echo "****************************************"
. ./setenv-ios.sh iphoneos armv7
$MAKE clean
$MAKE static
mkdir armv7
\cp libcryptopp.a armv7/libcryptopp.a

# Second, build ARMv7s
echo "****************************************"
. ./setenv-ios.sh iphoneos armv7s
$MAKE clean
$MAKE static
mkdir armv7s
\cp libcryptopp.a armv7s/libcryptopp.a

# Third, build ARM64
echo "****************************************"
. ./setenv-ios.sh iphoneos arm64
$MAKE clean
# workaround for failing arm64 build:
CXXFLAGS="-DCRYPTOPP_BOOL_ARM_CRC32_INTRINSICS_AVAILABLE=0" $MAKE static
mkdir arm64
\cp libcryptopp.a arm64/libcryptopp.a

# Fourth, build i386 (32-bit simulators)
echo "****************************************"
. ./setenv-ios.sh iphonesimulator i386
$MAKE clean
$MAKE static
mkdir i386
\cp libcryptopp.a i386/libcryptopp.a

# Fifth, build x86_64 (64-bit simulators)
echo "****************************************"
. ./setenv-ios.sh iphonesimulator x86_64
$MAKE clean
$MAKE static
mkdir x86_64
\cp libcryptopp.a x86_64/libcryptopp.a

# Sixth, create the fat library
echo "****************************************"
$MAKE clean
lipo -create armv7/libcryptopp.a armv7s/libcryptopp.a arm64/libcryptopp.a i386/libcryptopp.a x86_64/libcryptopp.a -output ./libcryptopp.a

# Seventh, verify the four architectures are present
echo "****************************************"
xcrun -sdk iphoneos lipo -info libcryptopp.a

# Eighth, remove unneeded artifacts
echo "****************************************"
rm *.so *.exe *.dylib

# Return to previous directory
popd > /dev/null
