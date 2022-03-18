for %%i in ("%cd%") do set lib_name=%%~ni

mkdir build_win32 & pushd build_win32 
cmake -G "Visual Studio 15 2017"  ..
popd
cmake --build build_win32 --config Release
mkdir output\x86
copy /Y build_win32\Release\%lib_name%.dll output\x86\%lib_name%.dll
copy /Y build_win32\Release\%lib_name%.lib output\x86\%lib_name%.lib
