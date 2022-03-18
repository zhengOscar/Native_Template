_path=$(cd `dirname $0`; pwd)
_name="${_path##*/}"

mkdir -p build_osx && cd build_osx
cmake -GXcode ../
cd ..
cmake --build build_osx --config Release
mkdir -p output/$_name.bundle/Contents/MacOS/
cp build_osx/Release/$_name.bundle/Contents/MacOS/$_name output/$_name.bundle/Contents/MacOS/$_name

