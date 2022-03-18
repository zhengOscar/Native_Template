for %%i in ("%cd%") do set lib_name=%%~ni
for /f %%a in ('dir /a:d /b %ANDROID_SDK%\cmake\') do set cmake_version=%%a
set cmake_bin=%ANDROID_SDK%\cmake\%cmake_version%\bin\cmake.exe
set ninja_bin=%ANDROID_SDK%\cmake\%cmake_version%\bin\ninja.exe
set toolchain=%ANDROID_NDK%\build\cmake\android.toolchain.cmake
rem -GAndroid Gradle - Ninja
set generateor="-GKate - Ninja"
set build_param=-DANDROID_NDK=%ANDROID_NDK% -DCMAKE_BUILD_TYPE=Release -DCMAKE_MAKE_PROGRAM=%ninja_bin% -DCMAKE_TOOLCHAIN_FILE=%toolchain% "-DCMAKE_CXX_FLAGS=-std=c++11 -fexceptions"
mkdir build_v7a
%cmake_bin% -H.\ -B.\build_v7a %generateor% -DANDROID_ABI=armeabi-v7a %build_param%
%ninja_bin% -C .\build_v7a
mkdir .\output\Android\Libs\armeabi-v7a
move .\build_v7a\lib%lib_name%.so .\output\Android\Libs\armeabi-v7a\lib%lib_name%.so

mkdir build_android_x86
%cmake_bin% -H.\ -B.\build_android_x86 %generateor% -DANDROID_ABI=x86 %build_param%
%ninja_bin% -C .\build_android_x86
mkdir .\output\Android\Libs\x86
move .\build_android_x86\lib%lib_name%.so .\output\Android\Libs\x86\lib%lib_name%.so

echo "compile success"
pause