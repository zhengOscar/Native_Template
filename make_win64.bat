for %%i in ("%cd%") do set lib_name=%%~ni

mkdir build_win64 & pushd build_win64 
cmake -G "Visual Studio 15 2017 Win64"  ..
popd
cmake --build build_win64 --config Release
mkdir output\x86_64
copy /Y build_win64\Release\%lib_name%.dll output\x86_64\%lib_name%.dll
copy /Y build_win64\Release\%lib_name%.lib output\x86_64\%lib_name%.lib
