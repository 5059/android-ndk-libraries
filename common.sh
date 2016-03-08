API_LEVEL="18"

HOST="arm-linux-androideabi"

export ANDROID_NDK="$HOME/Library/Android/sdk/ndk-bundle"

export NDK_PLATFORM="$ANDROID_NDK/platforms/android-$API_LEVEL/arch-arm"
export NDK_TOOLCHAIN="$ANDROID_NDK/toolchains/$HOST-4.9/prebuilt/darwin-x86_64"

export CPP="$NDK_TOOLCHAIN/bin/$HOST-cpp --sysroot=$NDK_PLATFORM"
export CC="$NDK_TOOLCHAIN/bin/$HOST-gcc --sysroot=$NDK_PLATFORM"
export CXX="$NDK_TOOLCHAIN/bin/$HOST-g++ --sysroot=$NDK_PLATFORM"
export LD="$NDK_TOOLCHAIN/bin/$HOST-ld --sysroot=$NDK_PLATFORM"
export AR="$NDK_TOOLCHAIN/bin/$HOST-ar"
export RANLIB="$NDK_TOOLCHAIN/bin/$HOST-ranlib"

COMMON_CFLAGS="-march=armv7-a -mfpu=vfpv3-d16 -mfloat-abi=softfp -mthumb -DANDROID -DANDROID_NDK -I$ANDROID_NDK/sources/android/support/include"

export CFLAGS="$COMMON_CFLAGS -std=c99"
export CXXFLAGS="$COMMON_CFLAGS -std=c++11 -I$ANDROID_NDK/sources/cxx-stl/llvm-libc++/libcxx/include -I$ANDROID_NDK/sources/cxx-stl/gabi++/include"
export LDFLAGS="-L$ANDROID_NDK/sources/cxx-stl/llvm-libc++/libs/armeabi-v7a -lc++_shared"
