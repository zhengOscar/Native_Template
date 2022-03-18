_path=$(cd `dirname $0`; pwd)
_name="${_path##*/}"

mkdir -p build_ios && cd build_ios
cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/ios.toolchain.cmake -DPLATFORM=OS64 -GXcode ../
cd ..
cmake --build build_ios --config Release
mkdir -p output/iOS/
cp build_ios/Release-iphoneos/lib$_name.a output/iOS/lib$_name.a 

